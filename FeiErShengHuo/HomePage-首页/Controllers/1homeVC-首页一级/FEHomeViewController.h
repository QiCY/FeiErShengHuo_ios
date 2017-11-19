//
//  FEHomeViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEHomeCollectionBtnView.h"
#import "PullTableView.h"
#import "FEMyRegionViewController.h"
#import "FEHomeSmartViewController.h"
#import "FESmallNoticeModel.h"
@interface FEHomeViewController : FEBaseViewController
{
    UILabel *labroud;
    
}
@property(nonatomic,strong)UIView *tableheadview;
@property(nonatomic,strong)UITableView *hometableView;
@property(nonatomic,strong)NSMutableArray  *xiaofeiArray;



@end
