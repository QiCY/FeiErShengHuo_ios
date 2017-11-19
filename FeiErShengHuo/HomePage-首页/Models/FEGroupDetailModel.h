//
//  FEGroupDetailModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FEPictureModel.h"
#import "FEbaseModel.h"

@interface FEGroupDetailModel : FEbaseModel
@property(nonatomic,strong)NSString *thumb;// 图片
@property(nonatomic,strong)NSString *title;//标题;
@property(nonatomic,strong)NSString *descrip;//描述;
@property(nonatomic,strong)NSNumber *num;// 团购人数；
@property(nonatomic,strong)NSNumber *payNum;//已售；
@property(nonatomic,assign) NSInteger marketPrice;//促销价;
@property(nonatomic,assign) NSInteger productPrice;// 原价
@property(nonatomic,assign)NSNumber *tuanId;
@property(nonatomic,strong)NSArray *slideList;//轮播图


@end
