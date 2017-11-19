//
//  FEMyRegionViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEMyRegionViewController.h"

@interface FEMyRegionViewController () < UITableViewDataSource, UITableViewDelegate >
@property (nonatomic, strong) UITableView *myRegion;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FEMyRegionViewController
//-(NSMutableArray *)dataArray
//{
//    _dataArray=[[NSMutableArray alloc]init];
//    return _dataArray;
//
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self doRequest];
}
- (void)initView

{
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(genhuan) andType:item_genhuan];

    _dataArray = [[NSMutableArray alloc] init];

    self.title = @"我的小区";

    self.myRegion = [UITableView groupTableView];
    self.myRegion.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.myRegion.delegate = self;
    self.myRegion.dataSource = self;
    self.myRegion.sectionFooterHeight = 0.01;
    self.myRegion.sectionHeaderHeight = 0.01;
    //self.myRegion.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.myRegion.tableHeaderView = view;
    [self.view addSubview:self.myRegion];
}
- (void)doRequest
{
    FELoginInfo *info = [LoginUtil getInfoFromLocal];

    NSString *str = @"020appd/goto/showCommunity";

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"我的小区的Dic--%@", dic);

                                                     NSArray *array = [FEMyRegionModel mj_objectArrayWithKeyValuesArray:dic[@"commits"]];
                                                     ;
                                                     if (array.count > 0)
                                                     {
                                                         [RYLoadingView hideNoResultView:self.view];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView showNoResultView:self.myRegion];
                                                     }

                                                     _dataArray = [NSMutableArray arrayWithArray:array];

                                                     [self.myRegion reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)genhuan
{
    FESecondAddInfoViewController *vc = [[FESecondAddInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEMyRegionCellCellID = @"FEMyRegionCell";
    FEMyRegionCell *cell = [tableView dequeueReusableCellWithIdentifier:FEMyRegionCellCellID];
    if (cell == nil)
    {
        cell = [[FEMyRegionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEMyRegionCellCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FEMyRegionModel *curModel = _dataArray[indexPath.section];
    cell.model = curModel;

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 1)];
    view.backgroundColor = Colorgrayall239;

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEMyRegionModel *model = _dataArray[indexPath.section];
    [self change:model];
}

- (void)change:(FEMyRegionModel *)model
{
    NSString *str = @"020appd/goto/xiugaiCommunity";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:model.communityCommitId forKey:@"communityCommitId"];
    //     [dic setObject:model.communityCommitId forKey:@"regionId"];
    //     [dic setObject:model.communityCommitId forKey:@"homeAdress"];
    //     [dic setObject:model.communityCommitId forKey:@"identity"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"更换成功Dic--%@", dic);

                                                     [self.navigationController popViewControllerAnimated:YES];

                                                     FELoginInfo *info = [LoginUtil getInfoFromLocal];
                                                     info.regionTitle = model.homeAdress;
                                                     info.isValidate = model.vaildata;
                                                     info.villageId = model.villageId;
                                                     [LoginUtil saveing:info];
                                                     [self.navigationController popViewControllerAnimated:YES];
                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

@end
