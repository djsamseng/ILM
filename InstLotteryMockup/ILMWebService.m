//
//  WebService.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMWebService.h"

@interface ILMWebService()

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation ILMWebService

- (void)request:(NSString *)requestString
{
    NSURL *requestURL = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didReceiveResponse:data];
            });
    }];
    [dataTask resume];
}

- (void)loadPageForResponse:(NSString *)requestString
{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [connection start];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    [self.delegate didReceiveURLResponse:request];
    return request;
}

- (void)requestImage:(NSString *)requestString
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
    }
    return self;
}

@end
