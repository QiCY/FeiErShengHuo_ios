//
//  FEEnvironmentaLDetectorView.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEEnvironmentaLDetectorView.h"

@interface FEEnvironmentaLDetectorView ()

@property (nonatomic,strong) UIImageView *titleImageView;

@property (nonatomic,strong) UIImageView *mainImageView;
@property (nonatomic,strong) UIView *centerView;
@property (nonatomic,strong) UIView *leftTopView;
@property (nonatomic,strong) UIView *rightTopView;
@property (nonatomic,strong) UIView *leftBottomView;
@property (nonatomic,strong) UIView *rightBottomView;

@property (nonatomic,strong) UIImageView *centerIconView;
@property (nonatomic,strong) UILabel *centerStatusLabel;
@property (nonatomic,strong) UILabel *centerTitleLabel;

@property (nonatomic,strong) UIImageView *leftTopIconView;
@property (nonatomic,strong) UILabel *leftTopStatusLabel;
@property (nonatomic,strong) UILabel *leftTopTitleLabel;

@property (nonatomic,strong) UIImageView *rightTopIconView;
@property (nonatomic,strong) UILabel *rightTopStatusLabel;
@property (nonatomic,strong) UILabel *rightTopTitleLabel;

@property (nonatomic,strong) UIImageView *leftBottomIconView;
@property (nonatomic,strong) UILabel *leftBottomStatusLabel;
@property (nonatomic,strong) UILabel *leftBottomTitleLabel;

@property (nonatomic,strong) UIImageView *rightBottomIconView;
@property (nonatomic,strong) UILabel *rightBottomStatusLabel;
@property (nonatomic,strong) UILabel *rightBottomTitleLabel;

@end

@implementation FEEnvironmentaLDetectorView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview:self.titleImageView];
    
    [self addSubview:self.mainImageView];
    [self.mainImageView addSubview:self.centerView];
    [self.mainImageView addSubview:self.leftTopView];
    [self.mainImageView addSubview:self.rightTopView];
    [self.mainImageView addSubview:self.leftBottomView];
    [self.mainImageView addSubview:self.rightBottomView];
    
    [self.centerView addSubview:self.centerIconView];
    [self.centerView addSubview:self.centerStatusLabel];
    [self.centerView addSubview:self.centerTitleLabel];
    
    @weakify(self);
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(32);
        make.size.mas_equalTo(CGSizeMake(567/2, 106/2));
    }];
    
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(585/2, 619/2));
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self.mainImageView);
        make.centerY.mas_equalTo(self.mainImageView).offset(-12);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [self.leftTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.mas_equalTo(self.mainImageView);
        make.size.mas_equalTo(CGSizeMake(585/4, 619/4));
    }];
    
    [self.rightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.top.mas_equalTo(self.mainImageView);
        make.size.mas_equalTo(CGSizeMake(585/4, 619/4));
    }];
    
    [self.leftBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.bottom.mas_equalTo(self.mainImageView);
        make.size.mas_equalTo(CGSizeMake(585/4, 619/4));
    }];
    
    [self.rightBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.bottom.mas_equalTo(self.mainImageView);
        make.size.mas_equalTo(CGSizeMake(585/4, 619/4));
    }];
    
    [self.centerIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self.centerView);
        make.top.mas_equalTo(self.centerView).offset(12);
        make.size.mas_equalTo(CGSizeMake(39/2, 38/2));
    }];
    
    [self.centerStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.mas_equalTo(self.centerView);
    }];
    
    [self.centerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self.centerView);
        make.bottom.mas_equalTo(self.centerView).offset(-16);
    }];
    
    [self makeConstraintWithSuperView:self.leftTopView iconView:self.leftTopIconView iconSize:CGSizeMake(19/2, 26/2) statusLabel:self.leftTopStatusLabel titleLabel:self.leftTopTitleLabel];
    [self makeConstraintWithSuperView:self.rightTopView iconView:self.rightTopIconView iconSize:CGSizeMake(25/2, 22/2) statusLabel:self.rightTopStatusLabel titleLabel:self.rightTopTitleLabel];
    [self makeConstraintWithSuperView:self.leftBottomView iconView:self.leftBottomIconView iconSize:CGSizeMake(27/2, 26/2) statusLabel:self.leftBottomStatusLabel titleLabel:self.leftBottomTitleLabel];
    [self makeConstraintWithSuperView:self.rightBottomView iconView:self.rightBottomIconView iconSize:CGSizeMake(26/2, 24/2) statusLabel:self.rightBottomStatusLabel titleLabel:self.rightBottomTitleLabel];
}

- (void)refreshViewWithTemperature:(NSString *)temperature humidity:(NSString *)humidity light:(NSString *)light air:(NSString *)air noisy:(NSString *)noisy
{
    temperature ? self.rightTopStatusLabel.text = [NSString stringWithFormat:@"%@℃",temperature] : nil;
    humidity ? self.leftTopStatusLabel.text = [NSString stringWithFormat:@"%@%%",humidity] : nil;
    light ? self.leftBottomStatusLabel.text = light : nil;
    air ? self.centerStatusLabel.text = air : nil;
    noisy ? self.rightBottomStatusLabel.text = noisy : nil;
}

