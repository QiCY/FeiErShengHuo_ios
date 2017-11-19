//
//  BLeAirStatusValueInfo+DataParaser.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/2.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "BLeAirNetWorkDataParser.h"

@interface BLeAirStatusValueInfo (DataParaser)

///  温度，湿度
- (NSString *)getValue;

///  空气质量
- (NSString *)getAirValue;

/// 光照
- (NSString *)getLightValue;

/// 噪音
- (NSString *)getNoisyValue;

@end
