//
//  NSMutableDictionary+SetObjectContainNil.m
//  YiPlusDoctor
//
//  Created by Chen on 15/9/6.
//  Copyright (c) 2015年 YlzInfo. All rights reserved.
//

#import "NSMutableDictionary+SetObjectContainNil.h"

@implementation NSMutableDictionary (SetObjectContainNil)


-(void)setContailNilObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject)
    {
        [self setObject:anObject forKey:aKey];
    }
}

-(void)setContailNilObjectTakeValue:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject)
    {
        [self setObject:anObject forKey:aKey];
    }
    else
    {
         [self setObject:@"" forKey:aKey];
    }
}


@end
