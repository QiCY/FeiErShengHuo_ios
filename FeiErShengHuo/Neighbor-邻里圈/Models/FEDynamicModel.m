//
//  FEDynamicModel.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEDynamicModel.h"

@implementation FEDynamicModel

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
            return 0;
        }
    }
    return oldValue;
    
    
}


// 新方法更加没有侵入性和污染
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"pictureMap" : @"FEPictureModel"
             
             };
}

@end
