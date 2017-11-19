//
//  FECarGoodsModel.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FECarGoodsModel.h"

@implementation FECarGoodsModel

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
    
    if ([property.name isEqualToString:@"isChose"]) {
        return @"0";
        
    }
    return oldValue;
    
}

//替换服务器命名
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"descrip":@"description"
             };
}


@end
