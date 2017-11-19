//
//  FEIntergraalRecodDetailViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntergraalRecodDetailViewController.h"
#import "FERecordIntergralModel.h"

@interface FEIntergraalRecodDetailViewController () < UITableViewDelegate, UITableViewDataSource >
{
    UILabel *_titleLab;
    UILabel *_intergralLab;
    UILabel *_nowIntergralLab;
    UILabel *_dingdannumLab;
    UIImageView *_view;
}
@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) FERecordIntergralModel *model;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FEIntergraalRecodDetailViewController

- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (void)initView
{
    [self doRRequest];

    self.tabView = [UITableView groupTableView];
    self.tabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    self.tabView.sectionFooterHeight = 0.01;
    self.tabView.sectionHeaderHeight = 0.01;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    _view = [[UIImageView alloc] init];
    _view.frame = CGRectMake(0, 0, MainW, 180);

    self.tabView.tableHeaderView = _view;
    [self.view addSubview:self.tabView];
}

- (void)doRRequest
{
    NSString *str = @"020appd/integral/jifenxiangqing";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:self.curmodel.userInfoIntegralId forKey:@"userInfoIntegralId"];

    [RYLoadingView showRequestLoadingView];
    
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                      NSLog(@"积分商品订单详情dic-- %@", dic);
                                                     self.model = [FERecordIntergralModel mj_objectWithKeyValues:dic[@"integralMall"]];
                                                     [_view sd_setImageWithURL:[NSURL URLWithString:self.model.integralGoodUrl]];
                                                     self.tabView.tableHeaderView = _view;

                                                     [self.tabView reloadData];

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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        return MainH - MainH / 2 - 80 - 16;
    }
    else
    {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 8)];
    view.backgroundColor = Colorgrayall239;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.section == 0)
        {
            _titleLab = [MYUI createLableFrame:CGRectMake(10, 10, MainW / 2, 20) backgroundColor:[UIColor clearColor] text:@"端午节礼盒" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            [cell addSubview:_titleLab];

            _intergralLab = [MYUI createLableFrame:CGRectMake(MainW / 2, 10, MainW / 2 - 10, 20) backgroundColor:[UIColor clearColor] text:@"端午节礼盒" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            _intergralLab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:_intergralLab];
        }
        if (indexPath.section == 1)
        {
            _nowIntergralLab = [MYUI createLableFrame:CGRectMake(MainW / 2, 10, MainW / 2 - 10, 20) backgroundColor:[UIColor clearColor] text:@"端午节礼盒" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            _nowIntergralLab.textAlignment = NSTextAlignmentRight;
            [cell addSubview:_nowIntergralLab];
        }
        if (indexPath.section == 2)
        {
            _dingdannumLab = [MYUI createLableFrame:CGRectMake(10, 10, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:@"端午节礼盒" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
            [cell addSubview:_dingdannumLab];

            UIButton *gobackBtn = [MYUI creatButtonFrame:CGRectMake(MainW / 2 - 50, 60, 100, 40) backgroundColor:[UIColor whiteColor] setTitle:@"回到首页" setTitleColor:Green_Color];
            [gobackBtn addTarget:self action:@selector(gobanckClick) forControlEvents:UIControlEventTouchUpInside];

            gobackBtn.layer.cornerRadius = 5;
            gobackBtn.layer.masksToBounds = YES;
            [gobackBtn setBackgroundColor:[UIColor clearColor]];
            gobackBtn.layer.borderWidth = 1;
            gobackBtn.layer.borderColor = Green_Color.CGColor;
            [cell addSubview:gobackBtn];
        }
    }

    _titleLab.text = self.model.integralGoodTitle;

    _nowIntergralLab.attributedText = [FENavTool String:[NSString stringWithFormat:@"实际支付：%@积分", self.model.integralCredit] RangeString:[NSString stringWithFormat:@"%@积分", self.model.integralCredit] RangeColor:[UIColor orangeColor]];
    _intergralLab.text = [NSString stringWithFormat:@"%@积分", self.model.integralCredit];
    _dingdannumLab.text = [NSString stringWithFormat:@"订单编号:%@", self.model.orderNum];

    return cell;
}

- (void)gobanckClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
