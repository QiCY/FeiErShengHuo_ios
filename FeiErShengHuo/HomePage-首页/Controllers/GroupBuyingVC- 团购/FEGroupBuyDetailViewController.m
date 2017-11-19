//
//  FEGroupBuyDetailViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupBuyDetailViewController.h"
#import "FEGroupDetailModel.h"
#import "FEGroupedDetailCell.h"
#import "FEPictureModel.h"
#import "FEGroupedAddressViewController.h"

@interface FEGroupBuyDetailViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    
    CGFloat HW;
    
}
@property(nonatomic,strong)UITableView *detailTab;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIView *tableheadview;
@property(nonatomic,strong)SDCycleScrollView * cycleScrollView2;
@property (nonatomic, strong)NSArray *imagesURLStrings;  //让视图自动切换
@property (nonatomic, strong)FEGroupDetailModel *model;

@end

@implementation FEGroupBuyDetailViewController
-(NSArray *)imagesURLStrings
{
    if (!_imagesURLStrings) {
         _imagesURLStrings=[[NSArray alloc]init];
    }
    return _imagesURLStrings;
    
}

-(void)initView
{
    self.dataArray=[[NSMutableArray alloc]init];
    self.title=@"团购详情";
    self.detailTab=[UITableView groupTableView];
    _detailTab.frame=CGRectMake(0, 0, MainW, MainH-64);
    _detailTab.delegate=self;
    _detailTab.dataSource=self;
    _detailTab.sectionHeaderHeight=0.01;
    _detailTab.sectionFooterHeight=15;
    _detailTab.tableHeaderView=self.tableheadview;
    [self.view addSubview:_detailTab];
}
#pragma -------------------轮播图------------------------------
-(UIView *)tableheadview
{
    if (!_tableheadview) {
        _tableheadview=[[UIView alloc]init];
        _tableheadview.frame=CGRectMake(0, 0, MainW,MainW*0.5);
        _tableheadview.backgroundColor=RGB(236, 240, 246);

        _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MainW, MainW*0.5) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView2.autoScrollTimeInterval=5;
        _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [_tableheadview addSubview:self.cycleScrollView2];
        
    }

    return _tableheadview;
}
-(void)doRequest
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.index forKey:@"tuanId"];
    NSString *str =@"020appd/nauriBin/detail";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"dic---团购详情%@",dic);
        
        
        _model=[FEGroupDetailModel mj_objectWithKeyValues:dic[@"xcommunityTuan"]];
        
        NSMutableArray *array2=[[NSMutableArray alloc]init];
        
        for (FEPictureModel *mode2 in _model.slideList ) {
            NSString *url=mode2.url;
            [array2 addObject:url];
            
        }
         self.imagesURLStrings =[array2 copy];
        
        _cycleScrollView2.imageURLStringsGroup=_imagesURLStrings;
        
        if (isArrayNoNilNoO(_imagesURLStrings)) {
            _model.thumb=_imagesURLStrings[0];
        }else{
            _model.thumb=@"";
            
        }
        
        
        //[_dataArray addObject:_model];
        
        
        [self.detailTab reloadData];
        
        
        
        
    } withfialedBlock:^(NSString *msg) {
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 15)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return [FEGroupedDetailCell countHeigthWith:_model];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"FEGroupedDetailCell";
    FEGroupedDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[FEGroupedDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WeakSelf;
        cell.block = ^(UIButton *btn) {
            StrongSelf;
            FEGroupedAddressViewController *addressViewVC=[[FEGroupedAddressViewController alloc]init];
            
            //[_dataArray replaceObjectAtIndex:0 withObject:_model];
            
            addressViewVC.model=self.model;
            [strongSelf.navigationController pushViewController:addressViewVC animated:YES];
        };
        
    }
    
    cell.oblock = ^(UIButton *btn) {
        
        FEGoodModel *model=[[FEGoodModel alloc]init];
        //
        model.goodsId=_model.tuanId;
        model.title=_model.title;
        //model.productprice=cumodel.productPrice;
        model.marketprice=_model.productPrice;
        model.Gtotal=[NSNumber numberWithInt:1];
        model.thumb=_model.thumb;
        
        FEbuyNowViewController *buyNowVC=[[FEbuyNowViewController alloc]init];
        buyNowVC.goodModel=model;
        buyNowVC.buyFromWhereType=[NSNumber numberWithInteger:0];
        [self.navigationController pushViewController:buyNowVC animated:YES];

        
    };

    
    [cell setUpCellWithModel:_model];
    return cell;
    
}




@end
