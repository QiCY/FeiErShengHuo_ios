//
//  FEFourPositionSocketView.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEFourPositionSocketView.h"

@interface FEFourPositionSocketView ()

@property (nonatomic,strong) UIImageView *mainSocketView;

@property (nonatomic,strong) UIView *itemView1;
@property (nonatomic,strong) UIView *itemView2;
@property (nonatomic,strong) UIView *itemView3;
@property (nonatomic,strong) UIView *itemView4;

@property (nonatomic,strong) UIImageView *socket1ItemView;
@property (nonatomic,strong) UIImageView *socket2ItemView;
@property (nonatomic,strong) UIImageView *socket3ItemView;
@property (nonatomic,strong) UIImageView *socket4ItemView;

@property (nonatomic,strong) UIButton *socketButton1;
@property (nonatomic,strong) UIButton *socketButton2;
@property (nonatomic,strong) UIButton *socketButton3;
@property (nonatomic,strong) UIButton *socketButton4;
@end

@implementation FEFourPositionSocketView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview:self.mainSocketView];
    [self.mainSocketView addSubview:self.itemView1];
    [self.mainSocketView addSubview:self.itemView2];
    [self.mainSocketView addSubview:self.itemView3];
    [self.mainSocketView addSubview:self.itemView4];
    
    [self.itemView1 addSubview:self.socket1ItemView];
    [self.itemView2 addSubview:self.socket2ItemView];
    [self.itemView3 addSubview:self.socket3ItemView];
    [self.itemView4 addSubview:self.socket4ItemView];
    
    [self addSubview:self.socketButton1];
    [self addSubview:self.socketButton2];
    [self addSubview:self.socketButton3];
    [self addSubview:self.socketButton4];
    
    @weakify(self);
    [self.mainSocketView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self).offset(62-20);
        make.top.mas_equalTo(self).offset(17);
        make.bottom.mas_equalTo(self).offset(-17);
        make.right.mas_equalTo(self).offset(-MainW/2-20);
    }];
    
    [self.itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(self.mainSocketView);
        make.height.mas_equalTo(self.mainSocketView).multipliedBy(0.25);
        make.top.left.right.mas_equalTo(self.mainSocketView);
    }];
    
    [self.itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(self.itemView1);
        make.top.mas_equalTo(self.itemView1.mas_bottom);
        make.centerX.mas_equalTo(self.mainSocketView);
    }];
    
    [self.itemView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(self.itemView1);
        make.top.mas_equalTo(self.itemView2.mas_bottom);
        make.centerX.mas_equalTo(self.mainSocketView);
    }];
    
    [self.itemView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(self.itemView1);
        make.top.mas_equalTo(self.itemView3.mas_bottom);
        make.centerX.mas_equalTo(self.mainSocketView);
    }];
    
    [self.socket1ItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(self.socket1ItemView.mas_height);
        make.bottom.mas_equalTo(self.itemView1).offset(-40);
        make.left.mas_equalTo(self.itemView1).offset(34);
        make.right.mas_equalTo(self.itemView1).offset(-34);
    }];
    
    [self.socket2ItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(self.socket2ItemView.mas_height);
        make.bottom.mas_equalTo(self.itemView2).offset(-40);
        make.left.mas_equalTo(self.itemView2).offset(34);
        make.right.mas_equalTo(self.itemView2).offset(-34);
    }];
    
    [self.socket3ItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(self.socket3ItemView.mas_height);
        make.bottom.mas_equalTo(self.itemView3).offset(-40);
        make.left.mas_equalTo(self.itemView3).offset(34);
        make.right.mas_equalTo(self.itemView3).offset(-34);
    }];
    
    [self.socket4ItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(self.socket4ItemView.mas_height);
        make.bottom.mas_equalTo(self.itemView4).offset(-40);
        make.left.mas_equalTo(self.itemView4).offset(34);
        make.right.mas_equalTo(self.itemView4).offset(-34);
    }];
    
    [self.socketButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(288/2, 95/2));
        make.right.mas_equalTo(self).offset(-21);
        make.centerY.mas_equalTo(self.socket1ItemView);
    }];
    
    [self.socketButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(288/2, 95/2));
        make.right.mas_equalTo(self).offset(-21);
        make.centerY.mas_equalTo(self.socket2ItemView);
    }];
    
    [self.socketButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(288/2, 95/2));
        make.right.mas_equalTo(self).offset(-21);
        make.centerY.mas_equalTo(self.socket3ItemView);
    }];
    
    [self.socketButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(288/2, 95/2));
        make.right.mas_equalTo(self).offset(-21);
        make.centerY.mas_equalTo(self.socket4ItemView);
    }];
}

- (void)setSocket1Selected:(BOOL)socket1Selected
{
    [self setSocketButton:1 targetOn:socket1Selected];
}

- (void)setSocket2Selected:(BOOL)socket2Selected
{
    [self setSocketButton:2 targetOn:socket2Selected];
}

