//
//  FEGoodModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FEbaseModel.h"

//
//"pcate" = 0,
//"goodsId" = 68,
//"title" = 雪碧,
//"productprice" = 0,
//"thumb" = http://192.168.1.200/store/36/36/68_131291809870028988.jpg,
//"marketprice" = 0,
//"description" = ,

@interface FEGoodModel : FEbaseModel
@property(nonatomic,strong)NSNumber *pcate;
@property(nonatomic,strong)NSNumber *goodsId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger productprice;
@property(nonatomic,strong)NSString *thumb;
@property(nonatomic,strong)NSString *descrip;
@property(nonatomic,assign)NSInteger marketprice;
@property(nonatomic,strong)NSNumber *dateLine;
@property(nonatomic,strong)NSNumber *Gtotal;
@property(nonatomic,strong)NSString *origin;


@end
