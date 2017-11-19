//
//  FEDeviceListCell.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEDeviceListCell.h"

@interface FEDeviceListCell ()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *macLabel;

@property (nonatomic,strong) UIImageView *RSSIView;

@end

@implementation FEDeviceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.macLabel];
//    [self.contentView addSubview:self.RSSIView];
}

- (void)refreshCellWithDevice:(BLDNADevice *)device
{
    //  图标
    self.iconView.image = [UIImage imageNamed:[[BroadLinkHelper sharedBroadLinkHelper] bl_showSmartHomeDeviceIconName:device]];
    
    //  名字
    self.nameLabel.text = device.name;
    
    //  mac地址
    self.macLabel.text = device.mac;
    
    //  状态？
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(7, 7, 50, 50);
    self.nameLabel.frame = CGRectMake(50+7+7, 10, 100, 20);
    self.macLabel.frame = CGRectMake(50+7+7, 64-20-10, 200, 20);
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UILabel *)macLabel
{
    if (!_macLabel) {
        _macLabel = [[UILabel alloc] init];
        _macLabel.backgroundColor = [UIColor clearColor];
        _macLabel.font = [UIFont systemFontOfSize:14];
    }
    return _macLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
