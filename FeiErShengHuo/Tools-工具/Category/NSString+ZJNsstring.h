//
//  NSString+ZJNsstring.h
//  ZiJinLian
//
//  Created by lzy on 2017/3/20.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZJNsstring)

- (CGFloat)singleLineWidthWithFont:(UIFont *)font;    //单行宽度。
- (CGFloat)singleLineHeightWithFont:(UIFont *)font;   //单行高度
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;      //多行宽度

@end
