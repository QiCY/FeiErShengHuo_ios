//
//  FEGroupDetailModel.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupDetailModel.h"

@implementation FEGroupDetailModel

// 新方法更加没有侵入性和污染
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"slideList" : @"FEPictureModel"
             
             };
}
//替换服务器命名
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"descrip":@"description"
             };
}


@end
