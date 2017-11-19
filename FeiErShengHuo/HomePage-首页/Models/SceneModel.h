//
//  SceneModel.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/21.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"
#import "BLDNADevice.h"

@interface SceneModel : FEbaseModel

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sceneId;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSMutableArray <BLDNADevice *>*deviceList;
@property (nonatomic,strong) NSString *addTime;

+ (SceneModel *)modelWithDict:(NSDictionary *)dict;

@end
