//
//  FEPayViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEPayViewController.h"
#import "FEPayCell.h"

@interface FEPayViewController () < UITableViewDelegate, UITableViewDataSource, PullTableViewDelegate >
{
    NSInteger curPage;
    NSInteger totNum;
    NSInteger pageSize;
    BOOL isLoadMore;
}

@end

@implementation FEPayViewController

- (void)initView
{
    self.title = @"物业缴费";

    [self.view addSubview:self.pullTableView];
}
- (PullTableView *)pullTableView
{
    self.pullTableView = [[PullTableView alloc] initWithFrame:CGRectMake(9, 0, MainW - 18, MainH)];
    _pullTableView.delegate = self;
    _pullTableView.dataSource = self;
    _pullTableView.pullDelegate = self;
    _pullTableView.refreshType = PRPullBoth;
    _pullTableView.backgroundColor = Colorgrayall239;
    _pullTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_pullTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _pullTableView.showsVerticalScrollIndicator = NO;

    curPage = 1;
    pageSize = 10;

    return _pullTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 9)];
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
    static NSString *FEPayCellID = @"FEPayCell";
    FEPayCell *cell = [tableView dequeueReusableCellWithIdentifier:FEPayCellID];
    if (cell == nil)
    {
        cell = [[FEPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEPayCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    //    FEDynamicModel *curModel = _dataArray[indexPath.section];
    //    cell.curIndex = indexPath.section;
    //    cell.currentModel = curModel;
    //    cell.delegate = self;
    //    if (curModel) {
    //        [cell setUpCellViewAndModel:curModel];
    //    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_pullTableView pullTableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_pullTableView pullTableViewDidEndDragging:scrollView];
}

#pragma mark PullTableViewDelegate
//开始下拉刷新时调用
- (void)pullTableViewDidStartPullDownRefresh:(PullTableView *)tableView
{
    _pullTableView.reachedTheEnd = NO;
    curPage = 1;
    //[self reqDataFromServer];
}

//开始上拉加载更多时调用
- (void)pullTableViewDidStartPullUpLoadMore:(PullTableView *)tableView
{
    if (curPage < totNum)
    {
        //分页请求
        curPage++;
        isLoadMore = YES;
        //[self reqDataFromServer];
    }
    else
    {
        [_pullTableView stopPullTableViewRefresh];
        //没有更多数据了
        if (curPage == totNum)
        {
            _pullTableView.reachedTheEnd = YES;
        }
    }
}

- (void)stopPullRefresh
{
    [_pullTableView stopPullTableViewRefresh];
}

@end
