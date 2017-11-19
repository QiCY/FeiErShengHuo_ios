
//
//  FEbaseModel.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/1.
//  Copyright ©  年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"

@implementation FEbaseModel



//MJCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{

    if ([oldValue isKindOfClass:[NSNull class]]||[oldValue isEqual:[NSNull null]]||oldValue==nil) {
        return @"";  // 以字符串类型为例
    }
    
    if (oldValue) {
        return oldValue;
        
    }
    return oldValue;
    
}
@end
