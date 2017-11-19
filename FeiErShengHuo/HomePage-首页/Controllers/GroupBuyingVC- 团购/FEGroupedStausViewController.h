//
//  FEGroupedStausViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/1.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEGroupDetailModel.h"

@interface FEGroupedStausViewController : FEBaseViewController
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *tunasn;

@property(nonatomic,strong) FEGroupDetailModel *model;


@end
