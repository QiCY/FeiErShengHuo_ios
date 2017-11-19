//
//  DeviceSectionModel.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "DeviceSectionModel.h"

@implementation DeviceSectionModel

- (instancetype)init
{
    if (self = [super init]) {
        self.devices = [NSMutableArray array];
    }
    return self;
}

+ (DeviceSectionModel *)sectionWithPid:(NSString *)pid
{
    DeviceSectionModel *section = [[DeviceSectionModel alloc] init];
    section.pid = pid;
    return section;
}

/// 智能插座
+ (DeviceSectionModel *)smartSocketSection
{
    DeviceSectionModel *section = [DeviceSectionModel sectionWithPid:SmartSocketPid];
    section.pname = @"智能插座";
    return section;
}

/// 四位排插
+ (DeviceSectionModel *)fourHoldSocketSection
{
    DeviceSectionModel *section = [DeviceSectionModel sectionWithPid:FourHoldSocketPid];
    section.pname = @"四位排插";
    return section;
}

/// 环境监测仪
+ (DeviceSectionModel *)yanacoSection
{
    DeviceSectionModel *section = [DeviceSectionModel sectionWithPid:YanacoPid];
    section.pname = @"环境监测仪";
    return section;
}

/// 智能遥控
+ (DeviceSectionModel *)smartControlSection
{
    DeviceSectionModel *section = [DeviceSectionModel sectionWithPid:SmartControlPid];
    section.pname = @"智能遥控";
    return section;
}

/// 智能插座10A
+ (DeviceSectionModel *)smartSocket10ASection
{
    DeviceSectionModel *section = [DeviceSectionModel sectionWithPid:smartSocket10APid];
    section.pname = @"智能插座10A";
    return section;
}

- (BOOL)isInSelf:(NSString *)pid
{
    return [pid isEqualToString:self.pid];
}

@end
