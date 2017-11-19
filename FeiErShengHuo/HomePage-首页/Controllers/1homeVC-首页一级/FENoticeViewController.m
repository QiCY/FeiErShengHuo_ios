//
//  FENoticeViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FENoticeViewController.h"
#import "FENoticeCell.h"
#import "FENoticeDetailViewController.h"
#import "FENoticeModel.h"

@interface FENoticeViewController () < UITableViewDelegate, UITableViewDataSource >
{
    NSInteger curPage;
    NSInteger totNum;
    NSInteger pageSize;
    BOOL isLoadMore;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FENoticeViewController

- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (void)initView
{
    self.title = @"社区公告";
    self.noticeListTableView = [UITableView groupTableView];
    self.noticeListTableView.frame = CGRectMake(0, -5, MainW, MainH - 64);
    self.noticeListTableView.delegate = self;
    self.noticeListTableView.dataSource = self;
    self.noticeListTableView.sectionHeaderHeight = 0.01;
    self.noticeListTableView.sectionFooterHeight = 0.01;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.noticeListTableView.tableHeaderView = view;

    [self.view addSubview:self.noticeListTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (self.block)
    {
        self.block();
    }
}

- (void)doRequest
{
    NSString *str = @"020appd/annonce/show";

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@" 公告列表---%@", dic);
                                                     NSArray *array = [FENoticeModel mj_objectArrayWithKeyValuesArray:dic[@"announces"]];
                                                     self.dataArray = [NSMutableArray arrayWithArray:array];

                                                     if (array.count > 0)
                                                     {
                                                         [RYLoadingView hideNoResultView:self.view];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView showNoResultView:self.noticeListTableView];
                                                     }

                                                     [self.noticeListTableView reloadData];

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
    //return _dataArray.count;
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 5)];
    secView.backgroundColor = [UIColor clearColor];
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    FEDynamicModel *curModel = _dataArray[indexPath.section];
    //    CGFloat hgnum = [FEDynamicStateCell countCellHeightByModel:curModel isContainComment:YES];
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FENoticeCellID = @"FENoticeCell";
    FENoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:FENoticeCellID];
    if (cell == nil)
    {
        cell = [[FENoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FENoticeCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.cornerRadius = 6;
        cell.layer.masksToBounds = YES;
    }
    FENoticeModel *model = _dataArray[indexPath.section];
    [cell setupCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FENoticeModel *model = _dataArray[indexPath.section];

    FENoticeDetailViewController *detailVC = [[FENoticeDetailViewController alloc] init];
    detailVC.announceId = model.announceId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
