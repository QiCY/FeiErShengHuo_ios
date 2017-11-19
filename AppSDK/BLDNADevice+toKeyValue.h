//
//  BLDNADevice+toKeyValue.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "BLDNADevice.h"

@interface BLDNADevice (toKeyValue)

- (NSDictionary *)toKeyValue;

+ (BLDNADevice *)deviceWithRemoteDict:(NSDictionary *)dict;

@end
