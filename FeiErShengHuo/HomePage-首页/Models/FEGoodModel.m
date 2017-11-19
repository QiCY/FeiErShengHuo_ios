//
//  FEGoodModel.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGoodModel.h"

@implementation FEGoodModel


//替换服务器命名
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"descrip":@"description"
             };
}
/* 转化过程中对字典的值进行过滤和进一步转化 */

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.type isKindOfClass:[NSString class]]) {
        
        if ([oldValue isKindOfClass:[NSNull class]]||[oldValue isEqual:[NSNull null]]) {
            return @"";
            
        }
    }
     if ([property.type isKindOfClass:[NSNumber class]]) {
        if ([oldValue isKindOfClass:[NSNull class]]||[oldValue isEqual:[NSNull null]]) {
            return [NSNumber numberWithInt:0];
        }
        
    }
    return oldValue;
    
}

@end
