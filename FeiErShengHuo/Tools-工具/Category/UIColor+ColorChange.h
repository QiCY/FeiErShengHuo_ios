//
//  UIColor+ColorChange.h
//  ZiJinLian
//
//  Created by lzy on 2017/3/8.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

/** 根据16进制字符串返回对应颜色 带透明参数 */
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


@end
