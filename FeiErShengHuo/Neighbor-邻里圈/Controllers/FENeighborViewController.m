//
//  FENeighborViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FENeighborViewController.h"
#import "FEDynamicModel.h"
#import "FEDynamicStateCell.h"
#import "FEFourbtnView.h"
#import "RYImagePreViewController.h"
#import "SDCycleScrollView.h"
#import "SGHelperTool.h"

#import "FENeighberDetailController.h"
#import "FEPublishController.h"

#import "FEBreakRulesViewController.h"
#import "FEFourbtnCollectionViewCell.h"
#import "FEInterstingViewController.h"

@interface FENeighborViewController () < SDCycleScrollViewDelegate, PullTableViewDelegate, UITableViewDelegate, UITableViewDataSource, HPGrowingTextViewDelegate, DynamicCellDelegate, FEFourbtnViewdelegate, commentCoutdelegete >
{
    NSInteger curPage;
    NSInteger totNum;
    NSInteger pageSize;
    BOOL isLoadMore;
    NSInteger currentSelectRow;
    NSIndexPath *curActionIndexPath;
    NSNumber *displayType;
    BOOL isAll;
    CGFloat HW;
    FEFourbtnView *fourBtnView;
    
}
@property (nonatomic, strong) UITableView *neighberTabView;
@property (nonatomic, strong) UILabel *typeLbl;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView3;
@property (nonatomic, strong) NSArray *imagesURLStrings; //让视图自动切换
@property (nonatomic, strong) FEDynamicModel *curModel;
@property (nonatomic, strong) NSMutableArray *slideUrlArry;
@end

@implementation FENeighborViewController

- (NSArray *)imagesURLStrings
{
    if (!_imagesURLStrings) {
        _imagesURLStrings = [NSArray array];
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //监听发布动态的通知
   
    displayType = [NSNumber numberWithInt:1];
    isAll = YES;
    [self doRequest:displayType];
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionView *cllectionView = (UICollectionView *)fourBtnView.collections;
    FEFourbtnCollectionViewCell *cell = (FEFourbtnCollectionViewCell *)[cllectionView cellForItemAtIndexPath:indexpath];
    [cell.imageView setImage:[UIImage imageNamed:@"icon_all1"]];
    
    
}


- (void)initView
{
    //  [self RRRqust];
    self.dataArray = [NSMutableArray array];
    [self setNavType];
    self.neighberTabView = [UITableView groupTableView];
    self.neighberTabView.frame = CGRectMake(0, 0, MainW, MainH - 64-49);
    self.neighberTabView.delegate = self;
    self.neighberTabView.dataSource = self;
    self.neighberTabView.backgroundColor = RGB(246, 246, 246);

    self.neighberTabView.sectionFooterHeight = 0.01;
    self.neighberTabView.sectionHeaderHeight = 0.01;
    
    HW = 0.5;//image.size.height / image.size.width;
    self.neighberTabView.tableHeaderView = self.tableheadview;

    [self.view addSubview:self.neighberTabView];

    
}


- (UIView *)tableheadview
{
    _tableheadview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 90 + HW * MainW)];
    _tableheadview.backgroundColor = Colorgrayall239;
#pragma-- ---------------- - 轮播图-- ----------------------------
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    self.cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, MainW, HW * MainW) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    _cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    _cycleScrollView3.autoScrollTimeInterval = 5;
    [_tableheadview addSubview:_cycleScrollView3];
#pragma-- ----------------四个按钮-- ----------------------------
    //四个按钮
    fourBtnView = [[FEFourbtnView alloc] initWithFrame:CGRectMake(0, _cycleScrollView3.frame.size.height, MainW, 90)];
    fourBtnView.delegete = self;
    //icon_My_community

    NSArray *fourbtnnameArray = @[ @"icon_all1", @"icon_Interest_FM", @"icon_Life_helper", @"icon_Community_activities" ];
    fourBtnView.fourbtnimageArray = fourbtnnameArray;
    [_tableheadview addSubview:fourBtnView];
    return _tableheadview;
}

