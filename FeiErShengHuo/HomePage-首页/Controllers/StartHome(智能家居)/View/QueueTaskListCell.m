//
//  QueueTaskListCell.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/8.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "QueueTaskListCell.h"
#import "QueueTaskSetHelper.h"

@interface QueueTaskListCell ()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *cycleLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation QueueTaskListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.cycleLabel];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(12, 12, 36, 36);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+12, 12, 100, 16);
    self.cycleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+12, CGRectGetHeight(self.frame)-12-16, 100, 16);
    self.timeLabel.frame = CGRectMake(100+12+36, 12, 250, 16);
}

- (void)refreshCellWithTaskInfo:(NSDictionary *)taskInfo
{
    self.titleLabel.text = @"定时";
    self.cycleLabel.text = [QueueTaskSetHelper showCycle:taskInfo[QueueTaskCycleKey]];
    
    NSString *starStr=taskInfo[QueueTaskStartTimeKey];
    NSString *endStr=taskInfo[QueueTaskEndTimeKey];
    
    NSString *start1=[starStr substringWithRange:NSMakeRange(0, 2)];
    NSString *start2=[starStr substringWithRange:NSMakeRange(2, 2)];
    NSString *start3=[starStr substringWithRange:NSMakeRange(4, 2)];
    
    NSString *starTT=[NSString stringWithFormat:@"%@时%@分%@秒",start1,start2,start3];
    
    
    NSString *end1=[endStr substringWithRange:NSMakeRange(0, 2)];
    NSString *end2=[endStr substringWithRange:NSMakeRange(2, 2)];
    NSString *end3=[endStr substringWithRange:NSMakeRange(4, 2)];
    
    NSString  *endTT=[NSString stringWithFormat:@"%@时%@分%@秒",end1,end2,end3];
    self.timeLabel.text=[NSString stringWithFormat:@"%@-%@",starTT,endTT];
    
    
//    self.timeLabel.text = [NSString stringWithFormat:@"%@ - %@",taskInfo[QueueTaskStartTimeKey], taskInfo[QueueTaskEndTimeKey]];
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor redColor];
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blueColor];
    }
    return _titleLabel;
}

- (UILabel *)cycleLabel
{
    if (!_cycleLabel) {
        _cycleLabel = [[UILabel alloc] init];
        _cycleLabel.backgroundColor = [UIColor whiteColor];
        _cycleLabel.font = [UIFont systemFontOfSize:14];
        _cycleLabel.textColor = [UIColor blackColor];
    }
    return _cycleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor blackColor];
    }
    return _timeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
