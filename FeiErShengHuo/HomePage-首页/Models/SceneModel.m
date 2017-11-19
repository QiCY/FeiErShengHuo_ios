//
//  SceneModel.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/21.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "SceneModel.h"
#import "BLDNADevice+toKeyValue.h"

@implementation SceneModel

- (instancetype)init
{
    if (self = [super init]) {
        self.deviceList = [NSMutableArray array];
    }
    return self;
}

+ (SceneModel *)modelWithDict:(NSDictionary *)dict
{
    SceneModel *model = [SceneModel mj_objectWithKeyValues:dict];
    [model.deviceList removeAllObjects];
    
    for (NSDictionary *item in dict[@"deviceList"]) {
        BLDNADevice *device = [BLDNADevice deviceWithRemoteDict:item[@"deveiceInfo"]];
        [model.deviceList addObject:device];
    }
    return model;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sceneId":@"scenesId"};
}

@end
