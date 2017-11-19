//
//  FECarGoodsModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FECarGoodsModel : NSObject
@property(nonatomic,strong)NSString *descrip;
@property(nonatomic,strong)NSString *thumb;

@property(nonatomic,strong)NSNumber *cartId;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong) NSNumber * goodSId;
@property(nonatomic,strong)NSNumber *total;

@property(nonatomic,strong)NSNumber *weid;
@property(nonatomic,strong)NSNumber *dateLine;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSNumber  * price;
@property(nonatomic,strong) NSNumber * marketPrice;
@property(nonatomic,assign)NSNumber *regionid;
@property(nonatomic,strong)NSString * isChose;
@property(nonatomic,strong)NSString *ishidden;






@end
