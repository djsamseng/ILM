//
//  ILMLotterySummaryTableViewCell.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/27/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMLotterySummaryTableViewCell.h"

@interface ILMLotterySummaryTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


@end

@implementation ILMLotterySummaryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellTitle:(NSString *)title subTitle:(NSString *)subTitle fraction:(NSNumber *)fraction
{
    [self.titleLabel setText:title];
    [self.subTitleLabel setText:subTitle];
    [self.percentLabel setText:[NSString stringWithFormat:@"%.0f%%", fraction.floatValue * 100]];
    [self.progressView setProgress:fraction.floatValue];
}

@end
