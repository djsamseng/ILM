//
//  ILMParseUser.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/24/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMParseUser.h"
#import <Parse/PFObject+Subclass.h>

@implementation ILMParseUser

+ (void)load
{
    [self registerSubclass];
}

@dynamic fullName;
@dynamic coins;
@dynamic lotteries;
@dynamic instagramUserName;


@end