- (void)choseCollectionBtnView:(FEFourbtnView *)FEFourbtnView didSelectedItemAtIndex:(NSInteger)index
{
    FELoginInfo *info = [LoginUtil getInfoFromLocal];
    if (index == 0)
    {
        [FELoginHelper loginMoel:info
                           andVC:self
                 andLoginedBlock:^{

                   if (isAll == YES)
                   {
                       isAll = NO;
                       displayType = [NSNumber numberWithInt:0];
                       [self doRequest:displayType];

                       NSIndexPath *indexpath = [NSIndexPath indexPathForItem:0 inSection:0];
                       UICollectionView *cllectionView = (UICollectionView *)FEFourbtnView.collections;
                       FEFourbtnCollectionViewCell *cell = (FEFourbtnCollectionViewCell *)[cllectionView cellForItemAtIndexPath:indexpath];
                       [cell.imageView setImage:[UIImage imageNamed:@"icon_My_community"]];
                   }
                   else
                   {
                       isAll = YES;
                       displayType = [NSNumber numberWithInt:1];
                       [self doRequest:displayType];

                       NSIndexPath *indexpath = [NSIndexPath indexPathForItem:0 inSection:0];
                       UICollectionView *cllectionView = (UICollectionView *)FEFourbtnView.collections;
                       FEFourbtnCollectionViewCell *cell = (FEFourbtnCollectionViewCell *)[cllectionView cellForItemAtIndexPath:indexpath];
                       [cell.imageView setImage:[UIImage imageNamed:@"icon_all1"]];
                   }

                 }];
    }

    if (index == 1)
    {
        WeakSelf;

        [FELoginHelper loginMoel:info
                           andVC:self
                 andLoginedBlock:^{

                   FEInterstingViewController *VC = [[FEInterstingViewController alloc] init];
                   [weakSelf.navigationController pushViewController:VC animated:YES];

                 }];
    }
    if (index == 2)
    {
        [FELoginHelper loginMoel:info
                           andVC:self
                 andLoginedBlock:^{

                   FEINtertingDetailViewController *VC = [[FEINtertingDetailViewController alloc] init];
                   VC.themeID = [NSNumber numberWithInt:9];
                   VC.title = @"生活助手";
                   [self.navigationController pushViewController:VC animated:YES];
                 }];
    }
    if (index == 3)
    {
        WeakSelf;

        [FELoginHelper loginMoel:info
                           andVC:self
                 andLoginedBlock:^{

                   FEActivityViewController *vc = [[FEActivityViewController alloc] init];
                   [weakSelf.navigationController pushViewController:vc animated:YES];

                 }];
    }
}

- (void)doRequest:(NSNumber *)Type
{
    NSString *str = @"020appd/community/social";
    [RYLoadingView showRequestLoadingView];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:Type forKey:@"displayType"];

    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"邻里圈首页---dic--%@", dic);
                                                       
                                                       
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

                                                     NSString *url = _imagesURLStrings[0];
                                                     //处理网络图片大小
                                                     NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                                                     UIImage *image = [UIImage imageWithData:data];
                                                     NSLog(@"w = %f,h = %f", image.size.width, image.size.height);
                                                     NSLog(@"宽高比---%f", image.size.height / image.size.width);
                                                     
                                                     _cycleScrollView3.imageURLStringsGroup = _imagesURLStrings;

                                                     NSArray *dicArray = dic[@"socialList"];
                                                     //字典数组转对象数组
                                                     NSArray *DynamicObjArray = [FEDynamicModel mj_objectArrayWithKeyValuesArray:dicArray];
                                                     self.dataArray = [NSMutableArray arrayWithArray:DynamicObjArray];

                                                     [self.neighberTabView reloadData];
                                                     //图片
                                                       

                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}

#pragma-- ------ - 设置导航样式-- ---------- -
- (void)setNavType
{
    //[FENavTool backOnNavigationItemWithNavItem:self.navigationItem target:self action:@selector(writeBntClick)];
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(writeBntClick) andType:item_whrite];
}
#pragma-- ----导航按钮点击方法-- ----------------
- (void)writeBntClick
{
    FEPublishController *pbCtl = [[FEPublishController alloc] init];
    [self.navigationController pushViewController:pbCtl animated:YES];
}

- (void)thieelineBtnClick
{
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 8)];
    secView.backgroundColor = [UIColor clearColor];
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEDynamicModel *curmodel = _dataArray[indexPath.section];
    CGFloat hgnum = [FEDynamicStateCell countCellHeightByModel:curmodel];
    return hgnum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infoCellIndetify = @"FEDynamicStateCell";
    FEDynamicStateCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //[tableView dequeueReusableCellWithIdentifier:infoCellIndetify];
    if (cell == nil)
    {
        cell = [[FEDynamicStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    FEDynamicModel *curmodel = _dataArray[indexPath.section];
    cell.model=curmodel;
    
    //[cell setUpCellViewAndModel:curmodel];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    FEDynamicModel *curModel = self.dataArray[indexPath.section];
    FENeighberDetailController *detailCtl = [[FENeighberDetailController alloc] init];
    detailCtl.indexpath = indexPath;

    detailCtl.delegete = self;

    detailCtl.curDModel = curModel;

    FEDynamicModel *curmodel = _dataArray[indexPath.section];
    CGFloat hgnum = [FEDynamicStateCell countCellHeightByModel:curmodel];
    detailCtl.height = hgnum;
    [self.navigationController pushViewController:detailCtl animated:YES];
}

- (void)refreshCommentCount:(NSNumber *)count AndIndex:(NSIndexPath *)path
{
    FEDynamicModel *curmodel = _dataArray[path.section];
    curmodel.commentCount = count;
    [_dataArray replaceObjectAtIndex:path.section withObject:curmodel];

    [_neighberTabView reloadRowsAtIndexPaths:@[ path ] withRowAnimation:UITableViewRowAnimationNone];
    //[_neighberTabView reloadData];
}

- (void)doShowImgAction:(NSMutableArray *)tgImgArr andIndex:(NSInteger)idx
{
    RYImagePreViewController *previewController = [[RYImagePreViewController alloc] initWithImg:tgImgArr andIsPush:NO andIndex:idx];
    FEBaseNavControllerViewController *navCtl = [[FEBaseNavControllerViewController alloc] initWithRootViewController:previewController];
    [self presentViewController:navCtl animated:YES completion:nil];
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
    if (cycleScrollView == _cycleScrollView3)
    {
        slideBlock ? slideBlock() : nil;
    }
    
}

@end
