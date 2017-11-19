//
//  NSDictionary+Json.m
//  SOSTAR
//
//  Created by TAKUMI on 2017/2/20.
//  Copyright © 2017年 TAKUMI. All rights reserved.
//

#import "NSObject+Json.h"

@implementation NSObject (Json)

- (NSString *)toJSON
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:kNilOptions
                                                         error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
