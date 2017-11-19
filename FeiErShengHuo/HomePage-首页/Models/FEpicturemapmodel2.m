//
//  FEpicturemapmodel2.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/17.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEpicturemapmodel2.h"

@implementation FEpicturemapmodel2
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
