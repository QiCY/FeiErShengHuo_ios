//
//  UIButton+ZY.m
//  block 链式编程
//
//  Created by lzy on 2017/9/7.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "UIButton+ZY.h"
UIButton *button;
@implementation UIButton (ZY)

-(UIButton *(^)(CGRect))frame_l {
    return ^(CGRect fra) {
        self.frame = fra;
        return self;
    };
}
-(void)setFrame_l:(UIButton *(^)(CGRect))frame_l {};
-(UIButton *(^)(UIColor *))backgroundColor_l {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
-(void)setBackgroundColor_l:(UIButton *(^)(UIColor *))backgroundColor_l {};
-(UIButton *(^)(UIView *))addToView {
    return ^(UIView *view) {
        [view addSubview:self];
        return self;
    };
}
-(void)setAddToView:(UIButton *(^)(UIView *))addToView {};
-(UIButton *(^)(id, SEL, UIControlEvents))action {
    return ^(id target, SEL selector, UIControlEvents events) {
        [self addTarget:target action:selector forControlEvents:events];
        return self;
    };
}
-(void)setAction:(UIButton *(^)(id, SEL, UIControlEvents))action {};

//- (void)addTapBlock:(ButtonBlock)block
//{
//    
//
//}

@end
UIButton * UIBtn(id name) {
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    return button;
}

