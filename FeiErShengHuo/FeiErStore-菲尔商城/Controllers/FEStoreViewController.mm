//
//  FEStoreViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//
#define PYMargin 20 // 默认边距
#import "FEStoreViewController.h"
#import "SDCycleScrollView.h"
#import "SGAdvertScrollView.h"
#import "SGHelperTool.h"
#import "FEFourbtnView.h"
#import "FEGoodsCell.h"
#import "FELimitView.h"
#import "FEStoreHotSaleCell.h"
#import "StoreDetialViewController.h"
#import "FETodayPriceTabViewCell.h"
#import "FEHeaderFooterView.h"
#import "FEGroupBuyViewController.h"
#import "FETodayPriceCollectionViewCell.h"
#import "FESpecailGoodModel.h"
#import "FEgrainAndOilViewController.h"
#import "FEFishViewController.h"
#import "FESmartListViewController.h"
#import "FELimitView.h"


//BMKMapViewDelegate   BMKLocationServiceDelegate   BMKGeoCodeSearchDelegate

@interface FEStoreViewController ()<UITableViewDelegate,UITableViewDataSource,FEFourbtnViewdelegate,SGAdvertScrollViewDelegate,SDCycleScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    UIView * view1;
    FELimitView *_LimitViewVC;
    UIButton *leftBtn;
    CGFloat HW;
    CGFloat HW2;
    UIImageView *_imageView;
}
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView2;
@property (nonatomic, strong)NSArray *imagesURLStrings;  //让视图自动切换
@property(nonatomic,strong)NSMutableArray *dataArry;  // 限时抢购
@property(nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic, strong) BMKLocationService *locService;
@property(nonatomic,strong)BMKGeoCodeSearch *geocodesearch; //地理编码主类，用来查询、返回结果信息]
@property (nonatomic, strong) NSMutableArray *slideUrlArry;
@property (nonatomic, assign) CGFloat  longitude;  // 经度
@property (nonatomic, assign) CGFloat  latitude; // 纬度
// 用于记录 CollectionView 内容的偏移量。
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionaryOfExplores;
@property(nonatomic,strong) NSMutableArray *todayGoodArray;

@end
@implementation FEStoreViewController
-(NSArray *)imagesURLStrings
{
    if (!_imagesURLStrings) {
        _imagesURLStrings=[NSArray array];
    }
    
    return _imagesURLStrings;
}

- (NSMutableArray *)slideUrlArry
{
    if (!_slideUrlArry)
    {
        _slideUrlArry = [[NSMutableArray alloc] init];
    }
    return _slideUrlArry;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    [ZSLNetworkConnect canConnectNetworkWithVC:self completion:^(BOOL ok) {
        if (ok) {
            NSLog(@"ok");
            
            [RYLoadingView hideNoNetView:self.view];
            //存在网络 的情况下 判断是否有内容 没内容再请请求
            if (self.dataArry.count <= 0)
            {
                NSLog(@"请求首页数据");
                [self doRRequest];
            }
        }else {
            NSLog(@"fail");
            
             [RYLoadingView showNoNetView:self action:@selector(reTryConnect)];
        }
    }];
    
}


- (void)reTryConnect
{
    
    
    [ZSLNetworkConnect canConnectNetworkWithVC:self completion:^(BOOL ok) {
        if (ok) {
            NSLog(@"ok");
            
            [RYLoadingView hideNoNetView:self.view];
            //存在网络 的情况下 判断是否有内容 没内容再请请求
            if (self.dataArry.count <= 0)
            {
                NSLog(@"请求首页数据");
                [self doRRequest];
            }
            
        }else {
            NSLog(@"fail");
            
            [RYLoadingView showNoNetView:self action:@selector(reTryConnect)];
        }
    }];
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    [self stopLocation];
    
    [RYLoadingView hideNoNetView:self.view];
    
}
-(void)startLocation
{
    [_locService startUserLocationService];
}
-(void)stopLocation
{
    [_locService stopUserLocationService];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"当前位置信息：didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.longitude = userLocation.location.coordinate.longitude;
    self.latitude = userLocation.location.coordinate.latitude;
    //地理反编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag){
        NSLog(@"反geo检索发送成功");
        [_locService stopUserLocationService];
    }else{
        NSLog(@"反geo检索发送失败");
    }
}
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败!");
}
#pragma mark -------------地理反编码的delegate---------------
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //添加默认的定位的地址
    BMKPoiInfo *curinfo = [[BMKPoiInfo alloc] init];
    curinfo.pt = result.location;
    if (result.address && result.address.length > 0) {
        curinfo.name = result.address;
    }
    if (result.addressDetail) {
        curinfo.address = [NSString stringWithFormat:@"%@%@%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
        //self.addressTF.text=curinfo.address;
        [leftBtn setTitle:result.addressDetail.city forState:UIControlStateNormal];
    }
}
-(void)locationClick
{
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    [self startLocation];
}


