//
//  BroadLinkHelper.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "BroadLinkHelper.h"
#import "BLDNADevice+toKeyValue.h"
#import "BLeAirStatusValueInfo+DataParaser.h"


#import "FESmartPowerPlugViewController.h"
#import "FEFourPositionSocketViewController.h"
#import "FEEnvironmentaLDetectorViewController.h"

static NSString * const BroadLinkLicense = @"ygzRQW8L2PbiCUwdbuqrGg9sNMQWoINwYd4hYFSxbiSZxvgjfdFRTAip98QxQjUiayYRWQAAAAB2/NCV71UyizePr5OXpmVgZmRaTYUJXr6K5gagr2leS97qdv+wAiydED11IAmjpYl1n+juht+lPjiuC5x/WvEMsEkbxXTfoUSQjDzWcfVjcAAAAAA=";

@interface BroadLinkHelper ()<BLControllerDelegate>

@property (nonatomic,strong) BLLet *let;

@end

@implementation BroadLinkHelper

- (instancetype)init
{
    if (self = [super init]) {
        [self initSDK];
    }
    return self;
}

+ (BroadLinkHelper *)sharedBroadLinkHelper
{
    static BroadLinkHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[BroadLinkHelper alloc] init];
    });
    return helper;
}

- (void)initSDK
{
    self.let = [BLLet sharedLetWithLicense:BroadLinkLicense];  // Init AppSdk
    self.let.debugLog = BL_LEVEL_ALL;
    
    self.let.controller.delegate = self;
    [self.let.controller setSDKRawDebugLevel:BL_LEVEL_ALL];   // Set DNA SDK Debug log level
    
    /// 2017.08.24
    [self.let.controller startProbe];

}

- (void)bl_getRemoteDeviceListComplete:(void (^)(NSArray<BLDNADevice *> *))complete failed:(void (^)())failed
{
    NSString *urlString = @"020appd/device/showInfo";
    NSDictionary *params = @{};
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST withPath:urlString withDictionary:params withSuccessBlock:^(NSDictionary *dic) {
        
        NSArray *resultInfo = dic[@"devices"];
        if (resultInfo && resultInfo.count) {
            
            NSArray *storeDevices = resultInfo;
            NSMutableArray <BLDNADevice *>*devices = [NSMutableArray array];
            if (storeDevices && storeDevices.count > 0) {
                for (NSDictionary *dict in resultInfo) {
                    BLDNADevice *device = [BLDNADevice deviceWithRemoteDict:dict];
//                    [self.let.controller addDevice:device];
                    [devices addObject:device];
                }
                [self.let.controller addDeviceArray:devices];
                complete ? complete (devices) : nil;
                
            } else {
                failed ? failed () : nil;
            }
            
        } else {
            failed ? failed () : nil;
        }
        
        [self bl_startScanDevice];

        
    } withfialedBlock:^(NSString *msg) {
        failed ? failed () : nil;
        
        [self bl_startScanDevice];
    }];
}

- (void)bl_uploadDevice:(BLDNADevice *)device autoAdd:(BOOL)autoAdd complete:(void (^)())complete failed:(void (^)())failed
{
    NSString *urlString = @"020appd/device/shebeigengxin";
    NSDictionary *params = [device toKeyValue];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST withPath:urlString withDictionary:params withSuccessBlock:^(NSDictionary *dic) {
        
        
        autoAdd ? [self.let.controller addDevice:device] : nil;
        
        complete ? complete () : nil;
        
    } withfialedBlock:^(NSString *msg) {
        failed ? failed () : nil;
    }];
}

- (void)bl_startScanDevice
{
    [self.let.controller stopProbe];
    [self.let.controller startProbe];
}

- (void)bl_stopScanDevice
{
    [self.let.controller stopProbe];
}

- (void)bl_addDevice:(BLDNADevice *)device
{
    [self.let.controller addDevice:device];
}

