//
//  FEStarModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/28.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEStarModel : NSObject
@property(nonatomic,strong)NSString *goodsTitle;
@property(nonatomic,strong)NSString *goodsDescription;
@property(nonatomic,strong)NSNumber *productPrice;
@property(nonatomic,strong)NSNumber *collectionId;
@property(nonatomic,strong)NSString *goodThumb;
@property(nonatomic,strong) NSNumber * goodsId;
@property(nonatomic,assign)NSNumber *tuanId;

@end

/*
 "userId" = 0,
 "dateLineStr" = <null>,
 "goodsId" = 369,
 "goodsTitle" = 优选100 海南妃子笑荔枝 1kg装 新鲜水果,
 "collectionId" = 0,
 "dateLine" = 0,
 "goodsDescription" = 果肉莹白如冰雪，浆液酸甜如醴酪,
 "productPrice" = 3000,
 "goodThumb" = http://pic.xjbyte.com/store/46/56/lz.png,

*/
