//
//  FEMyGorpedListViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEMyGorpedListViewController.h"
#import "FEGroupStuesController.h"
#import "FEMyGoupedCell.h"
#import "FEPersontuanModel.h"
@interface FEMyGorpedListViewController () < UITableViewDelegate, UITableViewDataSource >
@property (nonatomic, strong) NSMutableArray *dataarray;
@property (nonatomic, strong) UITableView *tabview;

@end

@implementation FEMyGorpedListViewController

- (NSMutableArray *)dataarray
{
    _dataarray = [[NSMutableArray alloc] init];
    return _dataarray;
}

- (void)initView
{
    self.title = @"我的团购";

    self.tabview = [UITableView groupTableView];
    self.tabview.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    self.tabview.sectionFooterHeight = 1;
    self.tabview.sectionHeaderHeight = 0.01;
    //self.tabview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.tabview.tableHeaderView = view;
    [self.view addSubview:self.tabview];
}

- (void)doRequest
{
    NSString *str = @"020appd/nauriBin/gerentuan";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {

                                                     NSLog(@"个人团购----%@", dic);
                                                     NSArray *array = [FEPersontuanModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityTuans"]];
                                                     self.dataarray = [NSMutableArray arrayWithArray:array];
                                                     if (array.count > 0)
                                                     {
                                                         [RYLoadingView hideNoResultView:self.view];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView showNoResultView:self.tabview];
                                                     }

                                                     [self.tabview reloadData];

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
  
    
    return _dataarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 1)];
    view.backgroundColor=Colorgrayall239;
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEMyGoupedCellCellID = @"FEMyGoupedCell";
    FEMyGoupedCell *cell = [tableView dequeueReusableCellWithIdentifier:FEMyGoupedCellCellID];
    if (cell == nil)
    {
        cell = [[FEMyGoupedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEMyGoupedCellCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FEPersontuanModel *model = _dataarray[indexPath.section];
    [cell setupCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEPersontuanModel *model = _dataarray[indexPath.section];

    FEGroupStuesController *vc = [[FEGroupStuesController alloc] init];
    vc.model = model;
    vc.tunasn = model.tuanSn;
    vc.url = model.pay_url;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
