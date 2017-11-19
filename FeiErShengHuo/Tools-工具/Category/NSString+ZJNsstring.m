//
//  NSString+ZJNsstring.m
//  ZiJinLian
//
//  Created by lzy on 2017/3/20.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "NSString+ZJNsstring.h"

@implementation NSString (ZJNsstring)

- (CGFloat)singleLineWidthWithFont:(UIFont *)font;
{
    return ceilf([self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MIN) options:0 attributes:@{NSFontAttributeName:font} context:nil].size.width);
    
}


- (CGFloat)singleLineHeightWithFont:(UIFont *)font{
     return ceilf([self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MIN) options:0 attributes:@{NSFontAttributeName:font} context:nil].size.height);
    
}

- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = 5;//默认行间距 设置为5 吧
    NSDictionary *attribute = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};//,
    CGSize sizef = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(sizef.height);
}




@end
