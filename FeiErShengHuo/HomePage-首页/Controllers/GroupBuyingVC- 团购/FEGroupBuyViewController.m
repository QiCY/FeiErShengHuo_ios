//
//  FEGroupBuyViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupBuyViewController.h"
#import "FEGroupBuyDetailViewController.h"
#import "FEGroupedCell.h"
#import "FEgroupBuyModel.h"

@interface FEGroupBuyViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *image;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FEGroupBuyViewController

- (void)initView
{
    self.dataArray = [[NSMutableArray alloc] init];
    self.title = @"邻里团";
    self.groupBuyTab = [UITableView groupTableView];
    self.groupBuyTab.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.groupBuyTab.tableHeaderView = [MYUI createViewFrame:CGRectMake(0, 0, MainW, 0.01) backgroundColor:[UIColor clearColor]];
    self.groupBuyTab.delegate = self;
    self.groupBuyTab.dataSource = self;
    self.groupBuyTab.sectionFooterHeight = 15;
    self.groupBuyTab.sectionHeaderHeight = 0.01;
    self.groupBuyTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.groupBuyTab];
}

- (void)doRequest
{
    
    NSString *str = @"020appd/nauriBin/show";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                       NSLog(@"dic--------%@", dic);

                                                       NSArray *array = [FEgroupBuyModel mj_objectArrayWithKeyValuesArray:dic[@"cXcommunityTuans"]];
                                                       self.dataArray = [NSMutableArray arrayWithArray:array];

                                                       FEgroupBuyModel *curModel = self.dataArray[0];
                                                       NSString *url = curModel.thumb;

                                                       //处理网络图片大小
                                                       NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                                                       UIImage *image = [UIImage imageWithData:data];
                                                       //        NSLog(@"w = %f,h = %f" ,image.size.width,image.size.height);
                                                       //        NSLog(@"宽高比---%f",image.size.height/image.size.width);
                                                       CGFloat HW = 0.5;//image.size.height / image.size.width;
                                                       NSLog(@"宽高比----%f-----", HW);

                                                       if (array.count <= 0) {
                                                           [RYLoadingView showNoResultView:self.groupBuyTab];
                                                       }else{
                                                           [RYLoadingView hideNoResultView:self.groupBuyTab];
                                                       }

                                                       [self.groupBuyTab reloadData];

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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 15)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEgroupBuyModel *curModel = _dataArray[indexPath.section];
    return [FEGroupedCell countHeightWithModel:curModel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"FEGroupedCell";
    FEGroupedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[FEGroupedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WeakSelf;
    cell.block = ^(UIButton *btn) {
        StrongSelf;
        // NSInteger *index=btn.tag;
        FEgroupBuyModel *curModel = _dataArray[indexPath.section];
        FEGroupBuyDetailViewController *detaiVC = [[FEGroupBuyDetailViewController alloc] init];
        detaiVC.index = curModel.tuanId;
        [strongSelf.navigationController pushViewController:detaiVC animated:YES];
    };
    FEgroupBuyModel *curModel = _dataArray[indexPath.section];
    [cell setUpCellWithModel:curModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSInteger *index=btn.tag;
    FEgroupBuyModel *curModel = _dataArray[indexPath.section];
    FEGroupBuyDetailViewController *detaiVC = [[FEGroupBuyDetailViewController alloc] init];
    detaiVC.index = curModel.tuanId;
    [self.navigationController pushViewController:detaiVC animated:YES];
}

@end
