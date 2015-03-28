//
//  ILMLoginWebViewController.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMLoginWebViewController.h"



@interface ILMLoginWebViewController()

@property (strong, nonatomic) NSURL *url;

@end

@implementation ILMLoginWebViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.url = [NSURL URLWithString:@"https://instagram.com/oauth/authorize/?client_id=b85fcc9a32274cd88882aa759c165895&redirect_uri=http://google.com&response_type=token"];
    }
    return self;
}

- (void)loadView
{
    UIWebView *webview = [[UIWebView alloc] init];
    webview.scalesPageToFit = YES;
    webview.delegate = self;
    self.view = webview;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [(UIWebView *)webview loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *responseURL = [request.URL absoluteString];
    NSLog(@"%@", responseURL);
    NSString *responsePrefix = @"http://google.com/#access_token=";
    if ([responseURL hasPrefix:responsePrefix])
    {
        NSString *accessToken = [responseURL substringFromIndex: [responsePrefix length]];
        NSLog(@"Access Token: %@", accessToken);
        
        [self.delegate setAccessToken:accessToken];
        
        [self.delegate loadProfileWithForce:NO];
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
}

@end
