//
//  NSArray+decription.m
//  ZiJinLian
//
//  Created by lzy on 2017/3/14.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "NSArray+decription.h"

@implementation NSArray (decription)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}
@end
