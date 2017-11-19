//
//  SceneActionListCell.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "SceneActionListCell.h"

@interface SceneActionListCell ()

@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *infoLabel;

@end

@implementation SceneActionListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initView
{
    [self.contentView addSubview:self.line];
//    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.infoLabel];
    
//    self.line.frame = CGRectMake(MainW/2, 0, 1, 75);
//    self.timeLabel.frame = CGRectMake((MainW-30)/2, 5, 30, 30);
    self.line.frame = CGRectMake(MainW/2, 0, 1, 5+33+5);
}

- (void)refreshCellWithInfo:(NSString *)info isLeft:(BOOL)isLeft
{
//    self.timeLabel.text = @"0.5s";
    self.infoLabel.text = info;
    if (isLeft) {
        self.infoLabel.textAlignment = NSTextAlignmentLeft;
//        self.infoLabel.frame = CGRectMake((MainW/2-150)/2, 5+30+6, 150, 33);
        self.infoLabel.frame = CGRectMake((MainW/2-150)/2, 5, 150, 33);
    }
    else {
        self.infoLabel.textAlignment = NSTextAlignmentRight;
//        self.infoLabel.frame = CGRectMake(MainW-(MainW/2-150)/2-150, 5+30+6, 150, 33);
        self.infoLabel.frame = CGRectMake(MainW-(MainW/2-150)/2-150, 5, 150, 33);
    }
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor blackColor];
    }
    return _line;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        _timeLabel.userInteractionEnabled = YES;
        _timeLabel.layer.cornerRadius = 15;
        _timeLabel.layer.masksToBounds = YES;
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _timeLabel;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor whiteColor];
        _infoLabel.userInteractionEnabled = YES;
        _infoLabel.layer.cornerRadius = 15;
        _infoLabel.layer.masksToBounds = YES;
        
        _infoLabel.font = [UIFont systemFontOfSize:14];
    }
    return _infoLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
