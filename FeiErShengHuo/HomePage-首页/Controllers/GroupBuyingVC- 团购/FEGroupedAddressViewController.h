//
//  FEGroupedAddressViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "GGActionSheet.h"
#import "FEGroupDetailModel.h"

@interface FEGroupedAddressViewController : FEBaseViewController
@property (nonatomic, strong)FEGroupDetailModel *model;  
@property(nonatomic,strong) GGActionSheet *actionSheetImg;
@property(nonatomic,strong) GGActionSheet *actionSheetTitle;
@property(nonatomic,strong)NSString *backurl;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end
