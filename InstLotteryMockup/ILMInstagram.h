//
//  ILMInstagram.h
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILMWebService.h"

@protocol InstagramAPIProtocol <NSObject>

- (void)profileNeedsRefresh;

@end

@protocol PurchaseCoinsProtocol <NSObject>

- (void)purchaseCompleteWithSuccess:(BOOL)success;

@end

@interface ILMInstagram : NSObject <WebRequestResponseDelegate>

//parseUser accessed from [ILMParseUser currentUser];

@property (strong, nonatomic, readonly) NSString *bio;
@property (strong, nonatomic, readonly) NSString *website;
@property (strong, nonatomic, readonly) NSString *profilePicture;
@property (strong, nonatomic, readonly) NSString *followers;
@property (strong, nonatomic, readonly) NSString *following;



@property (assign, nonatomic) id<InstagramAPIProtocol> delegate;
@property (assign, nonatomic) id<PurchaseCoinsProtocol> purchaseCoinsDelegate;

+ (instancetype)sharedInstagram;

- (void)loginInstagramUser;

- (void)loadProfileWithForce: (BOOL)force;

- (void)setAccessToken:(NSString *)accessToken;

- (BOOL)hasAccessToken;

- (void)purchaseCoins:(int)numCoins;

- (NSString *)userName;
- (NSString *)fullName;
- (NSNumber *)coins;

@end
