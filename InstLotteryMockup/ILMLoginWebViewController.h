//
//  ILMLoginWebViewController.h
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ILMInstagram.h"

@interface ILMLoginWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, assign) ILMInstagram *delegate;

@end
