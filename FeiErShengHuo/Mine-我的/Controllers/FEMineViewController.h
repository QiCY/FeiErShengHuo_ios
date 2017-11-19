//
//  FEMineViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "mineTableViewCell.h"
#import "MineHeaderView.h"
#import "MineAreaView.h"
#import "FEHeadTableView.h"
#import "FELoginViewController.h"
#import "FEBaseNavControllerViewController.h"
#import "FEPersonalViewController.h"
#import "FEAddinfoViewController.h"
#import "FEBalanceRechargeViewController.h"
#import "FENoticeViewController.h"
#import "FEComplainViewController.h"
#import "FERepairViewController.h"
#import "FESecondHandViewController.h"
@interface FEMineViewController : FEBaseViewController
{
    FEHeadTableView  * mytabView;
    MineHeaderView *personView;
    
    CGFloat contentOffSet;//记录视图的偏移位置
    
    NSString *username;
    NSString *phone;
    UIImage *headimage;
    NSString *aeraStr;
    UILabel *integralLab;
    UILabel *balanceLab;
    UIButton *signBtn;
    UIButton *emailBtn;
    
    
}

@property(nonatomic,strong)UITableView *mineTableview;
@property(nonatomic,strong)UIView *mineTabviewHeader;



@end
