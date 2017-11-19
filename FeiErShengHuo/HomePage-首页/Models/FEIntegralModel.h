//
//  FEIntegralModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEIntegralModel : NSObject
@property(nonatomic,strong)NSString *integralGoodTitle;
@property(nonatomic,strong)NSString *integralAddress;
@property(nonatomic,strong)NSString *integralGoodUrl;
@property(nonatomic,strong)NSNumber *integralId;
@property(nonatomic,strong)NSNumber *integralCredit;

@property(nonatomic,strong)NSString *intgralGoodType;
@property(nonatomic,strong) NSString * integralPic;
@property(nonatomic,strong)NSString *startTimeStr;
@property(nonatomic,strong)NSString *endTimeStr;





@end


/*

"integralGoodTitle" = 端午特价礼盒,
"integralAddress" = <null>,
"startTimeStr" = <null>,
"integralId" = 1,
"endTimeStr" = <null>,
"integralCredit" = 100,
"integralPic" = <null>,
"intgralGoodType" = 特价,
"integralGoodUrl" = https://
 
 */
