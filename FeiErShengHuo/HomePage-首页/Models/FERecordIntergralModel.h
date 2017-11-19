//
//  FERecordIntergralModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"

@interface FERecordIntergralModel : FEbaseModel
@property(nonatomic,strong)NSString *integralGoodUrl;
@property(nonatomic,strong)NSString *integralGoodTitle;
@property(nonatomic,strong)NSNumber *integralCredit;
@property(nonatomic,strong)NSNumber *integralPrice;

@property(nonatomic,strong)NSString *orderNum;


@end
