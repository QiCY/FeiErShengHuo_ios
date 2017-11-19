//
//  FEActivityViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEActivityViewController.h"
#import "FEActivityCell.h"
#import "FEActivityDetailViewController.h"
#import "FEAvtivityModel.h"

@interface FEActivityViewController () < UITableViewDataSource, UITableViewDelegate ,SDCycleScrollViewDelegate>
{
     SDCycleScrollView *_cycleScrollView2;
    CGFloat HW;
}
@property (nonatomic, strong) UITableView *ActivityTabView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *headView;

@end

@implementation FEActivityViewController

- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}
- (void)initView
{
    self.title = @"社区活动";
    self.ActivityTabView = [UITableView groupTableView];
    self.ActivityTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.ActivityTabView.delegate = self;
    self.ActivityTabView.dataSource = self;
    self.ActivityTabView.sectionHeaderHeight = 0.01;
    self.ActivityTabView.sectionFooterHeight = 0.01;
    self.ActivityTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
   
   
    [self.view addSubview:self.ActivityTabView];
}

- (void)doRequest
{
    NSString *str = @"020appd/activityCommunity/activityInfo";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"小区活动列表  dic----%@", dic);

                                                     NSArray *array = [FEAvtivityModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityActivities"]];
                                                       
                                                       if (array.count <= 0) {
                                                           [RYLoadingView showNoResultView:self.ActivityTabView];
                                                       }else{
                                                           [RYLoadingView hideNoResultView:self.ActivityTabView];
                                                       }
                                                       

                                                     _dataArray = [NSMutableArray arrayWithArray:array];
                                                       NSMutableArray *imageA=[[NSMutableArray alloc]init];
                                                       NSArray *imageDicArray=dic[@"xCommunitySlidePublics"];
                                                       for (NSDictionary *imageDic in imageDicArray) {
                                                           NSString *url=imageDic[@"thumb"];
                                                           [imageA addObject:url];
                                                       }
                                                    
                                                       NSString *url = imageA[0];
                                                       //处理网络图片大小
                                                       NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                                                       UIImage *image = [UIImage imageWithData:data];
                                                       NSLog(@"w = %f,h = %f", image.size.width, image.size.height);
                                                       NSLog(@"宽高比---%f", image.size.height / image.size.width);
                                                       HW = 0.5;//image.size.height / image.size.width;

                                                       
                                                       self.ActivityTabView.tableHeaderView =self.headView;
                                                       _cycleScrollView2.imageURLStringsGroup=[imageA copy];
                                                       
                                                     [_ActivityTabView reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}


- (UIView *)headView
{
    if (!_headView)
    {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, MainW * HW)];
        _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MainW, MainW * HW) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView2.autoScrollTimeInterval = 5;
        
        _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [_headView addSubview:_cycleScrollView2];
    }
    return _headView;
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mineCellIndetify = @"FEActivityCell";
    FEActivityCell *cell = (FEActivityCell *)[tableView dequeueReusableCellWithIdentifier:mineCellIndetify];
    if (cell == nil)
    {
        cell = [[FEActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FEAvtivityModel *model = _dataArray[indexPath.row];
    [cell setupCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEAvtivityModel *model = _dataArray[indexPath.row];
    FEActivityDetailViewController *VC = [[FEActivityDetailViewController alloc] init];
    VC.activityId = model.activityId;

    [self.navigationController pushViewController:VC animated:YES];
}

@end
