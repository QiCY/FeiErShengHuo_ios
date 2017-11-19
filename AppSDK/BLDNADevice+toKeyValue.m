//
//  BLDNADevice+toKeyValue.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "BLDNADevice+toKeyValue.h"

@implementation BLDNADevice (toKeyValue)

- (NSDictionary *)toKeyValue
{
    NSMutableDictionary *params = @{}.mutableCopy;

    if (self.pDid) {
        params[@"pDid"] = self.pDid;
    } else {
        params[@"pDid"] = @"";
    }
    
    if (self.did) {
        params[@"did"] = self.did;
    } else {
        params[@"did"] = @"";
    }
    
    if (self.mac) {
        params[@"mac"] = self.mac;
    } else {
        params[@"mac"] = @"";
    }
    
    if (self.pid) {
        params[@"pid"] = self.pid;
    } else {
        params[@"pid"] = @"";
    }
    
    if (self.name) {
        params[@"name"] = self.name;
    } else {
        params[@"name"] = @"";
    }
    
    params[@"type"] = @(self.type);
    
    params[@"lock"] = [NSNumber numberWithBool:self.lock];
    params[@"newconfig"] = [NSNumber numberWithBool:self.newConfig];
    params[@"password"] = [NSNumber numberWithUnsignedInteger:self.password];
    if (self.controlKey) {
        params[@"key"] = self.controlKey;
    } else {
        params[@"key"] = @"";
    }
    
    params[@"roomtype"] = [NSNumber numberWithInt:-1];
    
    params[@"state"] = @(self.state);

    params[@"extend"] = @"-1";
    if (self.lanaddr) {
        params[@"lanaddr"] = self.lanaddr;
    } else {
        params[@"lanaddr"] = @"";
    }

    params[@"sId"] = @(self.controlId);
    
    return [params allKeys].count ? params : nil;
}

+ (BLDNADevice *)deviceWithRemoteDict:(NSDictionary *)dict
{
    BLDNADevice *device = [[BLDNADevice alloc] init];
    device.pid = dict[@"pDid"];
    device.did = dict[@"did"];
    device.mac = dict[@"mac"];
    device.pid = dict[@"pid"];
    device.name = dict[@"name"];
    device.type = [dict[@"type"] unsignedIntegerValue];
    device.lock = [dict[@"lock"] boolValue];
    device.newConfig = [dict[@"newConfig"] boolValue];
    device.password = 0;
    device.controlKey = dict[@"key"];
    device.state = [dict[@"status"] unsignedIntegerValue];
    device.extendInfo = nil;
    device.lanaddr = nil;
    device.controlId = [dict[@"sId"] unsignedIntegerValue];
    
    return device;
}

@end