- (void)bl_addDevices:(NSArray *)devices
{
    [self.let.controller addDeviceArray:devices];
}

- (BLDeviceStatusEnum)bl_getDeviceStatus:(BLDNADevice *)device
{
    BLDeviceStatusEnum state = [self.let.controller queryDeviceState:[device getDid]];
    return state;
}

- (void)bl_pairDevice:(BLDNADevice *)device complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BLPairResult *result = [self.let.controller pair:device.did];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([result succeed]) {
                device.controlKey = [result getKey];
            }
            
            complete ? complete ([result succeed]) : nil;
        });
    });
}

- (void)bl_configDevice:(NSString *)ssid password:(NSString *)password timeout:(NSInteger)timeout complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLDeviceConfigResult *result = [self.let.controller deviceConfig:ssid password:password version:2 timeout:timeout];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete ? complete ([result succeed]) : nil;
        });
    });
}

- (void)bl_cancelConfigDevice
{
    [self.let.controller deviceConfigCancel];
}

- (void)bl_initDeviceScript:(BLDNADevice *)device complete:(void (^)(BOOL))complete
{
    NSString *profileFile = [self.let.controller queryScriptFileName:[device getPid]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:profileFile]) {
        [self.let.controller downloadScript:[device getPid] completionHandler:^(BLDownloadResult * _Nonnull result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete ? complete ([result succeed]) : nil;
            });
        }];
    }
    else {
        complete ? complete (YES) : nil;
    }

}

- (NSInteger)bl_getSmartSocketDeviceSwitchStatus:(BLDNADevice *)device
{
    BLStdData *data = [[BLStdData alloc] init];
    [data setValue:@"" forParam:@"pwr"];
    BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:data action:@"get"];
    if (![result succeed]) {
        return -1;
    }
    
    NSDictionary *dic = [[result getData] toDictionary];
    if (dic == nil) {
        return -1;
    }
    if (![[dic allKeys] containsObject:@"vals"]) {
        return -1;
    }
    NSDictionary *valDict = [[dic[@"vals"] firstObject] firstObject];
    return [valDict[@"val"] integerValue];
}

- (void)bl_operationSmartSocketDevice:(BLDNADevice *)device status:(NSInteger)status complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLStdData *stdData = [[BLStdData alloc] init];
        [stdData setValue:[NSString stringWithFormat:@"%ld",status] forParam:@"pwr"];
        BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:stdData action:@"set"];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete ? complete ([result succeed]) : nil;
        });
    });

    
    
}

- (void)bl_getFourSmartSocketDeviceSwitchStatus:(BLDNADevice *)device comlete:(void (^)(NSInteger, NSInteger, NSInteger, NSInteger, NSInteger))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLStdData *stdData = [[BLStdData alloc] init];
        [stdData setValue:@"" forParam:@"pwr"];
        BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:stdData action:@"get"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSInteger pwr = -1;
            
            NSInteger pwr1 = -1;
            NSInteger pwr2 = -1;
            NSInteger pwr3 = -1;
            NSInteger pwr4 = -1;
            
            if ([result succeed]) {
                
                NSDictionary *dict = [[result getData] toDictionary];
                NSArray *resultArray = dict[@"vals"];
                
                if (resultArray.count >= 1) {
                    pwr1 = [[resultArray[0][0] objectForKey:@"val"] integerValue];
                }
                
                if (resultArray.count >= 2) {
                    pwr2 = [[resultArray[1][0] objectForKey:@"val"] integerValue];
                }
                
                if (resultArray.count >= 3) {
                    pwr3 = [[resultArray[2][0] objectForKey:@"val"] integerValue];
                }
                
                if (resultArray.count >= 4) {
                    pwr4 = [[resultArray[3][0] objectForKey:@"val"] integerValue];
                }
                
                pwr = pwr1 && pwr2 && pwr3 && pwr4;
                
            }
            
            complete ? complete (pwr, pwr1, pwr2, pwr3, pwr4) : nil;
            
        });
    });

}

