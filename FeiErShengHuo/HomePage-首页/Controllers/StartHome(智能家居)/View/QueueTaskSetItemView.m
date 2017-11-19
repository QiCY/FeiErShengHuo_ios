//
//  QueueTaskSetItemView.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "QueueTaskSetItemView.h"
#import "UIGestureRecognizer+RACSignalSupport.h"
#import "RACSignal.h"

@interface QueueTaskSetItemView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *valueLabel;

@end

@implementation QueueTaskSetItemView

- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.valueLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [tap.rac_gestureSignal subscribeNext:^(id x) {
            @strongify(self);
            self.didClickSelf ? self.didClickSelf () : nil;
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
}

+ (QueueTaskSetItemView *)viewWithTitle:(NSString *)title
{
    QueueTaskSetItemView *view = [[QueueTaskSetItemView alloc] init];
    view.title = title;
    return view;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setValue:(NSString *)value
{
    self.valueLabel.text = value;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(12, 3, 100, CGRectGetHeight(self.frame)-3*2);
    self.valueLabel.frame = CGRectMake(CGRectGetWidth(self.frame)-100-12, 3, 100, CGRectGetHeight(self.frame)-3*2);
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.backgroundColor = [UIColor whiteColor];
        _valueLabel.font = [UIFont systemFontOfSize:15];
        _valueLabel.textColor = [UIColor grayColor];
        
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.text = @"请选择";
    }
    return _valueLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