-(void)initView
{
    
    
    [self setnavtype];
    //地图相关服务初始化
    
    self.locService = [[BMKLocationService alloc]init];
    self.geocodesearch = [[BMKGeoCodeSearch alloc] init];
    [self locationClick];
    
    
    _todayGoodArray=[[NSMutableArray alloc]init];
    self.contentOffsetDictionaryOfExplores =@{}.mutableCopy;
    self.titleArray=[NSMutableArray arrayWithObjects:@"", nil];
    self.dataArry=[NSMutableArray array];
    
    _storetableView=[UITableView groupTableView];
    _storetableView.frame=CGRectMake(0, 0, MainW, MainH-64-49);
    _storetableView.delegate=self;
    _storetableView.dataSource=self;
    
    [self.view addSubview:self.storetableView];
}
-(void)doRRequest
{
    NSString *str =@"020appd/shop/show";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:nil withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"商城的 dic----%@",dic);
    
       //[BLJSON propertyCodeWithDictionary:dic[@"categoryList"][0]];
        //图片
        NSMutableArray *imageArray=dic[@"shoppingPictureList"];
        NSMutableArray *imageurlArray=[NSMutableArray array];
         NSMutableArray *headUrlArray = [NSMutableArray array];
        for (NSMutableDictionary *imagedic in imageArray ) {
            NSString *url=imagedic[@"thumb"];
            NSString *slidUrl = imagedic[@"slideUrl"];
            [imageurlArray addObject:url];
             [headUrlArray addObject:slidUrl];
            self.imagesURLStrings=[imageurlArray copy];
        }
        self.slideUrlArry = [headUrlArray copy];
        
        
        NSString *url=self.imagesURLStrings[0];
        //处理网络图片大小
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"w = %f,h = %f" ,image.size.width,image.size.height);
        NSLog(@"宽高比---%f",image.size.height/image.size.width);
        HW=image.size.height/image.size.width;
        //设置表头
        _storetableView.tableHeaderView=[self tableheadview];
        
        _cycleScrollView2.imageURLStringsGroup = self.imagesURLStrings;
        
        
        NSArray *array=[FESpecailGoodModel mj_objectArrayWithKeyValuesArray:dic[@"specialGoods"]];
        self.todayGoodArray=[NSMutableArray arrayWithArray:array];
        
        
        [self.dataArry addObject:self.todayGoodArray];
        NSArray *hotdataArray=dic[@"categoryList"];
        //数据源
        for (NSDictionary *detailDic in  hotdataArray) {
            NSString *headStr=detailDic[@"cThumb"];
            [self.titleArray addObject:headStr];
            
            NSArray *array=[FEGoodModel mj_objectArrayWithKeyValuesArray:detailDic[@"xGoodsList"]];//detailDic[@"xGoodsList"];
            [self.dataArry addObject:array];
        }
        
        
        
        
        [self.storetableView reloadData];
        //图片
    } withfialedBlock:^(NSString *msg) {
    }];
}
-(UIView *)tableheadview
{
    _tableheadview=[[UIView alloc]init];
    _tableheadview.backgroundColor=RGB(236, 240, 246+30+5);
    
#pragma -------------------轮播图------------------------------
    _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MainW, MainW*HW) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //autoScrollTimeInterval
    _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _cycleScrollView2.autoScrollTimeInterval=5;
    [_tableheadview addSubview:self.cycleScrollView2];
