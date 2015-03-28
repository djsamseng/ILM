//
//  ILMParseUser.h
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/24/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import <Parse/Parse.h>



@interface ILMParseUser : PFUser <PFSubclassing>

@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *instagramUserName;
@property (strong, nonatomic) NSMutableDictionary *lotteries;
@property (nonatomic, assign) NSNumber *coins;

@end
