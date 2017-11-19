//
//  FEMyStarViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/28.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEMyStarViewController.h"
#import "FEMyStarViewCell.h"
#import "FEStarModel.h"

@interface FEMyStarViewController () < UITableViewDelegate, UITableViewDataSource >
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *MyStarTabView;

@end

@implementation FEMyStarViewController

- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (void)initView
{
    self.title = @"我的收藏";

    self.MyStarTabView = [UITableView groupTableView];
    self.MyStarTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.MyStarTabView.delegate = self;
    self.MyStarTabView.dataSource = self;
    self.MyStarTabView.sectionFooterHeight = 0.01;
    self.MyStarTabView.sectionHeaderHeight = 0.01;
    //self.MyStarTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.MyStarTabView.tableHeaderView = view;
    [self.view addSubview:self.MyStarTabView];
}

- (void)doRequest
{
    NSString *str = @"020appd/collection/show";

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {

                                                     NSLog(@"收藏的额字典--%@", dic);

                                                     NSArray *array = [FEStarModel mj_objectArrayWithKeyValuesArray:dic[@"userCollections"]];
                                                     if (array.count > 0)
                                                     {
                                                         [RYLoadingView hideNoResultView:self.view];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView showNoResultView:self.MyStarTabView];
                                                     }

                                                     self.dataArray = [NSMutableArray arrayWithArray:array];
                                                     [_MyStarTabView reloadData];

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEMyStarViewCellID = @"FEMyStarViewCell";
    FEMyStarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FEMyStarViewCellID];
    if (cell == nil)
    {
        cell = [[FEMyStarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEMyStarViewCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FEStarModel *model = _dataArray[indexPath.section];
    [cell setupCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //

    FEStarModel *model = _dataArray[indexPath.section];

    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreDetialViewController *detailVC = [[StoreDetialViewController alloc] init];

    
    FEGoodModel *goodmodel =[[FEGoodModel alloc]init];
    goodmodel.title=model.goodsTitle;
    goodmodel.thumb=model.goodThumb;
    goodmodel.marketprice=[model.productPrice integerValue];
    goodmodel.Gtotal=[NSNumber numberWithInt:1];
    
    detailVC.goodsId = model.goodsId;
    detailVC.curModel=goodmodel;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

//以下是添加删除功能的代码
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self deleterequest:indexPath];
    }
}

- (void)deleterequest:(NSIndexPath *)index
{
    FEStarModel *model = _dataArray[index.section];

    NSString *str = @"020appd/collection/quxiao";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:model.goodsId forKey:@"goodsId"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSMutableArray *array = [NSMutableArray arrayWithArray:_dataArray];
                                                     [array removeObjectAtIndex:index.row];
                                                     [_dataArray removeAllObjects];
                                                     _dataArray = [NSMutableArray arrayWithArray:array];
                                                     [_MyStarTabView reloadData];
                                                     [FENavTool showAlertViewByAlertMsg:@"删除成功" andType:@"提示"];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

@end