- (void)bl_operationFourSmartSocketDevice:(BLDNADevice *)device index:(NSInteger)index status:(NSInteger)status complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLStdData *stdData = [[BLStdData alloc] init];

        NSString *param = @"pwr";
        if (index != 0) {
            param = [NSString stringWithFormat:@"pwr%ld",index];
        }
        [stdData setValue:[NSString stringWithFormat:@"%ld",status] forParam:param];
        BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:stdData action:@"set"];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete ? complete ([result succeed]) : nil;
        });
    });
}

- (void)bl_getEnvironmentaLDetectorData:(BLDNADevice *)device complete:(void (^)(NSString *, NSString *, NSString *, NSString *, NSString *))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLPassthroughResult *result = [self.let.controller dnaPassthrough:[device getDid] subDevDid:nil passthroughData:[[BLeAirNetWorkDataParser sharedInstace] a1RefreshByts]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *temperatureValue = nil;
            NSString *humidityValue = nil;
            NSString *lightValue = nil;
            NSString *airValue = nil;
            NSString *noisyValue = nil;
            
            if ([result succeed]) {
                BLeAirStatusInfo *airInfo = [[BLeAirNetWorkDataParser sharedInstace] parseA1RefreshResult:[result getData]];
                
                //温度
                BLeAirStatusValueInfo *temperature = airInfo.temperature;
                temperatureValue = [temperature getValue];
                
                //湿度
                BLeAirStatusValueInfo *humidity = airInfo.humidity;
                humidityValue = [humidity getValue];
                
                //光照
                BLeAirStatusValueInfo *light = airInfo.light;
                lightValue = [light getLightValue];
                
                //空气质量
                BLeAirStatusValueInfo *air = airInfo.air;
                airValue = [air getAirValue];
                
                //噪音
                BLeAirStatusValueInfo *noisy = airInfo.noisy;
                noisyValue = [noisy getNoisyValue];
            }
            
            complete ? complete (temperatureValue, humidityValue, lightValue, airValue, noisyValue) : nil;
        });
    });
}

- (void)bl_operationDevice:(BLDNADevice *)device status:(NSInteger)status param:(NSString *)param complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLStdData *stdData = [[BLStdData alloc] init];
        [stdData setValue:[NSString stringWithFormat:@"%ld",status] forParam:param];
        BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:stdData action:@"set"];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete ? complete ([result succeed]) : nil;
        });
    });
}

- (void)bl_getQueueTaskList:(BLDNADevice *)device complete:(void (^)(NSArray<NSDictionary *> *))complete failed:(void (^)())failed
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLStdData *stdData = [[BLStdData alloc] init];
        [stdData setValue:@"" forParam:@"pertsk"];
        BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:stdData action:@"get"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([result succeed]) {
                NSArray *values = [[[[result getData] toDictionary] objectForKey:@"vals"] firstObject];
                __block NSMutableArray <NSDictionary *>*marr = [NSMutableArray array];
                [values enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *val = obj[@"val"];
                    NSDictionary *item = [self getQueueTaskDict:val];
                    [marr addObject:item];
                }];
                complete ? complete (marr) : nil;
            }
            else {
                failed ? failed () : nil;
            }
            
        });
    });

}

- (void)bl_setQueueTask:(BLDNADevice *)device value:(NSDictionary *)value complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLStdData *stdData = [[BLStdData alloc] init];
//        使能|TIMEZONE-开时间@关时间|周期|start|done
//        1|+0800-null@080529|1234567|0|1
        NSNumber *enable = value[QueueTaskEnableKey];
        NSString *startTime = value[QueueTaskStartTimeKey];
        NSString *endTime = value[QueueTaskEndTimeKey];
        NSString *cycle = value[QueueTaskCycleKey];
        NSString *value = [NSString stringWithFormat:@"%@|+0800-%@@%@|%@|1|1",enable, startTime, endTime, cycle];
        [stdData setValue:value forParam:@"pertsk"];
        BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:stdData action:@"set"];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete ? complete ([result succeed]) : nil;
        });
    });
}

