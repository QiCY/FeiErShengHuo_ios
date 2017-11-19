//
//  BLDeviceQueueOperationHelper.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "BLDeviceQueueOperationHelper.h"

@interface BLDeviceQueueOperationHelper ()

@property (nonatomic,strong) NSTimer *operationTimer;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) void (^completeBlock) (BOOL success, NSInteger index);

@end

@implementation BLDeviceQueueOperationHelper

+ (BLDeviceQueueOperationHelper *)sharedBLDeviceQueueOperationHelper
{
    static BLDeviceQueueOperationHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[BLDeviceQueueOperationHelper alloc] init];
    });
    return helper;
}

- (void)bl_quenuOperationWithDevices:(NSArray<BLDNADevice *> *)devices timeInterval:(NSTimeInterval)timeInterval complete:(void (^)(BOOL, NSInteger))complete
{
    if (devices.count) {
        [self closeTimer];
        self.dataArray = [NSMutableArray arrayWithArray:devices];
        self.index = 0;
        self.completeBlock = complete;
        self.operationTimer =  [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(queueOperation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.operationTimer forMode:NSRunLoopCommonModes];
        [self.operationTimer fire];
    }
}

- (void)bl_cancelQuenuOperation
{
    [self closeTimer];
}

- (void)queueOperation
{
    if (self.index >= self.dataArray.count) {
        [self closeTimer];
        return;
    }
    
    BLDNADevice *device = self.dataArray[self.index];
    
    BLDeviceStatusEnum state = [[BroadLinkHelper sharedBroadLinkHelper] bl_getDeviceStatus:device];
    if (state == BL_DEVICE_STATE_OFFLINE ||
        state == BL_DEVICE_STATE_UNKNOWN) {
        self.completeBlock ? self.completeBlock (NO, self.index) : nil;
        self.index ++;
    } else {
        NSInteger target = device.state;
        
        [[BroadLinkHelper sharedBroadLinkHelper] bl_operationDevice:device status:target param:@"pwr" complete:^(BOOL success) {
            self.completeBlock ? self.completeBlock (success, self.index) : nil;
            self.index ++;
        }];
    }
}

- (void)closeTimer
{
    [self.operationTimer invalidate];
    self.operationTimer = nil;
}

@end
