//
//  FEInterstingViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEInterstingViewController.h"
#import "FEINterstingModel.h"
#import "FEINtertingDetailViewController.h"
#import "FEInterstingCell.h"

@interface FEInterstingViewController () < UITableViewDelegate, UITableViewDataSource >

{
    CGFloat HW;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *interstingTabView;

@end

@implementation FEInterstingViewController

- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}
- (void)initView
{
    //
    self.title = @"兴趣调频";

    self.interstingTabView = [UITableView groupTableView];
    self.interstingTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.interstingTabView.delegate = self;
    self.interstingTabView.dataSource = self;
    self.interstingTabView.sectionHeaderHeight = 0.01;
    self.interstingTabView.sectionFooterHeight = 0.01;
    self.interstingTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.interstingTabView.tableHeaderView = view;
    [self.view addSubview:self.interstingTabView];
}
- (void)doRequest
{
    NSString *str = @"020appd/interest/fm/show";

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {

                                                     NSLog(@"展示兴趣调频dic-----%@", dic);
                                                     NSArray *array = [FEINterstingModel mj_objectArrayWithKeyValuesArray:dic[@"interestFMs"]];
                                                     _dataArray = [NSMutableArray arrayWithArray:array];

                                                     FEINterstingModel *model = _dataArray[0];

                                                     NSString *url = model.fmPic;

                                                     //处理网络图片大小
                                                     NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                                                     UIImage *image = [UIImage imageWithData:data];
                                                     //        NSLog(@"w = %f,h = %f" ,image.size.width,image.size.height);
                                                     //        NSLog(@"宽高比---%f",image.size.height/image.size.width);
                                                       HW = 0.5;//image.size.height / image.size.width;
                                                     NSLog(@" 兴趣-宽高度比 ---%f---", HW);

                                                     [_interstingTabView reloadData];

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
    return MainW * 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mineCellIndetify = @"FEInterstingCell";
    FEInterstingCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCellIndetify];
    if (cell == nil)
    {
        cell = [[FEInterstingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    FEINterstingModel *model = _dataArray[indexPath.row];
    [cell setupCellWithModel:model];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEINterstingModel *model = _dataArray[indexPath.row];

    FEINtertingDetailViewController *vc = [[FEINtertingDetailViewController alloc] init];
    vc.themeID = model.fmId;
    vc.title = model.fmTheme;

    [self.navigationController pushViewController:vc animated:YES];
}

@end
