//
//  FELoginInfo.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FELoginInfo.h"



@implementation FELoginInfo

//MJCodingImplementation

//static  FELoginInfo *INSTANCE=nil;
//+(instancetype)shareUserInfoSingleton
//{
//    if (!INSTANCE) {
//        INSTANCE = [[self alloc] init];
//    
//    }
//    return INSTANCE;
//}
//


////忽略归档
//+(NSArray *)mj_ignoredCodingPropertyNames
//{
//    return @[@""];
//    
//}





//替换服务器命名
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"_id":@"id"
             };
}

@end
