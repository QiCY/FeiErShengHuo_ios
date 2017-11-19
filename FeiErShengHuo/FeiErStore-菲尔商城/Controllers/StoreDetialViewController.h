//
//  StoreDetialViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEGoodModel.h"
#import "XHWebImageAutoSize.h"
#import "UIImageView+WebCache.h"
#import "FEImageTableViewCell.h"
#import "FEcommodityimgList.h"
#import "FEkeFuViewController.h"
#import "DemoVC1Cell.h"
@interface StoreDetialViewController : FEBaseViewController
@property(nonatomic,strong)UIView *tableheadview;
@property(nonatomic,strong)NSNumber *goodsId;
@property(nonatomic,strong)FEGoodModel *curModel;
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView2;


@end
