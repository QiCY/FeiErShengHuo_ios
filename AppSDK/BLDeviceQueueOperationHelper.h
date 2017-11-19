//
//  BLDeviceQueueOperationHelper.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLDeviceQueueOperationHelper : NSObject

+ (BLDeviceQueueOperationHelper *)sharedBLDeviceQueueOperationHelper;

- (void)bl_quenuOperationWithDevices:(NSArray <BLDNADevice *>*)devices timeInterval:(NSTimeInterval)timeInterval complete:(void(^)(BOOL success, NSInteger index))complete;

- (void)bl_cancelQuenuOperation;

@end