- (void)bl_setQueueTask:(BLDNADevice *)device values:(NSArray<NSDictionary *> *)values complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BLStdData *stdData = [[BLStdData alloc] init];
        //        使能|TIMEZONE-开时间@关时间|周期|start|done
        //        1|+0800-null@080529|1234567|0|1
        
        __block NSMutableArray *marr = [NSMutableArray array];
        [values enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSNumber *enable = obj[QueueTaskEnableKey];
            NSString *startTime = obj[QueueTaskStartTimeKey];
            NSString *endTime = obj[QueueTaskEndTimeKey];
            NSString *cycle = obj[QueueTaskCycleKey];
            NSString *value = [NSString stringWithFormat:@"%@|+0800-%@@%@|%@|1|1",enable, startTime, endTime, cycle];
            NSDictionary *valueDict = @{@"idx":@(1),@"val":value};
            [marr addObject:valueDict];
        }];
        
        [stdData setParams:@[@"pertsk"] values:@[marr]];
//        [stdData setParams:@[@"pertsk"] values:@[ @[ @{ @"val":@"1|+0800-null@080529|1234567|1|1", @"idx":@(1)} ,  @{@"val":@"1|+0800-null@080529|1234567|1|1", @"idx":@(1) }] ] ];
        BLStdControlResult *result = [self.let.controller dnaControl:[device getDid] stdData:stdData action:@"set"];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete ? complete ([result succeed]) : nil;
        });
    });
}

- (void)bl_showDeviceDetail:(BLDNADevice *)device inController:(UIViewController *)controller
{
    [RYLoadingView showRequestLoadingView];
    BLDeviceStatusEnum status = [[BroadLinkHelper sharedBroadLinkHelper] bl_getDeviceStatus:device];
    
    if (status == BL_DEVICE_STATE_LAN) {
        [self showDeviceDetail:device controller:controller];
        [RYLoadingView hideRequestLoadingView];
    }
    else if (status == BL_DEVICE_STATE_REMOTE) {
//        @weakify(self);
//        [self bl_pairDevice:device complete:^(BOOL success) {
//            @strongify(self);
            [self showDeviceDetail:device controller:controller];
            [RYLoadingView hideRequestLoadingView];
//        }];
    }
    else if (status == BL_DEVICE_STATE_UNKNOWN) {
        [RYLoadingView hideRequestLoadingView];
        [FENavTool showAlertViewByAlertMsg:@"设备正在初始化，请稍后再试" andType:@"提示"];
    }
    else {
        [RYLoadingView hideRequestLoadingView];
        [FENavTool showAlertViewByAlertMsg:@"设备不在线，请稍后再试" andType:@"提示"];
    }
}

- (NSString *)bl_showSmartHomeDeviceIconName:(BLDNADevice *)device
{
    //  智能插座
    if ([device.pid isEqualToString:SmartSocketPid]) {
        return @"2socket_Smart_home2";
    }
    
    //  四脚插座
    if ([device.pid isEqualToString:FourHoldSocketPid]) {
        return @"2fSocket_Smart_home2";
    }
    
    //  环境监测仪
    if ([device.pid isEqualToString:YanacoPid]) {
        return @"2tester_Smart_home2";
    }
    
    //  智能遥控
    if ([device.pid isEqualToString:SmartControlPid]) {
        return @"2bbrcontrol_Smart_home2";
    }
    
    //  智能插座10A
    if ([device.pid isEqualToString:smartSocket10APid]) {
        return @"2wsocket_Smart_home2";
    }
    
    return @"2bbrcontrol_Smart_home2";
}

