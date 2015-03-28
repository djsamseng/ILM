//
//  ILMInstagram.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMInstagram.h"
#import "ILMWebService.h"
#import "ILMLoginWebViewController.h"
#import "ILMProfileViewController.h"
#import "ILMBuyCoinsViewController.h"
#import "ILMLoginWebViewController.h"
#import "ILMParseUser.h"

@interface ILMInstagram()
@property (nonatomic) BOOL loaded;
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) ILMParseUser *parseUser;

@end

@implementation ILMInstagram

- (NSString *)userName
{
    ILMParseUser *parseUser = (ILMParseUser *)[PFUser currentUser];
    return parseUser.instagramUserName;
}

- (NSString *)fullName
{
    ILMParseUser *parseUser = (ILMParseUser *)[PFUser currentUser];
    return parseUser.fullName;
}

- (NSNumber *)coins
{
    ILMParseUser *parseUser = (ILMParseUser *)[PFUser currentUser];
    return parseUser.coins;
}

- (void)didReceiveResponse:(NSData *)response {
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    NSDictionary *data = jsonResponse[@"data"];

    _profilePicture = data[@"profile_picture"];
    _bio = data[@"bio"];
    _website = data[@"website"];
    
    _following = [data[@"counts"][@"follows"] stringValue];
    _followers = [data[@"counts"][@"followed_by"] stringValue];
    
    PFQuery *query = [ILMParseUser query];
    [query whereKey:@"username" equalTo:data[@"id"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 1 && [[objects objectAtIndex:0] isKindOfClass:[ILMParseUser class]])
        {
            [self loginParseUser:data[@"id"]];
        }
        else
        {
            ILMParseUser *user = [[ILMParseUser alloc] init];
            user.username = data[@"id"];
            user.password = @"";
            user.instagramUserName = data[@"username"];
            user.fullName = data[@"full_name"];
            user.coins = [NSNumber numberWithInt:0];
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded)
                {
                    self.loaded = YES;
                    [(ILMProfileViewController *)self.delegate profileNeedsRefresh];
                }
                else
                {
                    @throw [NSException exceptionWithName:@"Not Implemented" reason:@"Sign up failure not implemented" userInfo:nil];
                }
            }];
        }
    }];
}

- (void)didReceiveURLResponse:(NSURLRequest *)response
{
    NSString *responseURL = [response.URL absoluteString];
    NSString *responsePrefix = @"http://google.com/#access_token=";
    NSString *failedResponsePrefix = @"http://google.com/";
    if ([responseURL hasPrefix:responsePrefix])
    {
        NSString *accessToken = [responseURL substringFromIndex: [responsePrefix length]];
        self.accessToken = accessToken;
        [self loadProfileWithForce:NO];
    }
    else if ([responseURL hasPrefix:failedResponsePrefix])
    {
        //Need to show login web view controller
        ILMLoginWebViewController *lvc = [[ILMLoginWebViewController alloc] init];
        lvc.delegate = self;
        [((ILMProfileViewController *)self.delegate) presentViewController:lvc animated:YES completion:nil];
    }
}

- (void)loginInstagramUser
{
    ILMWebService *webService = [[ILMWebService alloc] init];
    webService.delegate = self;
    [webService loadPageForResponse:@"https://instagram.com/oauth/authorize/?client_id=b85fcc9a32274cd88882aa759c165895&redirect_uri=http://google.com&response_type=token"];
}

- (void)loginParseUser:(NSString *)userId
{
    [PFUser logInWithUsernameInBackground:userId password:@"" block:^(PFUser *user, NSError *error) {
        if (user)
        {
            //Successful login
            self.loaded = YES;
            [(ILMProfileViewController *)self.delegate profileNeedsRefresh];
        }
        else
        {
            //Login failed
            @throw [NSException exceptionWithName:@"Not Implemented" reason:@"Login failed not implemented" userInfo:nil];
        }
    }];
}

- (void)loadProfileWithForce:(BOOL)force {
    if (!force && self.loaded)
    {
        //do nothing
        return;
    }
    else if (!self.accessToken || self.accessToken.length == 0)
    {
        [self loginInstagramUser];
        return;
    }
    else
    {
        ILMWebService *webService = [[ILMWebService alloc] init];
        webService.delegate = self;
        NSString *requestString = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/?access_token=%@", self.accessToken];
        [webService request:requestString];
    }
}

- (void)setAccessToken:(NSString *)accessToken {
    _accessToken = [NSString stringWithFormat:@"%@", accessToken];
}

- (BOOL)hasAccessToken {
    if (self.accessToken && self.accessToken.length > 0)
    {
        return YES;
    }
    return NO;
}

- (void)purchaseCoins:(int)numCoins
{
    ILMParseUser *currentUser = [ILMParseUser currentUser];
    currentUser.coins = [NSNumber numberWithInt:[currentUser.coins intValue] + numCoins];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ILMBuyCoinsViewController *bcvc = (ILMBuyCoinsViewController *)self.purchaseCoinsDelegate;
            [bcvc purchaseCompleteWithSuccess:succeeded];
        });
    }];
}

+ (instancetype)sharedInstagram {
    static ILMInstagram *sharedInstagram;
    @synchronized(self) {
        if (!sharedInstagram) {
            sharedInstagram = [[self alloc] initPrivate];
        }
    }
    return sharedInstagram;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        self.loaded = false;
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"User sharedInstagram" userInfo:nil];
    return nil;
}




@end