- (void)setSocket3Selected:(BOOL)socket3Selected
{
    [self setSocketButton:3 targetOn:socket3Selected];
}

- (void)setSocket4Selected:(BOOL)socket4Selected
{
    [self setSocketButton:4 targetOn:socket4Selected];
}

- (BOOL)socket1Selected
{
    return self.socketButton1.selected;
}

- (BOOL)socket2Selected
{
    return self.socketButton2.selected;
}

- (BOOL)socket3Selected
{
    return self.socketButton3.selected;
}

- (BOOL)socket4Selected
{
    return self.socketButton4.selected;
}

- (void)setSocket1Enable:(BOOL)socket1Enable
{
    self.socketButton1.enabled = socket1Enable;
}

- (void)setSocket2Enable:(BOOL)socket2Enable
{
    self.socketButton2.enabled = socket2Enable;
}

- (void)setSocket3Enable:(BOOL)socket3Enable
{
    self.socketButton3.enabled = socket3Enable;
}

- (void)setSocket4Enable:(BOOL)socket4Enable
{
    self.socketButton4.enabled = socket4Enable;
}


- (void)refreshStatusWithIndex:(NSInteger)index targetOn:(BOOL)targetOn
{
    [self setSocketButton:index targetOn:targetOn];
}

- (void)setSocketButton:(NSInteger)tag targetOn:(BOOL)targetOn
{
    UIImageView *socketImageView;
    UIButton *socketButton;
    
    if (tag == 1) {
        socketImageView = self.socket1ItemView;
        socketButton = self.socketButton1;
    }
    if (tag == 2) {
        socketImageView = self.socket2ItemView;
        socketButton = self.socketButton2;
    }
    if (tag == 3) {
        socketImageView = self.socket3ItemView;
        socketButton = self.socketButton3;
    }
    if (tag == 4) {
        socketImageView = self.socket4ItemView;
        socketButton = self.socketButton4;
    }
    
    UIImage *socketImageViewImage = targetOn ? [UIImage imageNamed:@"icon_fSocket4"] : [UIImage imageNamed:@"icon_fSocket5"];
    
    socketImageView.image = socketImageViewImage;
    socketButton.selected = targetOn;
}

- (void)socketButtonClick:(UIButton *)button
{
    self.didClickSocketButton ? self.didClickSocketButton(button.tag, !(button.selected)) : nil;
}

- (UIView *)normalItemView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.userInteractionEnabled = YES;
    return view;
}

- (UIImageView *)normalSocketItemView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_fSocket5"]];
    return imageView;
}

- (UIButton *)normalSocketButton:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_four1_1button1-2"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_four1_1button1-1"] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    button.tag = tag;
    [button addTarget:self action:@selector(socketButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIView *)itemView1
{
    if (!_itemView1) {
        _itemView1 = [self normalItemView];
    }
    return _itemView1;
}

- (UIView *)itemView2
{
    if (!_itemView2) {
        _itemView2 = [self normalItemView];
    }
    return _itemView2;
}

- (UIView *)itemView3
{
    if (!_itemView3) {
        _itemView3 = [self normalItemView];
    }
    return _itemView3;
}

- (UIView *)itemView4
{
    if (!_itemView4) {
        _itemView4 = [self normalItemView];
    }
    return _itemView4;
}

- (UIImageView *)mainSocketView
{
    if (!_mainSocketView) {
        _mainSocketView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_fSocket6"]];
    }
    return _mainSocketView;
}

- (UIImageView *)socket1ItemView
{
    if (!_socket1ItemView) {
        _socket1ItemView = [self normalSocketItemView];
    }
    return _socket1ItemView;
}

- (UIImageView *)socket2ItemView
{
    if (!_socket2ItemView) {
        _socket2ItemView = [self normalSocketItemView];
    }
    return _socket2ItemView;
}

- (UIImageView *)socket3ItemView
{
    if (!_socket3ItemView) {
        _socket3ItemView = [self normalSocketItemView];
    }
    return _socket3ItemView;
}

- (UIImageView *)socket4ItemView
{
    if (!_socket4ItemView) {
        _socket4ItemView = [self normalSocketItemView];
    }
    return _socket4ItemView;
}

- (UIButton *)socketButton1
{
    if (!_socketButton1) {
        _socketButton1 = [self normalSocketButton:1];
    }
    return _socketButton1;
}

- (UIButton *)socketButton2
{
    if (!_socketButton2) {
        _socketButton2 = [self normalSocketButton:2];
    }
    return _socketButton2;
}

- (UIButton *)socketButton3
{
    if (!_socketButton3) {
        _socketButton3 = [self normalSocketButton:3];
    }
    return _socketButton3;
}

- (UIButton *)socketButton4
{
    if (!_socketButton4) {
        _socketButton4 = [self normalSocketButton:4];
    }
    return _socketButton4;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
