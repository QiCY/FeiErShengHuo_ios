//
//  BroadLinkHelper.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLLet.h"
#import "BLeAirNetWorkDataParser.h"


/// 定时任务使能开关
static NSString * const QueueTaskEnableKey = @"QueueTaskEnableKey";
/// 定时任务开始时间
static NSString * const QueueTaskStartTimeKey = @"QueueTaskStartTimeKey";
/// 定时任务结束时间
static NSString * const QueueTaskEndTimeKey = @"QueueTaskEndTimeKey";
/// 定时任务循环周期
static NSString * const QueueTaskCycleKey = @"QueueTaskCycleKey";

///     智能插座
static NSString * const SmartSocketPid = @"0000000000000000000000003e750000";
///     四脚插座
static NSString * const FourHoldSocketPid = @"000000000000000000000000b54e0000";
///    环境监测仪
static NSString * const YanacoPid = @"00000000000000000000000014270000";
///     智能遥控
static NSString * const SmartControlPid = @"0000000000000000000000002a270000";
///     智能插座10A
static NSString * const smartSocket10APid = @"00000000000000000000000019790000";

@protocol BroadLinkHelperDelegate <NSObject>

- (void)onDiscoverDevice:(BLDNADevice *)device isNewDevice:(BOOL)isNewDevice;

@end

@interface BroadLinkHelper : NSObject

@property (nonatomic,weak) __weak id<BroadLinkHelperDelegate>delegate;

+ (BroadLinkHelper *)sharedBroadLinkHelper;

- (void)bl_getRemoteDeviceListComplete:(void(^)(NSArray <BLDNADevice *>*deviceList))complete failed:(void(^)())failed;
- (void)bl_uploadDevice:(BLDNADevice *)device autoAdd:(BOOL)autoAdd complete:(void(^)())complete failed:(void(^)())failed;

- (void)bl_startScanDevice;
- (void)bl_stopScanDevice;

- (void)bl_addDevice:(BLDNADevice *)device;
- (void)bl_addDevices:(NSArray *)devices;

- (BLDeviceStatusEnum)bl_getDeviceStatus:(BLDNADevice *)device;
- (void)bl_pairDevice:(BLDNADevice *)device complete:(void(^)(BOOL success))complete;

- (void)bl_configDevice:(NSString *)ssid password:(NSString *)password timeout:(NSInteger)timeout complete:(void(^)(BOOL success))complete;
- (void)bl_cancelConfigDevice;

- (void)bl_initDeviceScript:(BLDNADevice *)device complete:(void(^)(BOOL success))complete;

/// 获取插座状态（-1，不可用， 0，关  1，开）
- (NSInteger)bl_getSmartSocketDeviceSwitchStatus:(BLDNADevice *)device;
/// 操作插座
- (void)bl_operationSmartSocketDevice:(BLDNADevice *)device status:(NSInteger)status complete:(void(^)(BOOL success))complete;

/// 获取四脚插座状态（-1，不可用， 0，关  1，开）
- (void)bl_getFourSmartSocketDeviceSwitchStatus:(BLDNADevice *)device comlete:(void(^)(NSInteger totalPwr, NSInteger pwr1, NSInteger pwr2, NSInteger pwr3, NSInteger pwr4))complete;

/// 操作四脚插座
- (void)bl_operationFourSmartSocketDevice:(BLDNADevice *)device index:(NSInteger)index status:(NSInteger)status complete:(void(^)(BOOL success))complete;

/// 获取环境检测仪数据
- (void)bl_getEnvironmentaLDetectorData:(BLDNADevice *)device complete:(void(^)(NSString *temperatureValue, NSString *humidityValue, NSString *lightValue, NSString *airValue, NSString *noisyValue))complete;

/// 通用操作
- (void)bl_operationDevice:(BLDNADevice *)device status:(NSInteger)status param:(NSString *)param complete:(void(^)(BOOL success))complete;

/// 定时任务查询
- (void)bl_getQueueTaskList:(BLDNADevice *)device complete:(void(^)(NSArray <NSDictionary *>*result))complete failed:(void(^)())failed;

/// 设置一条定时任务
- (void)bl_setQueueTask:(BLDNADevice *)device value:(NSDictionary *)value complete:(void(^)(BOOL success))complete;

/// 设置多条定时任务
- (void)bl_setQueueTask:(BLDNADevice *)device values:(NSArray <NSDictionary *>*)values complete:(void(^)(BOOL success))complete;

/// 展示设备详情
- (void)bl_showDeviceDetail:(BLDNADevice *)device inController:(UIViewController *)controller;

/// 确定智能家居首页设备切图
- (NSString *)bl_showSmartHomeDeviceIconName:(BLDNADevice *)device;

/// 确定设备列表设备切图
- (NSString *)bl_showDeviceListDeviceIconName:(BLDNADevice *)device;

@end
