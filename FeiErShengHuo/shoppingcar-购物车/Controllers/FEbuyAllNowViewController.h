//
//  FEbuyAllNowViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEGoodModel.h"
#import "GGActionSheet.h"
#import "FECarGoodsModel.h"

@class FEbuyAllNowViewController;
@protocol FEbuyAllNowViewControllerdelegete <NSObject>

-(void)choseddelegete;

@end

@interface FEbuyAllNowViewController : FEBaseViewController

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *NdataArray;

@property(nonatomic,assign)NSNumber *buyFromWhereType;



@property(nonatomic,assign)NSInteger IBAIprice;
@property(nonatomic,weak)id<FEbuyAllNowViewControllerdelegete>delegete;


@end
