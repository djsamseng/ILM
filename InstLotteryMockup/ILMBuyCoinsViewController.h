//
//  ILMBuyCoinsViewController.h
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/25/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILMInstagram.h"

@interface ILMBuyCoinsViewController : UIViewController <PurchaseCoinsProtocol>

@property (assign, nonatomic) id<InstagramAPIProtocol> delegate;

@end
