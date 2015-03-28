//
//  ILMParseLottery.h
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/24/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import <Parse/Parse.h>

@interface ILMParseLottery : PFObject <PFSubclassing>

@property (strong, nonatomic) NSMutableDictionary *submissions;//Indexed by userId
@property (strong, nonatomic) NSNumber *lotterySize;
@property (strong, nonatomic) NSString *lotteryCategory;
@property (strong, nonatomic) NSString *lotteryWinner;
@property (strong, nonatomic) NSString *winningPicture;

+ (NSString *)parseClassName;

@end
