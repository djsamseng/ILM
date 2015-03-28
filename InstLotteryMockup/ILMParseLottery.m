//
//  ILMParseLottery.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/24/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMParseLottery.h"
#import <Parse/PFObject+Subclass.h>

@implementation ILMParseLottery

+ (void)load
{
    [self registerSubclass];
}

+ (NSString *)parseClassName
{
    return @"ParseLottery";
}

@dynamic submissions;
@dynamic lotterySize;
@dynamic lotteryCategory;
@dynamic lotteryWinner;
@dynamic winningPicture;

@end
