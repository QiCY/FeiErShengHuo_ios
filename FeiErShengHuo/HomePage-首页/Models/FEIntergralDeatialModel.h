//
//  FEIntergralDeatialModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEIntergralDeatialModel : NSObject
@property(nonatomic,strong)NSString *integralGoodTitle;
@property(nonatomic,strong)NSString *integralAddress;
@property(nonatomic,strong)NSString *integralGoodUrl;
@property(nonatomic,strong)NSNumber *integralId;
@property(nonatomic,strong)NSNumber *integralCredit;


@property(nonatomic,strong)NSString *intgralGoodType;
@property(nonatomic,strong) NSString * integralPic;
@property(nonatomic,strong)NSString *startTimeStr;
@property(nonatomic,strong)NSString *endTimeStr;
@property(nonatomic,strong)NSNumber *integralPrice;
@property(nonatomic,strong)NSString *precautions;
@property(nonatomic,strong)NSString *exchangeProcess;
@property(nonatomic,strong)NSString  *validPeriod;  
@property(nonatomic,strong)NSNumber *status;


@end

/*
"integralGoodTitle" = 端午特价礼盒,
"integralAddress" = 江苏省南通市中南城A座    15851326666,
"startTimeStr" = 2017-04-16,
"integralId" = 1,
"endTimeStr" = 2017-07-31,
"integralCredit" = 100,
"integralPic" = https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496656379287&di=f3d7f6a8e986af1a74d0f23236500254&imgtype=0&src=http%3A%2F%2Fp0.55tuanimg.com%2Fstatic%2Fgoods%2Fgoods%2F2012%2F06%2F12%2F17%2Fgoods_1339493960_2215.jpg,
"intgralGoodType" = 特价,
"integralGoodUrl" = <null>,
"endTime" = 1501430400,
"integralPrice" = 89,
"startTime" = 1492272000,
"validPeriod" = 领取后5天内有效,
"status" = 1,
 
 */
