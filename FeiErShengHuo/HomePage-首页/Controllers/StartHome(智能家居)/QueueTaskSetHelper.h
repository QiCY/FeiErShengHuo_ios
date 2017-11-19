//
//  QueueTaskSetHelper.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueueTaskSetHelper : NSObject

+ (void)selectDate:(NSString *)originalDate inController:(UIViewController *)controller complete:(void(^)(NSString *dateString))complete;

+ (void)selectCycle:(NSString *)originalCycle inController:(UIViewController *)controller complete:(void(^)(NSString *cycleString))complete;

+ (NSString *)showCycle:(NSString *)cycle;

@end
