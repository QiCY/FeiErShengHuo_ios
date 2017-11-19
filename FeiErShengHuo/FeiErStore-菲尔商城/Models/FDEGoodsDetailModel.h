//
//  FDEGoodsDetailModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FECarouselList.h"
#import "FEcommodityimgList.h"
@interface FDEGoodsDetailModel : NSObject
@property(nonatomic,strong)NSString *title;//标题
@property(nonatomic,strong)NSString *origin;// 产地
@property(nonatomic,strong)NSString *carousel;
@property(nonatomic,strong)NSString *sales;// 销量
@property(nonatomic,strong)NSString *expressDelivery;//快递
@property(nonatomic,strong)NSString *brand;//品牌
@property(nonatomic,strong) NSString * descrip;// 描述
@property(nonatomic,assign) NSInteger  productPrice;//商品价格；
@property(nonatomic,assign)NSInteger  marketPrice;//市场价

@property(nonatomic,strong)NSString *packingMethod;//包装方法

@property(nonatomic,strong)NSMutableArray *carouselList;
@property(nonatomic,strong)NSMutableArray *commodityimgList;



@end
