//
//  WebService.h
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebRequestResponseDelegate <NSObject>

- (void)didReceiveResponse:(NSData *)response;
- (void)didReceiveURLResponse:(NSURLRequest *)response;

@end

@interface ILMWebService : NSObject <NSURLConnectionDataDelegate>


@property (strong, nonatomic) NSString *accessToken;

@property (assign, nonatomic) id<WebRequestResponseDelegate> delegate;

- (void)request:(NSString *)requestString;

- (void)loadPageForResponse:(NSString *)requesetString;

- (void)requestImage:(NSString *)requestString;

@end
