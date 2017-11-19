//
//  FEActivityDetailViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEActivityDetailViewController.h"
#import "FEActivityDetailModel.h"
#import "SDCycleScrollView.h"

@interface FEActivityDetailViewController () < UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate >
{
    UILabel *titleLab;
    UILabel *startLab;
    UILabel *endLab;
    UILabel *parcipateTimeLab;
    UILabel *addressLab;
    UILabel *personLimitLab;
    UILabel *contLab;
    UILabel *wayLab;
    UILabel *bottomperson;
    UILabel *parcipateNumLab;
    UIButton *exchangeBtn;
    SDCycleScrollView *_cycleScrollView2;
    CGFloat HW;
}
@property (nonatomic, strong) UITableView *activityDetailTabview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *imagesURLStrings; //让视图自动切换
@property (nonatomic, strong) UIView *tableheadview;

@property (nonatomic, strong) UIView *headView;

@end

@implementation FEActivityDetailViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSArray *)imagesURLStrings
{
    _imagesURLStrings = [[NSArray alloc] init];
    return _imagesURLStrings;
}
- (void)initView
{
    self.title = @"社区活动详情";

    self.activityDetailTabview = [UITableView groupTableView];
    self.activityDetailTabview.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.activityDetailTabview.delegate = self;
    self.activityDetailTabview.dataSource = self;
    self.activityDetailTabview.sectionHeaderHeight = 0.01;
    self.activityDetailTabview.sectionFooterHeight = 0.01;
    self.activityDetailTabview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.activityDetailTabview.tableHeaderView = view;
    [self.view addSubview:self.activityDetailTabview];
}
- (void)doRequest
{
    NSString *str = @"020appd/activityCommunity/detail";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:self.activityId forKey:@"activityId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"社区活动详情-----%@", dic);

                                                     FEActivityDetailModel *model = [FEActivityDetailModel mj_objectWithKeyValues:dic[@"xcommunityActivity"]];

                                                     [self.dataArray addObject:model];
                                                     //_imagesURLStrings=model.picList;
                                                     NSMutableArray *array2 = [[NSMutableArray alloc] init];
                                                     for (FEpicListModel *model2 in model.picList)
                                                     {
                                                         NSString *url = model2.activityUrl;
                                                         [array2 addObject:url];
                                                     }
                                                     _imagesURLStrings = [array2 copy];

                                                     NSString *url = _imagesURLStrings[0];
                                                     //处理网络图片大小
                                                     NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                                                     UIImage *image = [UIImage imageWithData:data];
                                                     NSLog(@"w = %f,h = %f", image.size.width, image.size.height);
                                                     NSLog(@"宽高比---%f", image.size.height / image.size.width);
                                                       HW = 0.5;//image.size.height / image.size.width;
                                                     _activityDetailTabview.tableHeaderView = self.headView;

                                                     _cycleScrollView2.imageURLStringsGroup = _imagesURLStrings;
                                                     [_activityDetailTabview reloadData];

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
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            return 40;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 40;
            break;
        case 3:
            return 40;
            break;
        case 4:
        {
            FEActivityDetailModel *model = _dataArray[0];
            CGFloat H=[model.activityContent heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:MainW-20];
            return H+10+10;
        }
            

            break;
        case 5:
            return 40;
            break;
        case 6:
            return 40;
            break;
        case 7:
            return 60;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        switch (indexPath.row)
        {
            case 0:
                titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, MainW - 20, 20)];
                titleLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:titleLab];
                break;
            case 1:
                startLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, MainW - 20, 20)];
                startLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:startLab];

                //
                endLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, MainW - 20, 20)];
                endLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:endLab];

                parcipateTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, MainW - 20, 20)];
                parcipateTimeLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:parcipateTimeLab];

                break;
            case 2:
                addressLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, MainW - 20, 20)];
                addressLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:addressLab];
                break;
            case 3:
                personLimitLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, MainW - 20, 20)];
                personLimitLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:personLimitLab];
                break;
            case 4:
                contLab = [[UILabel alloc]init];
                
                contLab.font = [UIFont systemFontOfSize:15];
                contLab.numberOfLines=0;

                [cell addSubview:contLab];
                break;
            case 5:
                wayLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, MainW - 20, 20)];
                wayLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:wayLab];
                break;
            case 6:
                //  发起人
                bottomperson = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (MainW - 20) / 2, 20)];
                bottomperson.font = [UIFont systemFontOfSize:15];
                bottomperson.textAlignment = NSTextAlignmentCenter;

                [cell addSubview:bottomperson];

                parcipateNumLab = [[UILabel alloc] initWithFrame:CGRectMake(10 + (MainW - 20) / 2 + 10, 10, (MainW - 20) / 2, 20)];
                parcipateNumLab.textAlignment = NSTextAlignmentCenter;
                parcipateNumLab.font = [UIFont systemFontOfSize:15];
                [cell addSubview:parcipateNumLab];

                break;
            case 7:
                exchangeBtn = [MYUI creatButtonFrame:CGRectMake(10, 10, MainW - 20, 40) backgroundColor:Green_Color setTitle:@"马上参加" setTitleColor:[UIColor whiteColor]];
                [exchangeBtn addTarget:self action:@selector(goDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                exchangeBtn.layer.masksToBounds = YES;
                exchangeBtn.layer.cornerRadius = 5;
                [cell addSubview:exchangeBtn];
                break;
            default:
                break;
        }
    }
    FEActivityDetailModel *model = _dataArray[0];
    titleLab.text = model.activityTitle;
    startLab.text = [NSString stringWithFormat:@"起始时间:%@", model.activityStartTimeStr];
    endLab.text = [NSString stringWithFormat:@"结束时间:%@", model.activityEndTimeStr];
    parcipateTimeLab.text = [NSString stringWithFormat:@"报名截止时间:%@", model.activityEndDateStr];
    ;
    personLimitLab.text = [NSString stringWithFormat:@"人数限制：%@", model.activityNnmber];
    addressLab.text = [NSString stringWithFormat:@"地址:%@", model.activityPlace];
    contLab.text = model.activityContent;
    
    //
    CGFloat H=[model.activityContent heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:MainW-20];
    contLab.frame=CGRectMake(10, 10, MainW - 20, H);
    wayLab.text = [NSString stringWithFormat:@"参与方式:%@", model.activityRemark];
    bottomperson.text = [NSString stringWithFormat:@"发起人%@", model.nickName];
    parcipateNumLab.text = [NSString stringWithFormat:@"参与人数:1"];
    bottomperson.textColor = [UIColor orangeColor];
    parcipateNumLab.textColor = [UIColor orangeColor];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
//参加活动的方法

- (void)goDetailClick:(UIButton *)btn
{
    
    
  
   // [FENavTool showAlertViewByAlertMsg:@"您已 参加过该活动" andType:@"提示"];
    NSString *str = @"020appd/activityCommunity/attenedActity";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.activityId forKey:@"activityId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                       NSLog(@"参加活动Dic--%@", dic);
                                                       [FENavTool showAlertViewByAlertMsg:@"成功参加活动" andType:@"提示"];
                                                    
                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                        
                                                    }];

}
@end
