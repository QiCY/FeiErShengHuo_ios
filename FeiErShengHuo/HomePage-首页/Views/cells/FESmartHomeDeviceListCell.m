//
//  FESmaetHomeDeviceListCell.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESmartHomeDeviceListCell.h"

@interface FESmartHomeDeviceListCell ()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation FESmartHomeDeviceListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)refreshCellWithDevice:(BLDNADevice *)device
{
    self.iconView.image = [UIImage imageNamed:[[BroadLinkHelper sharedBroadLinkHelper] bl_showSmartHomeDeviceIconName:device]];
    self.nameLabel.text = device.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake((CGRectGetWidth(self.frame) - (CGRectGetHeight(self.frame)-10*2-25))/2, 10, CGRectGetHeight(self.frame)-10*2-25, CGRectGetHeight(self.frame)-10*2-25);
    self.nameLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame)-25, CGRectGetWidth(self.frame), 25);
    
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = (CGRectGetHeight(self.frame)-10*2-25)/2;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor blackColor];

        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
@end
