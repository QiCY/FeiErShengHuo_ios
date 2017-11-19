//
//  NSDictionary+decription.m
//  ZiJinLian
//
//  Created by lzy on 2017/3/14.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "NSDictionary+decription.h"

@implementation NSDictionary (decription)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    
    return str;
}
@end
