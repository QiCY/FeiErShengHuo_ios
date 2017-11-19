//
//  FEDeviceStoreViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEDeviceStoreViewController.h"
#import "FEDeviceStoreView.h"

#import "FEGoodModel.h"
#import "FELeftTableViewCell.h"
#import "FERightTableViewCell.h"
#import "FEStoreHotSaleCell.h"
#import "FETableViewHeaderView.h"
static NSString *const FELeftCellID = @"FELeftCellID";
static NSString *const FERightCellID = @"FERightCellID";

@interface FEDeviceStoreViewController () < UITableViewDelegate, UITableViewDataSource >
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
    UIImageView *_imageView;
}

@property (nonatomic, strong) NSMutableArray *LeftDataArrM;
@property (nonatomic, strong) NSMutableArray *RightDataArrM;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) FEDeviceStoreView *deviceStoreView;

@end

@implementation FEDeviceStoreViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"设备商城";
//}
//
//- (void)initView
//{
//    [self.view addSubview:self.headerView];
//    [self.view addSubview:self.deviceStoreView];
//
//    self.headerView.frame = CGRectMake(0, 0, MainW, 180);
//    self.deviceStoreView.frame = CGRectMake(0, 180, MainW, MainH-180-64);
//}
//
//- (UIView *)headerView
//{
//    if (!_headerView) {
//        _headerView = [[UIView alloc] init];
//    }
//    return _headerView;
//}
//
//- (FEDeviceStoreView *)deviceStoreView
//{
//    if (!_deviceStoreView) {
//        _deviceStoreView = [[FEDeviceStoreView alloc] init];
//    }
//    return _deviceStoreView;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 懒加载数据源数组 -
- (NSMutableArray *)LeftDataArrM
{
    if (!_LeftDataArrM)
    {
        _LeftDataArrM = [NSMutableArray array];
    }
    return _LeftDataArrM;
}

- (NSMutableArray *)RightDataArrM
{
    if (!_RightDataArrM)
    {
        _RightDataArrM = [NSMutableArray array];
    }
    return _RightDataArrM;
}
- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, MainW * 0.5, 100, MainH - 64 - MainW * 0.5)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[FELeftTableViewCell class] forCellReuseIdentifier:FELeftCellID];
    }

    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(100, MainW * 0.5, MainW - 100, MainH - 64 - MainW * 0.5)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 100;
        [_rightTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _rightTableView.tableFooterView = [UIView new];
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_rightTableView registerClass:[FEStoreHotSaleCell class] forCellReuseIdentifier:FERightCellID];
    }

    return _rightTableView;
}

- (void)initView
{
    self.title = @"设备商城";

    _selectIndex = 0;
    _isScrollDown = YES;
    //创建表格
    [self createTable];
}

- (void)doRequest
{
    NSString *str = @"020appd/supply/show";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInt:0] forKey:@"supplyFlag"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"设备的Dic--%@", dic);

                                                     [_imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"thumb"]]];

                                                     NSMutableArray *categoryListArray = (NSMutableArray *)dic[@"categoryList"];
                                                     for (NSDictionary *dict in categoryListArray)
                                                     {
                                                         NSString *titte = dict[@"name"];
                                                         [self.LeftDataArrM addObject:titte];
                                                         NSArray *array = [FEGoodModel mj_objectArrayWithKeyValuesArray:dict[@"xGoodsList"]];
                                                         [self.RightDataArrM addObject:array];
                                                     }

                                                     if (categoryListArray.count <= 0)
                                                     {
                                                         [RYLoadingView showNoResultView:self.view];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView hideNoResultView:self.view];
                                                         [self.leftTableView reloadData];
                                                         [self.rightTableView reloadData];


                                                         [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                                                     }

                                                    
                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)createTable
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainW, MainW * 0.5)];
    [self.view addSubview:_imageView];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
}

#pragma mark - UITableViewDataSourse -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (_leftTableView == tableView) ? 1 : self.LeftDataArrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_leftTableView == tableView) ? self.LeftDataArrM.count : [self.RightDataArrM[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        FELeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FELeftCellID forIndexPath:indexPath];
        NSString *title = self.LeftDataArrM[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.name.text = title;

        return cell;
    }
    else
    {
        FEStoreHotSaleCell *cell = [tableView dequeueReusableCellWithIdentifier:FERightCellID forIndexPath:indexPath];
        FEGoodModel *model = self.RightDataArrM[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setUpCellWithModel:model];
        WeakSelf;

        cell.block = ^(UIButton *btn) {
          StrongSelf;
          [strongSelf gogoClick:model];

        };

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (_rightTableView == tableView) ? 30 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FETableViewHeaderView *view = [[FETableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, MainH, 30)];
    NSString *title = self.LeftDataArrM[section];
    view.name.text = title;

    return (_rightTableView == tableView) ? view : nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && !_isScrollDown && _rightTableView.dragging)
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView) && _isScrollDown && _rightTableView.dragging)
    {
        [self selectRowAtIndexPath:section + 1];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    if (_leftTableView == tableView)
    {
        //左边
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

    if (_rightTableView == tableView)
    {
        FEGoodModel *curmodel = self.RightDataArrM[indexPath.section][indexPath.row];

        //首先判断是否登录
        FELoginInfo *info = [LoginUtil getInfoFromLocal];
        NSLog(@"小区ID------%@", info.villageId);
        NSLog(@"是否 登录 ---info--%@", info.isLogin);
        if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
        {
            FELoginViewController *vc = [[FELoginViewController alloc] init];
            //vc.delegete=self;
            FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

            [self presentViewController:logNav animated:YES completion:nil];
            return;
        }

        //判断小区
        if ([info.villageId intValue] <= 0)
        {
            //跳转健全信息页面
            // 没有的情况  去健全小区和上传信息
            FEAddinfoViewController *addinfoVC = [[FEAddinfoViewController alloc] init];
            FEBaseNavControllerViewController *addNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:addinfoVC];

            [self presentViewController:addNav animated:YES completion:nil];

            return;
        }

        StoreDetialViewController *detailVC = [[StoreDetialViewController alloc] init];
        detailVC.goodsId = curmodel.goodsId;
        detailVC.curModel = curmodel;

        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    UITableView *tableView = (UITableView *)scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

#pragma-- ---- - 添加购物车-- ----------------
- (void)gogoClick:(FEGoodModel *)model
{
    NSString *diQu = model.origin;

    NSString *Msg = [NSString stringWithFormat:@"该商品只支持%@地区销售，确认添加购物车？", diQu];
    WeakSelf;

    [FENavTool showAlertRightAndCancelMsg:Msg
                                  andType:@"提示"
                            andRightClick:^{
                              StrongSelf;

                              [strongSelf addCarRequest:model];

                            }
                           andCancelClick:^{

                           }];
}

- (void)addCarRequest:(FEGoodModel *)model
{
    NSString *str = @"020appd/cart/addGoods";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:model.goodsId forKey:@"goodsId"];
    NSNumber *nunber = [NSNumber numberWithInteger:model.productprice];
    [dic setObject:nunber forKey:@"productPrice"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"total"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {

                                                     [FENavTool showAlertViewByAlertMsg:@"添加成功" andType:@"提示"];
                                                     //#pragma ----通知本地购物车刷新--------
                                                     //
                                                     //        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_TOCar object:model];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

@end
