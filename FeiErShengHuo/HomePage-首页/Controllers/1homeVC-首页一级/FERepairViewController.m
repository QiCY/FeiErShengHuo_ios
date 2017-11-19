//
//  FERepairViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FERepairViewController.h"
#import "FERepairCell.h"
#import "FERepairDtailViewController.h"
#import "FERepirModel.h"
#import "FEWriteRepairViewController.h"
#import "FEphotoCell.h"
#import "STPopupController.h"

@interface FERepairViewController () < UITableViewDelegate, UITableViewDataSource, PullTableViewDelegate >
{
    NSInteger curPage;
    NSInteger totNum;
    NSInteger pageSize;
    BOOL isLoadMore;
}

@end

@implementation FERepairViewController
- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self ddoRequest];
    
}
- (void)initView
{
//    //监听发布动态的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publishCallBack:) name:NOTI_REFRESH_REPAIR object:nil];

    self.title = @"小区报修";
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(publish) andType:item_whrite];

    self.photoArr = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"icon_addpic"], nil];
    self.repairTab = [UITableView groupTableView];
    self.repairTab.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.repairTab.delegate = self;
    self.repairTab.dataSource = self;
    self.repairTab.sectionHeaderHeight = 0.01;
    self.repairTab.sectionFooterHeight = 0.01;
    self.repairTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.repairTab.tableHeaderView = view;
    [self.view addSubview:self.repairTab];
}

//- (void)publishCallBack:(NSNotification *)info
//{
//    [self doRequest];
//}
- (void)ddoRequest
{
    NSString *str = @"020appd/repaire/show";

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {

                                                     NSLog(@"bao修liebiao----%@", dic);
                                                     NSArray *array = [FERepirModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityRepaires"]];

                                                     self.dataArray = [NSMutableArray arrayWithArray:array];
                                                     [self.repairTab reloadData];

                                                     if (array.count > 0)
                                                     {
                                                         [RYLoadingView hideNoResultView:self.view];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView showNoResultView:self.repairTab];
                                                     }

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 5)];
    secView.backgroundColor = [UIColor clearColor]; //[UIColor clearColor];
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FERepairCellID = @"FERepairCell";
    FERepairCell *cell = [tableView dequeueReusableCellWithIdentifier:FERepairCellID];
    if (cell == nil)
    {
        cell = [[FERepairCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FERepairCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.cornerRadius = 5;
        cell.layer.masksToBounds = YES;
    }
    FERepirModel *model = _dataArray[indexPath.section];

    [cell setupCellWithModel:model];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FERepirModel *model = _dataArray[indexPath.section];
    FERepairDtailViewController *VC = [[FERepairDtailViewController alloc] init];
    VC.RModel = model;

    [self.navigationController pushViewController:VC animated:YES];
}

- (void)publish
{
    FEWriteRepairViewController *vc = [[FEWriteRepairViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
