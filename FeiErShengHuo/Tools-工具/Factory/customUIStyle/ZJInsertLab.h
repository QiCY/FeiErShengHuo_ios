//
//  insertLab.h
//  zijinlian
//
//  Created by lzy on 2017/3/7.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJInsertLab : UILabel
@property(nonatomic) UIEdgeInsets insets;
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;
@end
