//
//  FEbuyNowViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FDEGoodsDetailModel.h"
#import "FEGoodModel.h"
#import "FECarGoodsModel.h"

@class FEbuyNowViewController;

@protocol deleteCarDelgegete <NSObject>

-(void) deletecar:(FEGoodModel *)goodModel;

@end

@interface FEbuyNowViewController : FEBaseViewController
@property(nonatomic,strong)FDEGoodsDetailModel *curModel;
@property(nonatomic,weak)id<deleteCarDelgegete> delegete;

@property(nonatomic,strong)FEGoodModel *goodModel;

@property(nonatomic,assign)NSNumber *buyFromWhereType;



@end