#pragma ------------------四个按钮------------------------------
    //四个按钮
    FEFourbtnView *fourBtnView=[[FEFourbtnView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleScrollView2.frame)+1, MainW, 363/3-10-5)];
    fourBtnView.delegete=self;
    
    NSArray *fourbtnnameArray=@[@"icon_group_purchase",@"icon_grain",@"icon_fresh",@"icon_intelligent_product"];
    fourBtnView.fourbtnimageArray=fourbtnnameArray;
    fourBtnView.fourbtnnameArray=@[@"邻里团购",@"粮油干货",@"生鲜果蔬",@"生活易购"];
    [_tableheadview addSubview:fourBtnView];
    _tableheadview.frame=CGRectMake(0, 0, MainW,_cycleScrollView2.py_height+fourBtnView.py_height+1);
    
    //今日特价
    _LimitViewVC=[[FELimitView alloc]init];
    _LimitViewVC.frame=CGRectMake(0, CGRectGetMaxY(fourBtnView.frame), MainW, 30);
    
    [_tableheadview addSubview:_LimitViewVC];
    
    return _tableheadview;
    
}


/// 代理方法   点击大喇叭跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index
{

    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    
    WeakSelf;
    
    
    [FELoginHelper loginMoel:info andVC:self andLoginedBlock:^{
        
        [weakSelf crollView:cycleScrollView goslideBlock:^{
            
            NSString *str = weakSelf.slideUrlArry[index];
                                FEBreakRulesViewController *breakVC2 =
                                [[FEBreakRulesViewController alloc] init];
                                breakVC2.title = @"";
                                breakVC2.urlStr =
                                str; //@"http://admin.feierlife.com:8080/Home/ViolationIndex";
                                [weakSelf.navigationController pushViewController:breakVC2
                                                                         animated:YES];
 
            
        }];
        
        
    }];
    
}

- (void)crollView:(SDCycleScrollView *)cycleScrollView
     goslideBlock:(void (^)())slideBlock
  
{
    if (cycleScrollView == _cycleScrollView2)
    {
        slideBlock ? slideBlock() : nil;
    }
    
}

