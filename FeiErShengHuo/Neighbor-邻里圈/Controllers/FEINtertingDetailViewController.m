//
//  FEINtertingDetailViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEINtertingDetailViewController.h"
#import "FEIntertingDetailModel.h"
#import "FEItertingDetailCell.h"

#import "FEIntertingDeitalWebViewController.h"

@interface FEINtertingDetailViewController () < UITableViewDataSource, UITableViewDelegate >
{
    CGFloat HW;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *interstingTabView;

@end

@implementation FEINtertingDetailViewController

- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (void)initView
{
    self.title = self.title;
    self.interstingTabView = [UITableView groupTableView];
    self.interstingTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.interstingTabView.delegate = self;
    self.interstingTabView.dataSource = self;
    self.interstingTabView.sectionHeaderHeight = 0.01;
    self.interstingTabView.sectionFooterHeight = 0.01;
    self.interstingTabView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.interstingTabView.tableHeaderView = view;
    [self.view addSubview:self.interstingTabView];
}

- (void)doRequest
{
    NSString *str = @"020appd/interest/fm/showTopic";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_themeID forKey:@"themeId"];
    NSLog(@"id-- %@", _themeID);

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {

                                                     NSLog(@"展示兴趣调频dic-----%@", dic);
                                                       
                                                     NSArray *array = [FEIntertingDetailModel mj_objectArrayWithKeyValuesArray:dic[@"topicPosts"]];
                                                     _dataArray = [NSMutableArray arrayWithArray:array];
                                                       
//                                                       
//                                                      //倒叙排列
//                                                     _dataArray=(NSMutableArray *)[[_dataArray reverseObjectEnumerator] allObjects];
//                                                       
                                                       
                                                       
                                                       if (_dataArray.count>0) {
                                                           [RYLoadingView hideNoResultView:self.interstingTabView];
                                                           
                                                           FEIntertingDetailModel *model = _dataArray[0];
                                                           NSString *url = model.topicPic;
                                                           
                                                           //处理网络图片大小
                                                           NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                                                           UIImage *image = [UIImage imageWithData:data];
                                                           //        NSLog(@"w = %f,h = %f" ,image.size.width,image.size.height);
                                                           //        NSLog(@"宽高比---%f",image.size.height/image.size.width);
                                                           HW =0.5; //image.size.height / image.size.width;
                                                           NSLog(@" 兴趣-宽高度比2222 ---%f---", HW);
                                                           
                                                           [_interstingTabView reloadData];
                                                       }else{
                                                           
                                                           [RYLoadingView showNoResultView:self.interstingTabView];
                                                           
                                                       }
                                                
                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (MainW - 20) * 0.5 + 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mineCellIndetify = @"FEItertingDetailCell";
    FEItertingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCellIndetify];
    if (cell == nil)
    {
        cell = [[FEItertingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    FEIntertingDetailModel *model = _dataArray[indexPath.row];
    [cell setupCellWithModel:model];

    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEIntertingDetailModel *model = _dataArray[indexPath.row];
    FEIntertingDeitalWebViewController *vc = [[FEIntertingDeitalWebViewController alloc] init];
    vc.title = model.topicTheme;
    vc.TopicId = model.topicId;
    vc.cuModel = model;

    [self.navigationController pushViewController:vc animated:YES];
}

@end
