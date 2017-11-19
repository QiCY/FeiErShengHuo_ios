//
//  FEActivityDetailModel.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEActivityDetailModel.h"

@implementation FEActivityDetailModel
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

// 新方法更加没有侵入性和污染
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"picList" : @"FEpicListModel"
             
             };
}



@end
