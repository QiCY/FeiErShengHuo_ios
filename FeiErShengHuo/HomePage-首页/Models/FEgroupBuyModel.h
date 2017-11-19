//
//  FEgroupBuyModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEgroupBuyModel : NSObject
@property(nonatomic,strong)NSString *thumb;// 图片
@property(nonatomic,strong)NSString *title;//标题;
@property(nonatomic,strong)NSString *descrip;//描述;
@property(nonatomic,strong)NSNumber *num;// 团购人数；
@property(nonatomic,strong)NSString *endTimeStr;//时间；
@property(nonatomic,assign) int productPrice;//价格；
@property(nonatomic,assign)NSNumber *tuanId;
//marketPrice
@property(nonatomic,assign) int marketPrice;//价格；

@end