- (void)makeConstraintWithSuperView:(UIView *)superView iconView:(UIImageView *)iconView iconSize:(CGSize)iconSize statusLabel:(UILabel *)statusLabel titleLabel:(UILabel *)titleLabel
{
    [superView addSubview:iconView];
    [superView addSubview:statusLabel];
    [superView addSubview:titleLabel];
    
    @weakify(superView);
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(superView);
        make.size.mas_equalTo(iconSize);
        make.centerX.mas_equalTo(superView);
        make.centerY.mas_equalTo(superView).offset(-21);
    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(superView);
        make.center.mas_equalTo(superView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(superView);
        make.centerX.mas_equalTo(superView);
        make.centerY.mas_equalTo(superView).offset(24);
    }];
}

- (UILabel *)normalLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = font;
    
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return label;
}

- (UIImageView *)titleImageView
{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_title"]];
    }
    return _titleImageView;
}

- (UIImageView *)mainImageView
{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_four"]];
    }
    return _mainImageView;
}

- (UIView *)centerView
{
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
    }
    return _centerView;
}

- (UIView *)leftTopView
{
    if (!_leftTopView) {
        _leftTopView = [[UIView alloc] init];
    }
    return _leftTopView;
}

- (UIView *)rightTopView
{
    if (!_rightTopView) {
        _rightTopView = [[UIView alloc] init];
    }
    return _rightTopView;
}

- (UIView *)leftBottomView
{
    if (!_leftBottomView) {
        _leftBottomView = [[UIView alloc] init];
    }
    return _leftBottomView;
}

- (UIView *)rightBottomView
{
    if (!_rightBottomView) {
        _rightBottomView = [[UIView alloc] init];
    }
    return _rightBottomView;
}

- (UIImageView *)centerIconView
{
    if (!_centerIconView) {
        _centerIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_qua1"]];
    }
    return _centerIconView;
}

- (UILabel *)centerStatusLabel
{
    if (!_centerStatusLabel) {
        _centerStatusLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:31] textColor:Green_Color];
    }
    return _centerStatusLabel;
}

- (UILabel *)centerTitleLabel
{
    if (!_centerTitleLabel) {
        _centerTitleLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor]];
        _centerTitleLabel.text = @"空气质量";
    }
    return _centerTitleLabel;
}

- (UIImageView *)leftTopIconView
{
    if (!_leftTopIconView) {
        _leftTopIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_hum1"]];
    }
    return _leftTopIconView;
}

- (UILabel *)leftTopStatusLabel
{
    if (!_leftTopStatusLabel) {
        _leftTopStatusLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:16] textColor:RGB(77, 176, 175)];
    }
    return _leftTopStatusLabel;
}

- (UILabel *)leftTopTitleLabel
{
    if (!_leftTopTitleLabel) {
        _leftTopTitleLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:12] textColor:[UIColor blackColor]];
        _leftTopTitleLabel.text = @"湿度";
    }
    return _leftTopTitleLabel;
}

- (UIImageView *)rightTopIconView
{
    if (!_rightTopIconView) {
        _rightTopIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_tem1"]];
    }
    return _rightTopIconView;
}

- (UILabel *)rightTopStatusLabel
{
    if (!_rightTopStatusLabel) {
        _rightTopStatusLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:16] textColor:RGB(251, 72, 11)];
    }
    return _rightTopStatusLabel;
}

- (UILabel *)rightTopTitleLabel
{
    if (!_rightTopTitleLabel) {
        _rightTopTitleLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:12] textColor:[UIColor blackColor]];
        _rightTopTitleLabel.text = @"温度";
    }
    return _rightTopTitleLabel;
}

- (UIImageView *)leftBottomIconView
{
    if (!_leftBottomIconView) {
        _leftBottomIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_lll1"]];
    }
    return _leftBottomIconView;
}

- (UILabel *)leftBottomStatusLabel
{
    if (!_leftBottomStatusLabel) {
        _leftBottomStatusLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:16] textColor:RGB(232, 85, 113)];
    }
    return _leftBottomStatusLabel;
}

- (UILabel *)leftBottomTitleLabel
{
    if (!_leftBottomTitleLabel) {
        _leftBottomTitleLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:12] textColor:[UIColor blackColor]];
        _leftBottomTitleLabel.text = @"光照";
    }
    return _leftBottomTitleLabel;
}


- (UIImageView *)rightBottomIconView
{
    if (!_rightBottomIconView) {
        _rightBottomIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_voi1"]];
    }
    return _rightBottomIconView;
}

- (UILabel *)rightBottomStatusLabel
{
    if (!_rightBottomStatusLabel) {
        _rightBottomStatusLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:16] textColor:RGB(241, 161, 40)];
    }
    return _rightBottomStatusLabel;
}

- (UILabel *)rightBottomTitleLabel
{
    if (!_rightBottomTitleLabel) {
        _rightBottomTitleLabel = [self normalLabelWithFont:[UIFont boldSystemFontOfSize:12] textColor:[UIColor blackColor]];
        _rightBottomTitleLabel.text = @"声音";
    }
    return _rightBottomTitleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