- (NSString *)bl_showDeviceListDeviceIconName:(BLDNADevice *)device
{
    return @"";
}

#pragma mark - private

- (NSDictionary *)getQueueTaskDict:(NSString *)val
{
//    1|+0800-165553@170053|null|1|1
    
    NSString *time = [val componentsSeparatedByString:@"|"][1];
    
    NSString *enable = [val componentsSeparatedByString:@"|"][0];
    NSString *startTime = [[[time componentsSeparatedByString:@"@"][0] componentsSeparatedByString:@"-"] lastObject];
    NSString *endTime = [time componentsSeparatedByString:@"@"][1];
    NSString *cycle = [val componentsSeparatedByString:@"|"][2];
//    NSString *start = @"";
//    NSString *end = @"";
    return @{QueueTaskEnableKey:enable,
                 QueueTaskStartTimeKey:startTime,
                 QueueTaskEndTimeKey:endTime,
             QueueTaskCycleKey:cycle};
}

- (void)showDeviceDetail:(BLDNADevice *)device controller:(UIViewController *)controller
{
    //  智能插座
    if ([device.pid isEqualToString:SmartSocketPid]) {
        FESmartPowerPlugViewController *fvc = [FESmartPowerPlugViewController controllerWithDevice:device];
        [controller.navigationController pushViewController:fvc animated:YES];
    }
    
    //  四脚插座
    if ([device.pid isEqualToString:FourHoldSocketPid]) {
        FEFourPositionSocketViewController *fvc = [FEFourPositionSocketViewController controllerWithDevice:device];
        [controller.navigationController pushViewController:fvc animated:YES];
    }
    
    //  环境监测仪
    if ([device.pid isEqualToString:YanacoPid]) {
        FEEnvironmentaLDetectorViewController *fvc = [FEEnvironmentaLDetectorViewController controllerWithDevice:device];
        [controller.navigationController pushViewController:fvc animated:YES];
    }
    
    //  智能遥控
    if ([device.pid isEqualToString:SmartControlPid]) {
        
    }
    
    //  智能插座10A
    if ([device.pid isEqualToString:smartSocket10APid]) {
        
    }
}

- (NSData *)hexString2Bytes:(NSString *)hexStr
{
    const char *hex = [[hexStr lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    int length = (int)strlen(hex);
    int i;
    NSMutableData *result = [[NSMutableData alloc] init];
    
    if (length % 2) {
        NSLog(@"%@ not a valid hex string ,length = %d", hexStr, length);
        return nil;
    }
    
    for (i=0; i<length/2; i++) {
        unsigned int value;
        unsigned char bin;
        NSString *hexCharStr = [hexStr substringWithRange:NSMakeRange(i*2, 2)];
        NSScanner *scanner = [[NSScanner alloc] initWithString:[NSString stringWithFormat:@"0x%@", hexCharStr]];
        
        if (![scanner scanHexInt:&value]) {
            NSLog(@"hexStr: %@, i: %d", hexStr, i);
            NSLog(@"%@ not a valid hex char", hexCharStr);
            return nil;
        }
        
        bin = value & 0xff;
        
        [result appendBytes:&bin length:1];
    }
    
    return result;
}


- (NSString *)data2hexString:(NSData *)data {
    int count = (int)data.length;
    const unsigned char* temp = (const unsigned char*)data.bytes;
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int i = 0; i < count; i++)
    {
        [string appendFormat:@"%02x",*(temp+i)];
    }
    return string;
}

#pragma mark - BLControllerDelegate
- (Boolean)shouldAdd:(BLDNADevice *)device {
    return NO;
}

- (void)onDeviceUpdate:(BLDNADevice *)device isNewDevice:(Boolean)isNewDevice {
    NSLog(@"device = %@",device);
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDiscoverDevice:isNewDevice:)]) {
        [self.delegate onDiscoverDevice:device isNewDevice:isNewDevice];
    }
}

@end
