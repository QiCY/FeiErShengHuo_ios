//
//  FERepairViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "STPopupController.h"
#import "FEphotoCell.h"

@interface FERepairViewController : FEBaseViewController
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSMutableDictionary *imageUrlArrDic;
@property(nonatomic,strong)UITableView *repairTab;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end
