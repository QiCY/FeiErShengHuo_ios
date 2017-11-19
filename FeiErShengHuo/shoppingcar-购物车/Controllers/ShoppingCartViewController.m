//
//  ShoppingCartViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "FEBottomView.h"
#import "FECarGoodsModel.h"
#import "FEGoodCarCell.h"
#import "FEbuyAllNowViewController.h"
@interface ShoppingCartViewController () < UITableViewDelegate, UITableViewDataSource, BottomViewDelegate, ShoppingSelectedDelegate, FEbuyAllNowViewControllerdelegete >

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *carTabView;
@property (nonatomic, strong) FEBottomView *bottomView;
@end

@implementation ShoppingCartViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self doRequestHH];
}

- (void)initView
{
    _dataArray = [[NSMutableArray alloc] init];
    
    iscompileClick = NO;
    _carTabView = [UITableView tableView];
    _carTabView.frame = CGRectMake(0, 0, MainW, MainH - 64 - 49 - 44);
    _carTabView.delegate = self;
    _carTabView.dataSource = self;
    _carTabView.sectionHeaderHeight = 25;
    _carTabView.sectionFooterHeight = 0.01;
    [_carTabView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_carTabView];
    _bottomView = [[FEBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_carTabView.frame), MainW, 44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    [_bottomView.totalNumBtn addTarget:self action:@selector(buyNowClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buyNowClick
{
    if ([_bottomView.totalNumBtn.titleLabel.text isEqualToString:@"结算（）"])
    {
        [FENavTool showAlertViewByAlertMsg:@"请选择商品" andType:@"提示"];
        
        return;
    }
    
    NSLog(@"--总价格--%@", _bottomView.totalPriceLab.text);
    NSString *cur = _bottomView.totalPriceLab.text;
    NSArray *pricedarray2 = [cur componentsSeparatedByString:@"￥"];
    
    NSString *price = pricedarray2[1];
    CGFloat Iprice = [price floatValue];
    NSInteger IBAIprice = Iprice * 100.0;
    
    NSLog(@"---- price--- %@", price);
    
    FEbuyAllNowViewController *vc = [[FEbuyAllNowViewController alloc] init];
    vc.delegete = self;
    vc.IBAIprice = IBAIprice;
    
    vc.buyFromWhereType = [NSNumber numberWithInteger:1];
    
    NSMutableArray *chosedArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < _dataArray.count; i++)
    {
        FECarGoodsModel *model = self.dataArray[i];
        
        if ([model.isChose isEqualToString:@"1"])
        {
            FEGoodModel *model2 = [FEGoodModel alloc];
            model2.thumb = model.thumb;
            model2.title = model.title;
            model2.marketprice = [model.marketPrice integerValue];
            model2.Gtotal = model.total;
            model2.goodsId = model.goodSId;
            model2.descrip = model.descrip;
            [chosedArray addObject:model2];
        }
    }
    NSLog(@"已经选择的的数组 是 %@", chosedArray);
    vc.dataArray = chosedArray;
    vc.NdataArray=_dataArray;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)choseddelegete
{
    for (int i = 0; i < _dataArray.count; i++)
    {
        FECarGoodsModel *model = self.dataArray[i];
        if ([model.isChose isEqualToString:@"1"])
        {
            [_dataArray removeObjectAtIndex:i];
        }
    }
    [self postCenter];
    [_carTabView reloadData];
}

//选中所有商品
- (void)DidSelectedAllGoods
{
    for (int i = 0; i < _dataArray.count; i++)
    {
        FECarGoodsModel *model = _dataArray[i];
        model.isChose = @"1";
        [_dataArray replaceObjectAtIndex:i withObject:model];
    }
    [self postCenter];
    [_carTabView reloadData];
}
//取消选中所有商品
- (void)NoDidSelectedAllGoods
{
    for (int i = 0; i < _dataArray.count; i++)
    {
        FECarGoodsModel *model = _dataArray[i];
        model.isChose = @"0";
        [_dataArray replaceObjectAtIndex:i withObject:model];
    }
    [self postCenter];
    
    [_carTabView reloadData];
}

/**
 *  选中商品
 */
- (void)SelectedConfirmCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [_carTabView indexPathForCell:cell];
    FECarGoodsModel *curmodel = _dataArray[indexPath.row];
    curmodel.isChose = @"1";
    [_dataArray replaceObjectAtIndex:indexPath.row withObject:curmodel];
    
    [self postCenter];
    //刷新一个cell
    [_carTabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}
/**
 *  取消选中商品
 */
- (void)SelectedCancelCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [_carTabView indexPathForCell:cell];
    FECarGoodsModel *curmodel = _dataArray[indexPath.row];
    curmodel.isChose = @"0";
    [_dataArray replaceObjectAtIndex:indexPath.row withObject:curmodel];
    [self postCenter];
    //刷新一个cell
    [_carTabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

/**
 *  刷新结账栏金额
 */
- (void)postCenter
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BottomRefresh" object:nil userInfo:@{ @"Data" : _dataArray }];
}

/**
 *  修改商品数量
 */
- (void)ChangeGoodsNumberCell:(UITableViewCell *)cell Number:(NSInteger)num
{
    NSIndexPath *indexPath = [_carTabView indexPathForCell:cell];
    FECarGoodsModel *curmodel = _dataArray[indexPath.row];
    curmodel.total = [NSNumber numberWithInteger:num];
    [_dataArray replaceObjectAtIndex:indexPath.row withObject:curmodel];
    [self postCenter];
    
    //一个cell刷新
    NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [_carTabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths, nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)doRequestHH
{
    NSString *str = @"020appd/cart/show";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                       NSArray *array = [FECarGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityCarts"]];
                                                       
                                                       self.dataArray = [NSMutableArray arrayWithArray:array];
                                                       if (array.count > 0) {
                                                           [RYLoadingView hideNoResultView:self.carTabView];
                                                           
                                                       }else{
                                                           
                                                           [RYLoadingView showNoResultView:self.carTabView];
                                                       }
                                                       
                                                       [_carTabView reloadData];
                                                       
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
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 25)];
    view.backgroundColor = Colorgrayall239;
    
    UIButton *compileBtn = [MYUI creatButtonFrame:CGRectZero backgroundColor:[UIColor clearColor] setTitle:@"编辑" setTitleColor:[UIColor blackColor]];
    compileBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:compileBtn];
    [compileBtn addTarget:self action:@selector(compileClick) forControlEvents:UIControlEventTouchUpInside];
    [compileBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view.right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(25);
        
    }];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEGoodCarCellID = @"FEGoodCarCell";
    FEGoodCarCell *cell = [tableView dequeueReusableCellWithIdentifier:FEGoodCarCellID];
    if (cell == nil)
    {
        cell = [[FEGoodCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEGoodCarCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.SelectedDelegate = self;
    }
    FECarGoodsModel *model = _dataArray[indexPath.row];
    [cell setupCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FECarGoodsModel *model = _dataArray[indexPath.row];
    
    FEGoodModel *curModel = [[FEGoodModel alloc] init];
    curModel.goodsId = model.goodSId;
    curModel.title = model.title;
    curModel.marketprice = [model.marketPrice integerValue];
    
    curModel.thumb = model.thumb;
    curModel.Gtotal = [NSNumber numberWithInt:1];
    StoreDetialViewController *detailVC = [[StoreDetialViewController alloc] init];
    detailVC.curModel = curModel;
    
    detailVC.goodsId = curModel.goodsId;
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
        [self doDeleteRequest:indexPath];
    }
}

// 编辑
- (void)compileClick
{

    if (iscompileClick)
    {
        for (int i = 0; i < _dataArray.count; i++)
        {
            FECarGoodsModel *model = _dataArray[i];
            model.ishidden = @"1";
            [_dataArray replaceObjectAtIndex:i withObject:model];
        }
        [_carTabView reloadData];
    }
    else
    {
        for (int i = 0; i < _dataArray.count; i++)
        {
            FECarGoodsModel *model = _dataArray[i];
            model.ishidden = @"0";
            [_dataArray replaceObjectAtIndex:i withObject:model];
        }
        [_carTabView reloadData];
    }
     iscompileClick = !iscompileClick;
}

- (void)doDeleteRequest:(NSIndexPath *)index
{
    NSString *str = @"020appd/cart/delete";
    FECarGoodsModel *model = _dataArray[index.row];
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:model.total forKey:@"total"];
    [dic setObject:model.goodSId forKey:@"goodsId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                       
                                                       NSMutableArray *array = [NSMutableArray arrayWithArray:_dataArray];
                                                       [array removeObjectAtIndex:index.row];
                                                       [_dataArray removeAllObjects];
                                                       _dataArray = [NSMutableArray arrayWithArray:array];
                                                       
                                                       if (array.count > 0) {
                                                           [RYLoadingView hideNoResultView:self.carTabView];
                                                           
                                                       }else{
                                                           
                                                           [RYLoadingView showNoResultView:self.carTabView];
                                                       }
                                                       
                                                       [_carTabView reloadData];
                                                       [FENavTool showAlertViewByAlertMsg:@"删除成功" andType:@"提示"];
                                                       
                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                        
                                                    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [RYLoadingView hideNoResultView:self.carTabView];
    
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
