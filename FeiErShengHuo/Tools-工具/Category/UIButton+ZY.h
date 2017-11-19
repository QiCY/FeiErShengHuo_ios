//
//  UIButton+ZY.h
//  block 链式编程
//
//  Created by lzy on 2017/9/7.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZY)

@property (nonatomic, copy) UIButton *(^frame_l)(CGRect rect);
@property (nonatomic, copy) UIButton *(^backgroundColor_l)(UIColor *color);
@property (nonatomic, copy) UIButton *(^addToView)(UIView *view);
@property (nonatomic, copy) UIButton *(^action)(id target, SEL selector, UIControlEvents events);

UIButton * UIBtn(id name);





@end