//点击四个按钮跳转
#pragma -------FEFourbtnView delegete----------------
-(void)choseCollectionBtnView:(FEFourbtnView *)FEFourbtnView didSelectedItemAtIndex:(NSInteger)index;
{
    
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    
    WeakSelf;
    
    
    if (index==0) {
        
        [FELoginHelper loginMoel:info andVC:self andLoginedBlock:^{
            FEGroupBuyViewController *vc=[[FEGroupBuyViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
    }
    if (index==1) {
        
        FEgrainAndOilViewController *vc=[[FEgrainAndOilViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if (index==2) {
        FEFishViewController *vc=[[FEFishViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if (index==3) {
        
        FESmartListViewController *VC=[[FESmartListViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}

#pragma mark - 自定义分组头部

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section==0) {
        
        UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 0.01)];
        secView.backgroundColor =[UIColor clearColor];
        return secView;
        
    }else
        
    {
        
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainW, MainW *HW2)];
        
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_titleArray[section]]];
        
        return _imageView;
        
    }
    
    return nil;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(0,5, MainW, 40)];
        view1.backgroundColor = [UIColor whiteColor];
        UILabel *limitLab=[MYUI createLableFrame:CGRectMake(10, 10, 200/3, 20) backgroundColor:[UIColor clearColor] text:@"热卖商品" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
        [view1 addSubview:limitLab];
        
        return view1;
    }
    else
    {
        UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 0.01)];
        secView.backgroundColor =[UIColor clearColor];
        return secView;
    }
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
        
    }
    else
    {
        //return 80;
        
        NSString *url2=_titleArray[1];
        //处理网络图片大小
        NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:url2]];
        UIImage *image2 = [UIImage imageWithData:data2];
        NSLog(@"w = %f,h = %f" ,image2.size.width,image2.size.height);
        NSLog(@"ttttttttt宽高比---%f",image2.size.height/image2.size.width);
        HW2=image2.size.height/image2.size.width;
        return HW2 *MainW;
    }
    
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 40;
        
    }else{
        return 0.01;
        
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
        
    }
    else
    {
        NSArray *array=_dataArry[section];
        return array.count;
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        if (_todayGoodArray.count==0) {
            return 0.01;
            
        }
        return 250;
    }
    
    else{
        CGFloat height=[FEStoreHotSaleCell countFirstHotSaleHeight];
        return height;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        static NSString *cellID=@"cellID1";
        
        FETodayPriceTabViewCell *cell1 = (FETodayPriceTabViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell1==nil) {
            cell1=[[FETodayPriceTabViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell1.contentView.backgroundColor=[UIColor whiteColor];
            [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell1;
    }
    else{
        static NSString *cellID=@"cellID2";
        FEStoreHotSaleCell *cell2=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell2==nil) {
            cell2=[[FEStoreHotSaleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell2.contentView.backgroundColor=[UIColor whiteColor];
            [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        WeakSelf;
        FEGoodModel *curModelHot=_dataArry[indexPath.section][indexPath.row];
        cell2.block = ^(UIButton *btn) {
            StrongSelf;
            [strongSelf gogoClick:curModelHot];
            
        };
        
        
        [cell2 setUpCellWithModel:curModelHot];
        
        return cell2;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FETodayPriceTabViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 为 TableViewCell 中的 CollectionView 设置不同的 collectionViewCellType 用以区别，此处一共三中样式。
    if (indexPath.section == 0) {
        
        NSInteger index = cell.collectionView.indexPath.row;
        CGFloat horizontalOffset = [self.contentOffsetDictionaryOfExplores[[@(index) stringValue]] floatValue];
        // 设置 CollectionView 的 ContentOffset，在'- (void)scrollViewDidScroll:(UIScrollView *)scrollView;' 中存储的。
        [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
        //
        // 设置 CollectionView 的 DataSource 与 Delegate 及所处的 indexPath。
        [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //首先判断是否登录
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    
    NSLog(@"是否 登录 ---info--%@",info.isLogin);
    NSLog(@"小区ID ---info--%@",info.villageId);
    if ([info.isLogin isEqualToString:@"0"]||[info.isLogin isEqual:nil]||[info.isLogin isKindOfClass:[NSNull class]]||[info.isLogin isEqual:[NSNull null]]||info.isLogin.length==0) {
        FELoginViewController *vc=[[FELoginViewController alloc]init];
        //vc.delegete=self;
        FEBaseNavControllerViewController *logNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:vc];
        
        [self presentViewController:logNav animated:YES completion:nil];
        return;
    }
    //判断小区
    
    if ([info.villageId intValue]<=0) {
        
        //跳转健全信息页面
        // 没有的情况  去健全小区和上传信息
        FEAddinfoViewController *addinfoVC=[[FEAddinfoViewController alloc]init];
        FEBaseNavControllerViewController *addNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:addinfoVC];
        
        [self presentViewController:addNav animated:YES completion:nil];
        
        return;
    }
    
    
    
    FEGoodModel *curModelHot=_dataArry[indexPath.section][indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreDetialViewController *detailVC=[[StoreDetialViewController alloc]init];
    detailVC.goodsId=curModelHot.goodsId;
    detailVC.curModel=curModelHot;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

-(void)setnavtype{
    //左侧
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    leftBtn = [[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusCenterImageLeft];
    [leftBtn addTarget:self action:@selector(choseAddress) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"icon_address_label"] forState:0];
    
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 44)];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,settingItem];
    //输入框
    UIView *titleView = [[UIView alloc] init];
    titleView.py_x = PYMargin * 2;
    titleView.py_y = 7;
    titleView.py_width = self.view.py_width  - titleView.py_x * 4;
    titleView.py_height = 30;
    //中间
    UIButton *searchbtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusCenterImageLeft];
    [searchbtn setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [searchbtn addTarget:self action:@selector(gosearch) forControlEvents:UIControlEventTouchUpInside];
    
    //RGBA(226, 64, 27, 0.5)
    searchbtn.frame=titleView.bounds;
    [searchbtn setImage:[UIImage imageNamed:@"icon_magnifier"] forState:UIControlStateNormal];
    [searchbtn setTitle:@"输入您所关注的商品" forState:0];
    searchbtn.titleLabel.font=[UIFont systemFontOfSize:14];
    searchbtn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    //searchbtn.py_width -= PYMargin * 1.5;
    [titleView addSubview:searchbtn];
    self.navigationItem.titleView = titleView;
    //[FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(rightitemClick) andType:item_threeline];
}
-(void)gosearch
{
    FESearchViewController *vc=[[FESearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)choseAddress
{
}
-(void)rightitemClick
{
}
#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(FETodayPriceCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _todayGoodArray.count;
    
}

- (UICollectionViewCell *)collectionView:(FETodayPriceCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:ExploreCollectionViewCellID forIndexPath:indexPath];
    if ([cell isKindOfClass:[FETodayPriceCollectionViewCell class]]) {
        FETodayPriceCollectionViewCell *cellT = (FETodayPriceCollectionViewCell *) cell;
        cellT.model=_todayGoodArray[indexPath.row];
        
        // TODO: 获取到相应的 Model 后进行赋值操作
        //            if (self.dataSourceExplores.count > 0) {
        //                cellExplore.exploreModel = self.dataSourceExplores[indexPath.row];
        //            }
        
    }
    
    return cell;
}
- (void)collectionView:(FETodayPriceCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    
    NSLog(@"是否 登录 ---info--%@",info.isLogin);
    if ([info.isLogin isEqualToString:@"0"]||[info.isLogin isEqual:nil]||[info.isLogin isKindOfClass:[NSNull class]]||[info.isLogin isEqual:[NSNull null]]||info.isLogin.length==0) {
        FELoginViewController *vc=[[FELoginViewController alloc]init];
        //vc.delegete=self;
        FEBaseNavControllerViewController *logNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:vc];
        
        [self presentViewController:logNav animated:YES completion:nil];
        return;
    }
    
    
    
    //判断小区
    if ([info.villageId intValue]<=0) {
        
        //跳转健全信息页面
        // 没有的情况  去健全小区和上传信息
        FEAddinfoViewController *addinfoVC=[[FEAddinfoViewController alloc]init];
        FEBaseNavControllerViewController *addNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:addinfoVC];
        
        [self presentViewController:addNav animated:YES completion:nil];
        
        return;
    }
    
    
    //
    NSInteger position = indexPath.row;
    NSLog(@"Selected CellTypeExplores Item---%ld",position);
    FESpecailGoodModel *model=self.todayGoodArray[position];
    
    StoreDetialViewController *detailVC=[[StoreDetialViewController alloc]init];
    detailVC.goodsId=model.goodsId;
    FEGoodModel *model22=[[FEGoodModel alloc]init];
    
    model22.productprice=[model.orginPrice integerValue];
    model22.marketprice=[model.nowPrice integerValue];
    model22.goodsId=model.goodsId;
    model22.thumb=model.specialThumb;
    model22.title=model.goodsName;
    model22.title=model.goodsName;
    detailVC.curModel=model22;
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (CGSize)collectionView:(FETodayPriceCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(132, 180);
}
#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    FETodayPriceCollectionView *collectionView = (FETodayPriceCollectionView *) scrollView;
    NSInteger index = collectionView.indexPath.row;
    // 根据 collectionViewCellType 存储对应的偏移量
    self.contentOffsetDictionaryOfExplores[[@(index) stringValue]] = @(horizontalOffset);
    
}




#pragma -------添加购物车------------------
-(void)gogoClick:(FEGoodModel *)model
{
    NSString *diQu=model.origin;
    
    NSString *Msg=[NSString stringWithFormat:@"该商品只支持%@地区销售，确认添加购物车？",diQu];
    WeakSelf;
    
    [FENavTool showAlertRightAndCancelMsg:Msg andType:@"提示" andRightClick:^{
        StrongSelf;
        
        [strongSelf addCarRequest:model];
        
        
    } andCancelClick:^{
        
    }];
    
}


-(void)addCarRequest:(FEGoodModel *)model
{
    NSString *str=@"020appd/cart/addGoods";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:model.goodsId forKey:@"goodsId"];
    NSNumber *nunber=[NSNumber numberWithInteger:model.productprice];
    [dic setObject:nunber forKey:@"productPrice"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"total"];
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        
        [FENavTool showAlertViewByAlertMsg:@"添加成功" andType:@"提示" ];
#pragma ----通知本地购物车刷新--------
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_TOCar object:model];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
}





@end
