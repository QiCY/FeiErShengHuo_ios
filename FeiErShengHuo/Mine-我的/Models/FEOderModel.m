//
//  FEOderModel.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/28.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEOderModel.h"

@implementation FEOderModel
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
