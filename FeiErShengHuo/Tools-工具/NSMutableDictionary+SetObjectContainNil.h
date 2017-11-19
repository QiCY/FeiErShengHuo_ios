//
//  NSMutableDictionary+SetObjectContainNil.h
//  YiPlusDoctor
//
//  Created by Chen on 15/9/6.
//  Copyright (c) 2015年 YlzInfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SetObjectContainNil)
-(void)setContailNilObject:(id)anObject forKey:(id<NSCopying>)aKey;

-(void)setContailNilObjectTakeValue:(id)anObject forKey:(id<NSCopying>)aKey;


@end
