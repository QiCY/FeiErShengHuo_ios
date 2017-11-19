//
//  QueueTaskSetHelper.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "QueueTaskSetHelper.h"
#import "LDTimePicker.h"
#import "FESelectCycleController.h"

@implementation QueueTaskSetHelper

+ (void)selectDate:(NSString *)originalDate inController:(UIViewController *)controller complete:(void (^)(NSString *))complete
{
    LDTimePicker *picker = [LDTimePicker pickerWithTime:originalDate];
    picker.didSelectTime = complete;
    [picker show];
}

+ (void)selectCycle:(NSString *)originalCycle inController:(UIViewController *)controller complete:(void (^)(NSString *))complete
{
    FESelectCycleController *fvc = [FESelectCycleController controllerWithCycle:originalCycle];
    fvc.didSelectCycle = complete;
    [controller.navigationController pushViewController:fvc animated:YES];
}

+ (NSString *)showCycle:(NSString *)cycle
{
    if (cycle == nil || [cycle isEqualToString:@"null"]) {
        return @"执行一次";
    }
    if ([cycle isEqualToString:@"1234567"]) {
        return @"每天";
    }
    if ([cycle isEqualToString:@"7123456"]) {
        return @"每天";
    }
    return [NSString stringWithFormat:@"周%@",cycle];
}

@end
