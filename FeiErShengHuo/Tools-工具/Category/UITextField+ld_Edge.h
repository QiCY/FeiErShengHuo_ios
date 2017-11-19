//
//  UITextField+ld_Edge.h
//  TCHealth
//
//  Created by TAKUMI on 2017/2/28.
//  Copyright © 2017年 TAKUMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ld_Edge)

- (void)ld_setLeftEdge:(CGFloat)left;
- (void)ld_setRightEdge:(CGFloat)right;
- (void)ld_setTopEdge:(CGFloat)top;
- (void)ld_setBottomEdge:(CGFloat)bottom;

- (void)ld_setEgdeInsets:(UIEdgeInsets)edgeInsets;

@end
