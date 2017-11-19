//
//  DeviceSectionModel.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

//// 智能插座
//public static final String TYPE_SMART_SOCKET = "0000000000000000000000003e750000";
//
//// 四位排插
//public static final String TYPE_SMART_FORE_SOCKET = "000000000000000000000000b54e0000";
//
//// 环境监测仪
//public static final String TYPE_SMART_ENVIRONMENT = "00000000000000000000000014270000";
//
//// 智能遥控
//public static final String TYPE_SMART_CONTROL = "0000000000000000000000002a270000";
//
//// 智能插座10A
//public static final String TYPE_SMART_SOCKET_10A = "00000000000000000000000019790000";

@interface DeviceSectionModel : NSObject

@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *pname;
@property (nonatomic,strong) NSMutableArray <BLDNADevice *>*devices;

+ (DeviceSectionModel *)sectionWithPid:(NSString *)pid;

/// 智能插座
+ (DeviceSectionModel *)smartSocketSection;
/// 四位排插
+ (DeviceSectionModel *)fourHoldSocketSection;
/// 环境监测仪
+ (DeviceSectionModel *)yanacoSection;
/// 智能遥控
+ (DeviceSectionModel *)smartControlSection;
/// 智能插座10A
+ (DeviceSectionModel *)smartSocket10ASection;

/// 是否是当下类型设备
- (BOOL)isInSelf:(NSString *)pid;

@end
