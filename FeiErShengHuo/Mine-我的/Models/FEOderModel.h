//
//  FEOderModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/28.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEOderModel : NSObject
@property(nonatomic,strong)NSString *goodTitle;
@property(nonatomic,strong)NSNumber *orderId;
@property(nonatomic,strong)NSNumber *storeId;

@property(nonatomic,strong)NSNumber *goodNum;
@property(nonatomic,strong)NSString *goodThumb;
@property(nonatomic,strong)NSString *orderNum;
@property(nonatomic,strong)NSString *goodDescription;
@property(nonatomic,strong)NSNumber *productPrice;
@property(nonatomic,strong) NSNumber * goodsId;
@property(nonatomic,strong)NSNumber *marketPrice;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSString *delivery;
@property(nonatomic,strong)NSString *deliveryNum;
@end

/*
"orderNum" = CCE288537BA9E4F75985BD52036C7008,
"goodNum" = 1,
"orderName" = 陆志勇,
"orderDatreLineStr" = 2017-06-20 16:34:33,
"goodThumb" = http://pic.xjbyte.com/store/44/55/342_131323941880332902.jpg,
"userId" = 0,
"productPrice" = 2000,
"orderPhone" = 15240543995,
"orderId" = 65,
"goodTitle" = 2017新茶云雾绿茶4盒共500克,
"orderDatreLine" = 1497947673,
"orderAdress" = 南通,
"goodDescription" = 缠绕在齿间的清香新茶,
"goodsId" = 0,

*/
