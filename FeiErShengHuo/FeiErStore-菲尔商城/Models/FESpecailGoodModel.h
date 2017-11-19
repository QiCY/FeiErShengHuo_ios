//
//  FESpecailGoodModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FESpecailGoodModel : NSObject
@property(nonatomic,strong)NSNumber *specialId;
@property(nonatomic,strong)NSNumber *typeId;
@property(nonatomic,strong)NSString *goodsName;
@property(nonatomic,strong)NSNumber *specialTime;
@property(nonatomic,strong)NSString *specialThumb;
@property(nonatomic,strong) NSString  * goodsDescription;
@property(nonatomic,assign)NSNumber *orginPrice;
@property(nonatomic,assign)NSNumber *nowPrice;
@property(nonatomic,assign)NSNumber *goodsId;
@end




/*

 "specialId" = 1,
 "typeId" = 0,
 "goodsName" = 圣牧全程有机儿童奶,
 "specialTime" = 1244860000,
 "specialThumb" = pic.xjbyte.com/store/17/23/smqcyjet.jpg,
 "goodsDescription" = <null>,
 "orginPrice" = 8600,
 "nowPrice" = 5400,



*/
