//
//  FEMyRegionModel.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"

@interface FEMyRegionModel : FEbaseModel
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSString *buildingInfo;
@property(nonatomic,strong)NSNumber *vaildata;
@property(nonatomic,strong)NSString *homeAdress;
@property(nonatomic,strong)NSNumber *villageId;
@property(nonatomic,strong)NSNumber *addTime;
@property(nonatomic,strong)NSNumber *communityCommitId;
@end

/*
 "userId" = 0,
 "buildingInfo" = 6栋9单元7室,
 "vaildata" = 0,
 "homeAdress" = 江苏捷通网络集团,
 "villageId" = 246,
 "addTime" = 0,
 "communityCommitId" = 73,
 */
