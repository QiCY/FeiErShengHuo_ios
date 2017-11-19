//
//  FEOpenDoorModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/10.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"

@interface FEOpenDoorModel : FEbaseModel
@property(nonatomic,strong)NSString *openId;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *lockId;
@property(nonatomic,strong)NSString *doorName;
@property(nonatomic,strong)NSString *communityMark;
@property(nonatomic,strong) NSString * validity;
@property(nonatomic,strong)NSString *alias;
@property (nonatomic, strong) NSString *doorId;
@property (nonatomic, strong) NSString *pid;
@end
