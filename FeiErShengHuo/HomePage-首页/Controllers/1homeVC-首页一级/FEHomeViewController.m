
//  FEHomeViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEHomeViewController.h"
#import "FEComplainViewController.h"
#import "FENoticeViewController.h"
#import "FEPayViewController.h"
#import "FERepairViewController.h"
#import "SDCycleScrollView.h"
#import "SGAdvertScrollView.h"
#import "SGHelperTool.h"
#import "CZCountDownView.h"
#import "FEActivityViewController.h"
#import "FEAddinfoViewController.h"
#import "FEBreakRulesViewController.h"
#import "FEGoodModel.h"
#import "FEGroupBuyViewController.h"
#import "FEHomeCertifiedPropertyFourView.h"
#import "FEHomeLimitBuyCell.h"
#import "FEHotthirdView.h"
#import "FEIntergralRecordViewController.h"
#import "FEIntergralViewController.h"
#import "FELoginInfo.h"
#import "FELoginViewController.h"
#import "FENineBtnView.h"
#import "FEPaymentView.h"
#import "FERegionModel.h"
#import "FESecondHandViewController.h"
#import "FEShengViewController.h"
#import "FESmallFeiViewController.h"
#import "FEhotmesecondView.h"
#import "PhoneOpenDoorViewController.h"
#import "PhoneOpenDoorViewController.h"
#import "StoreDetialViewController.h"
#define PYMargin 10 // 默认边距

@interface FEHomeViewController () <
SDCycleScrollViewDelegate, SGAdvertScrollViewDelegate,
FEHomeCollectionBtnViewdelegate, UITableViewDelegate, UITableViewDataSource,
PullTableViewDelegate, UIGestureRecognizerDelegate,
FEHomeCertifiedPropertyFourViewdelegate, FEHomeFENineBtnViewdelegate,
FEPaymentViewdelegate>
{
    NSInteger curPage;
    NSInteger totNum;
    NSInteger pageSize;
    BOOL isLoadMore;
    FEHomeCertifiedPropertyFourView *FourView;
    FENineBtnView *nineView;
    UIButton *_choseRirionBtn;
    CGFloat HW;
    FEPaymentView *payMentView;
    FELoginInfo *info;
    NSString *headUrl;
    CZCountDownView *countDown;
    int indexC;
}
@property (nonatomic, retain) NSTimer *rotateTimer; //让视图自动切换
@property (nonatomic, retain) UIPageControl *myPageControl;
@property (nonatomic, strong) NSArray *imagesURLStrings; //让视图自动切换
@property (nonatomic, strong) NSMutableArray *slideUrlArry;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong)
SDCycleScrollView *cycleScrollView4; //让视图自动切换
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FEHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [ZSLNetworkConnect canConnectNetworkWithVC:self completion:^(BOOL ok) {
        if (ok) {
            NSLog(@"ok");

            [RYLoadingView hideNoNetView:self.view];
            //存在网络 的情况下 判断是否有内容 没内容再请请求
            if (self.dataArray.count <= 0)
            {
                NSLog(@"请求首页数据");
                [self doRRequest];
            }
            
        }else {
            NSLog(@"fail");
            
            [RYLoadingView showNoNetView:self action:@selector(reTryConnect)];
        }
    }];
    NSLog(@"--------读取缓存------------------------------------------");
    
    
    info = [LoginUtil getInfoFromLocal];
    
    NSLog(@"是否 登录 ---info--%@", info.isLogin);
    if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] ||
        [info.isLogin isKindOfClass:[NSNull class]] ||
        [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
    {
        FELoginViewController *vc = [[FELoginViewController alloc] init];
        // vc.delegete=self;
        FEBaseNavControllerViewController *logNav =
        [[FEBaseNavControllerViewController alloc]
         initWithRootViewController:vc];
        
        [self presentViewController:logNav animated:YES completion:nil];
        return;
    }
     [self doxioafeiRequest];
    if (indexC<=0) {
        labroud.hidden=YES;
    }
   
    if ([info.regionTitle isEqualToString:@""] || info.villageId == nil||[info.villageId isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        [_choseRirionBtn setTitle:@"请选择小区" forState:0];
        return;
        
    }
    [_choseRirionBtn setTitle:info.regionTitle forState:0];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [RYLoadingView hideNoNetView:self.view];
    
   
}
- (NSArray *)imagesURLStrings
{
    if (!_imagesURLStrings)
    {
        _imagesURLStrings = [[NSArray alloc] init];
    }
    
    return _imagesURLStrings;
}
- (NSArray *)titles
{
    if (!_titles)
    {
        _titles = [[NSArray alloc] init];
    }
    
    return _titles;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (NSMutableArray *)slideUrlArry
{
    if (!_slideUrlArry)
    {
        _slideUrlArry = [[NSMutableArray alloc] init];
    }
    return _slideUrlArry;
}

- (void)reTryConnect
{
    
    
    [ZSLNetworkConnect canConnectNetworkWithVC:self completion:^(BOOL ok) {
        if (ok) {
            NSLog(@"ok");
            
            [RYLoadingView hideNoNetView:self.view];
            //存在网络 的情况下 判断是否有内容 没内容再请请求
            if (self.dataArray.count <= 0)
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

- (void)initView
{
//    //子类拿到父类的对象
//    FEBaseNavControllerViewController *nav= (FEBaseNavControllerViewController *)self.navigationController;
//    [nav hideNav];
    
    HW=0.5;
    
    indexC=0;
    _xiaofeiArray = [[NSMutableArray alloc] init];
    [self setnavtype];
    _hometableView = [UITableView groupTableView];
    _hometableView.frame = CGRectMake(0, 0, MainW, MainH-64-49);
    _hometableView.delegate = self;
    _hometableView.dataSource = self;
    //_hometableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //断尾灰色
    _hometableView.sectionFooterHeight = 0.01f;
    _hometableView.sectionHeaderHeight = 30.0f;
    [self.view addSubview:self.hometableView];
    [self creatFirstView];
    
}


-(void)creatFirstView{
    FourView = [[FEHomeCertifiedPropertyFourView alloc] init];
    FourView.frame = CGRectMake(0, 0, MainW, MainH);
    //FourView.hidden=YES;
    FourView.alpha=0;
    FourView.fourView.alpha=0;
    
    FourView.fourView.transform=CGAffineTransformMakeScale(0.01, 0.01);
    FourView.delegete = self;
    [self.view addSubview:FourView];

}

- (void)doRRequest
{
    NSString *str = @"020appd/statuses/show";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //@{@"weid":@"1",@"reginonId":@"124" };
    int myInt = 1;
    NSNumber *myNumber = [NSNumber numberWithInt:myInt];
    [dic setObject:myNumber forKey:@"weid"];
    [dic setObject:@"124" forKey:@"reginonId"];
    
    [RYLoadingView showRequestLoadingView];
    
    [[FEBSAFManager sharedManager]
     doOperationRequestHttpWithMethod:POST
     withPath:str
     withDictionary:dic
     withSuccessBlock:^(NSDictionary *dic) {
         //NSLog(@"---hhahh-返回 %@", dic);
         
       
         
         
         
         //图片
         NSMutableArray *imageArray = dic[@"pictureList"];
         NSMutableArray *imageurlArray = [NSMutableArray array];
         NSMutableArray *headUrlArray = [NSMutableArray array];
         for (NSMutableDictionary *imagedic in imageArray)
         {
             NSString *url = imagedic[@"thumb"];
             NSString *slidUrl = imagedic[@"slideUrl"];
             [imageurlArray addObject:url];
             [headUrlArray addObject:slidUrl];
         }
         self.imagesURLStrings = [imageurlArray copy];
         self.slideUrlArry = [headUrlArray copy];
         
         NSString *url = _imagesURLStrings[0];
         NSString *url2=self.slideUrlArry[0];
         
         
         NSLog(@"------lubo---%@",url);
         NSLog(@"------slide--%@",url2);
         
         //处理网络图片大小
         NSData *data = [NSData
                         dataWithContentsOfURL:[NSURL URLWithString:url]];
         UIImage *image = [UIImage imageWithData:data];
         NSLog(@"w = %f,h = %f", image.size.width,
               image.size.height);
         NSLog(@"宽高比---%f",
               image.size.height / image.size.width);
         HW =0.5; //image.size.height / image.size.width;
         _hometableView.tableHeaderView = self.tableheadview;
         
         // 公告
         NSMutableArray *contentList = dic[@"contentList"];
         NSMutableArray *content = [NSMutableArray array];
         for (NSMutableDictionary *contentDic in contentList)
         {
             NSString *str = contentDic[@"title"];
             [content addObject:str];
             _titles = [content copy];
         }
         
         _cycleScrollView2.imageURLStringsGroup =
         _imagesURLStrings;
         if (!(_titles.count > 0))
         {
             _titles = @[@""];
             
             NSMutableArray *temp = (NSMutableArray *)[[[NSMutableArray arrayWithArray:_titles] reverseObjectEnumerator] allObjects];
             _cycleScrollView4.titlesGroup = temp;
         }
         else
         {
              NSMutableArray *temp = (NSMutableArray *)[[[NSMutableArray arrayWithArray:_titles] reverseObjectEnumerator] allObjects];
             _cycleScrollView4.titlesGroup = temp;
         }
         
         //
         //字典数组转模型数组
         NSArray *dicArray = dic[@"itemsList"];
         NSArray *array = [FEGoodModel
                           mj_objectArrayWithKeyValuesArray:dicArray];
         
        
         
         
         self.dataArray = [NSMutableArray arrayWithArray:array];
         
         if (self.dataArray.count> 0)
         {
             countDown.hidden=NO;
             FEGoodModel *good=self.dataArray[0];
             // dateLine  首页参数
             NSNumber *nunber = good.dateLine;
             NSInteger time = [nunber integerValue] / 1000;
             countDown.timestamp = time;
         }
         else
         {
             countDown.hidden = YES;
             
             // FESpecailGoodModel *model=array[0];
             NSInteger time =
             0; //[model.specialTime  integerValue]/1000;
             countDown.timestamp = time;
             
             // [RYLoadingView
             // showNoResultView:self.storetableView];
         }
         NSLog(@"首页liebiao----%@", dic[@"itemsList"]);
         [self.hometableView reloadData];
     }
     withfialedBlock:^(NSString *msg){
     }];
}

- (UIView *)tableheadview
{
    _tableheadview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW,HW * MainW + 75 / 2 + 225 + 148 / 2 + 183)];
    _tableheadview.backgroundColor = Colorgrayall239;
    
    NSArray *iconarray = @[
                           @"icon_notice1", @"icon_smart", @"icon_opendoor", @"icon_park",
                           @"icon_Voucher_Center", @"icon_Illegal_service", @"icon_Life_query",
                           @"icon_whole1"
                           ];
    
    _cycleScrollView2 = [SDCycleScrollView
                         cycleScrollViewWithFrame:CGRectMake(0, 0, MainW, HW * MainW)
                         delegate:self
                         placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView2.autoScrollTimeInterval = 5;
    _cycleScrollView2.tag = 10086;
    
    _cycleScrollView2.pageControlAliment =
    SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView2.currentPageDotColor =
    [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    
    [_tableheadview addSubview:self.cycleScrollView2];
#pragma-- ----------------大喇叭滑动-- ---------------------------- // Icon_microphone
    ZJInsertLab *xiaoxian = [[ZJInsertLab alloc]
                             initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleScrollView2.frame) + 1,
                                                      90, 75 / 2)];
    xiaoxian.backgroundColor = [UIColor whiteColor];
    xiaoxian.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    xiaoxian.text = @"小菲说";
    xiaoxian.insets = UIEdgeInsetsMake(0, 30, 0, 0);
    xiaoxian.textColor = Green_Color;
    [_tableheadview addSubview:xiaoxian];
    
    _cycleScrollView4 = [SDCycleScrollView
                         cycleScrollViewWithFrame:CGRectMake(90, CGRectGetMinY(xiaoxian.frame),
                                                             self.view.frame.size.width - 90,
                                                             75 / 2)
                         delegate:self
                         placeholderImage:nil];
    _cycleScrollView4.backgroundColor = [UIColor yellowColor];
    _cycleScrollView4.titleLabelTextColor = [UIColor blackColor];
    _cycleScrollView4.titleLabelBackgroundColor = [UIColor whiteColor];
    _cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    _cycleScrollView4.onlyDisplayText = YES;
    _cycleScrollView2.tag = 10010;
    
    _cycleScrollView4.autoScrollTimeInterval = 5;
    [_tableheadview addSubview:self.cycleScrollView4];
    
    UIImageView *imageView = [[UIImageView alloc]
                              initWithFrame:CGRectMake(MainW - 40,
                                                       CGRectGetMidY(_cycleScrollView4.frame) - 10, 15,
                                                       20)];
    imageView.image = [UIImage imageNamed:@"icon_triangle3"];
    
    [_tableheadview addSubview:imageView];
    
#pragma-- ----------------collectionView-- ----------------------------
    FEHomeCollectionBtnView *collectionView = [[FEHomeCollectionBtnView alloc]
                                               initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleScrollView4.frame) + 1,
                                                                        MainW, 90 * 2 + 15 * 3 - 8)];
    collectionView.delegate = self;
    collectionView.tempArray = iconarray;
    collectionView.backgroundColor = [UIColor whiteColor];
    [_tableheadview addSubview:collectionView];
    
    labroud =
    [[UILabel alloc] initWithFrame:CGRectMake(10 + 60 + 2, 5, 20, 20)];
   
    labroud.backgroundColor = [UIColor redColor];
    labroud.layer.cornerRadius = 10;
    labroud.layer.masksToBounds = YES;
    labroud.hidden=YES;
    
    labroud.textAlignment = NSTextAlignmentCenter;
    [collectionView addSubview:labroud];
    
    
    //积分商城
    FEhotmesecondView *integralView = [[FEhotmesecondView alloc]
                                       initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame) + 1,
                                                                MainW, 100)];
    [_tableheadview addSubview:integralView];
    //点击事件去积分商城手势
    integralView.userInteractionEnabled = YES;
    UITapGestureRecognizer *PrivateLetterTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goIntegral:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1;    // tap次数
    PrivateLetterTap.delegate = self;
    [integralView addGestureRecognizer:PrivateLetterTap];
    FEHotthirdView *homethirdView = [[FEHotthirdView alloc]
                                     initWithFrame:CGRectMake(0, CGRectGetMaxY(integralView.frame) + 1, MainW,
                                                              160)];
    [_tableheadview addSubview:homethirdView];
    WeakSelf;
    homethirdView.block = ^{
        [FELoginHelper loginMoel:info
                           andVC:weakSelf
                 andLoginedBlock:^{
                     
                     FEGroupBuyViewController *goupBuyVC =
                     [[FEGroupBuyViewController alloc] init];
                     [weakSelf.navigationController pushViewController:goupBuyVC
                                                              animated:YES];
                 }];
        
    };
    homethirdView.ABlock = ^{
        
        [FELoginHelper
         loginMoel:info
         andVC:weakSelf
         andLoginedBlock:^{
             FEActivityViewController *vc =
             [[FEActivityViewController alloc] init];
             [weakSelf.navigationController pushViewController:vc animated:YES];
         }];
        
    };
    homethirdView.Cblock = ^{
        
        [FELoginHelper
         loginMoel:info
         andVC:weakSelf
         andLoginedBlock:^{
             
             FESecondHandViewController *VC =
             [[FESecondHandViewController alloc] init];
             VC.personalFlag = [NSNumber numberWithInt:0];
             
             [weakSelf.navigationController pushViewController:VC animated:YES];
             
         }];
        
    };
    return _tableheadview;
}
#pragma mark--- 积分商城，完成跳转
- (void)goIntegral:(UITapGestureRecognizer *)gesture
{
    WeakSelf;
    [FELoginHelper loginMoel:info
                       andVC:self
             andLoginedBlock:^{
                 FEIntergralViewController *IntergralVC =
                 [[FEIntergralViewController alloc] init];
                 [weakSelf.navigationController pushViewController:IntergralVC
                                                          animated:YES];
             }];
}
#pragma-- ------------ - SGAdvertScrollView Delegate-- -------------------- -

/// 代理方法   点击大喇叭跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index
{
    WeakSelf;
    [FELoginHelper
     loginMoel:info
     andVC:self
     andLoginedBlock:^{
         
         [weakSelf crollView:cycleScrollView
                goslideBlock:^{
                    NSString *str = weakSelf.slideUrlArry[index];
                    FEBreakRulesViewController *breakVC2 =
                    [[FEBreakRulesViewController alloc] init];
                    breakVC2.title = @"";
                    breakVC2.urlStr =
                    str; //@"http://admin.feierlife.com:8080/Home/ViolationIndex";
                    [weakSelf.navigationController pushViewController:breakVC2
                                                             animated:YES];
                    
                }
             orSmallFeiBlock:^{
                 FESmallFeiViewController *vc =
                 [[FESmallFeiViewController alloc] init];
                 [weakSelf.navigationController pushViewController:vc
                                                          animated:YES];
             }];
     }];
}

- (void)crollView:(SDCycleScrollView *)cycleScrollView
     goslideBlock:(void (^)())slideBlock
  orSmallFeiBlock:(void (^)())smallBlock
{
    if (cycleScrollView == _cycleScrollView2)
    {
        slideBlock ? slideBlock() : nil;
    }
    if (cycleScrollView == _cycleScrollView4)
    {
        smallBlock ? smallBlock() : nil;
    }
}

//小菲
- (void)doxioafeiRequest

{
    
    NSString *str = @"020appd/messagequene/show";
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]
     doOperationRequestHttpWithMethod:POST
     withPath:str
     withDictionary:nil
     withSuccessBlock:^(NSDictionary *dic) {
         NSLog(@"未读消息--%@", dic);
         indexC = [dic[@"newsNum"] intValue];
         FourView.indexC=indexC;
          labroud.text = [NSString stringWithFormat:@"%d", indexC];
         labroud.textColor = [UIColor whiteColor];
         // 红点
         if (indexC == 0)
         {
             labroud.hidden = YES;
             
         }
         else
         {
             labroud.hidden = NO;
            
         }
         

     }
     withfialedBlock:^(NSString *msg){
         
     }];
}

#pragma-- ----------------collectionView Delegete-- ----------------------------
//点击8个按钮跳转

- (void)choseCollectionBtnView:(FEHomeCollectionBtnView *)CollectionBtnView
        didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"是否 登录 ---info--%@", info.isLogin);
    if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] ||
        [info.isLogin isKindOfClass:[NSNull class]] ||
        [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
    {
        FELoginViewController *vc = [[FELoginViewController alloc] init];
        // vc.delegete=self;
        FEBaseNavControllerViewController *logNav =
        [[FEBaseNavControllerViewController alloc]
         initWithRootViewController:vc];
        
        [self presentViewController:logNav animated:YES completion:nil];
        return;
    }
    if (index == 0)
    { //弹出一个view   然后这个view 有四个按钮
        
        //判断小区
        if ([info.villageId intValue] <= 0)
        {
            //跳转健全信息页面
            // 没有的情况  去健全小区和上传信息
            FEAddinfoViewController *addinfoVC =
            [[FEAddinfoViewController alloc] init];
            FEBaseNavControllerViewController *addNav =
            [[FEBaseNavControllerViewController alloc]
             initWithRootViewController:addinfoVC];
            
            [self presentViewController:addNav animated:YES completion:nil];
            
            return;
        }
        
        if ([info.isValidate isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            [FENavTool showAlertViewByAlertMsg:@"当前的小区未认证" andType:@"提示"];
            return;
        }
        
//        //FourView.hidden=NO;
//        [UIView animateWithDuration:0.2 animations:^{
//            
//
//            FourView.alpha=1;//[UIColor colorWithWhite:0 alpha:0.5];
//            FourView.fourView.alpha=1;
//            
//            
//        }];
        
        [UIView animateWithDuration:0.2 animations:^{
            FourView.fourView.transform=CGAffineTransformMakeScale(1.0, 1.0);
            
        } completion:^(BOOL finished) {
            
            FourView.alpha=1;//[UIColor colorWithWhite:0 alpha:0.5];
            FourView.fourView.alpha=1;

        }];
        
        
        
       
    }
    if (index == 1)
    {
        //智能家居。待完善
        
        //判断小区
        if ([info.villageId intValue] <= 0)
        {
            //跳转健全信息页面
            // 没有的情况  去健全小区和上传信息
            FEAddinfoViewController *addinfoVC =
            [[FEAddinfoViewController alloc] init];
            FEBaseNavControllerViewController *addNav =
            [[FEBaseNavControllerViewController alloc]
             initWithRootViewController:addinfoVC];
            
            [self presentViewController:addNav animated:YES completion:nil];
            
            return;
        }
        
        if ([info.isValidate isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            [FENavTool showAlertViewByAlertMsg:@"当前的小区未认证" andType:@"提示"];
            return;
        }
        
        FEHomeSmartViewController *homeSmartVC =
        [[FEHomeSmartViewController alloc] init];
        [self.navigationController pushViewController:homeSmartVC animated:YES];
    }
    if (index == 2)
    {
               //判断小区
        if ([info.villageId intValue] <= 0)
        {
            //跳转健全信息页面
            // 没有的情况  去健全小区和上传信息
            FEAddinfoViewController *addinfoVC =
            [[FEAddinfoViewController alloc] init];
            FEBaseNavControllerViewController *addNav =
            [[FEBaseNavControllerViewController alloc]
             initWithRootViewController:addinfoVC];
            
            [self presentViewController:addNav animated:YES completion:nil];
            
            return;
        }
        
        if ([info.isValidate intValue] == 0)
        {
            [FENavTool showAlertViewByAlertMsg:@"当前的小区未认证" andType:@"提示"];
            return;
        }
        
        PhoneOpenDoorViewController *vc =
        [[PhoneOpenDoorViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 3)
    {
        WeakSelf;
        [FELoginHelper loginMoel:info
                           andVC:self
                 andLoginedBlock:^{
                     FEBreakRulesViewController *breakVC2 =
                     [[FEBreakRulesViewController alloc] init];
                     breakVC2.title = @"共享停车";
                     breakVC2.urlStr = [NSString
                                        stringWithFormat:@"http://admin.feierlife.com:8080/home/"
                                        @"Parkingreserve?regionid=%@&userid=%@",
                                        info.villageId, info.userId];
                     
                     [weakSelf.navigationController pushViewController:breakVC2
                                                              animated:YES];
                 }];
    }
    if (index == 4)
    {
        payMentView = [[FEPaymentView alloc] init];
        payMentView.frame = CGRectMake(0, 0, MainW, MainH);
        payMentView.delegete = self;
        [self.view addSubview:payMentView];
        [payMentView.BackGroundBnt addTarget:self
                                      action:@selector(dismisspayMentView)
                            forControlEvents:UIControlEventTouchUpInside];
    }
    if (index == 5)
    {
        FEBreakRulesViewController *breakVC2 =
        [[FEBreakRulesViewController alloc] init];
        breakVC2.title = @"违章服务";
        breakVC2.urlStr = @"http://admin.feierlife.com:8080/Home/ViolationIndex";
        [self.navigationController pushViewController:breakVC2 animated:YES];
    }
    if (index == 6)
    {
        [FEWebViewHelper
         webViewSetTiele:@"综合查询"
         andUrl:@"http://admin.feierlife.com:8080/Home/Tickets"
         andSelfPush:self];
        
       
    }
    if (index == 7)
    {
        nineView = [[FENineBtnView alloc] init];
        nineView.frame = CGRectMake(0, 0, MainW, MainH);
        nineView.delegete = self;
        
        [self.view addSubview:nineView];
        [nineView.BackGroundBtn addTarget:self
                                   action:@selector(dismissNineView)
                         forControlEvents:UIControlEventTouchUpInside];
    }
}
//第一个按钮中弹出四个
- (void)choseFourCollectionBtnView:
(FEHomeCertifiedPropertyFourView *)CollectionBtnView
            didSelectedItemAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        NSLog(@"点击小区公告");
        
        FENoticeViewController *noticeVC = [[FENoticeViewController alloc] init];
        
        noticeVC.block = ^{
            
            indexC=0;
            labroud.hidden=YES;
            
            FourView.lab.hidden=YES;
        };
        
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    if (index == 1)
    {
        FEComplainViewController *complainVC =
        [[FEComplainViewController alloc] init];
        [self.navigationController pushViewController:complainVC animated:YES];
    }
    if (index == 2)
    {
        FERepairViewController *repairVC = [[FERepairViewController alloc] init];
        [self.navigationController pushViewController:repairVC animated:YES];
    }
    
    if (index == 3)
    {
        FEBreakRulesViewController *breakVCF3 =
        [[FEBreakRulesViewController alloc] init];
        breakVCF3.title = @"物业缴费";
        
        breakVCF3.urlStr =
        [NSString stringWithFormat:@"http://admin.feierlife.com/Home/"
         @"Paymentlist?weid=1&regionid=%@&userid=%@",
         info.villageId, info.userId];
        
        [self.navigationController pushViewController:breakVCF3 animated:YES];
    }
    if (index == 4)
    {
        FEBreakRulesViewController *breakVCF4 =
        [[FEBreakRulesViewController alloc] init];
        breakVCF4.title = @"服务热线";
        NSString *urlstr = [NSString
                            stringWithFormat:@"http://admin.feierlife.com/roster/Phone?regionid=%@",
                            info.villageId];
        
        breakVCF4.urlStr = urlstr;
        
        [self.navigationController pushViewController:breakVCF4 animated:YES];
    }
    
    if (index == 5)
    {
        FEBreakRulesViewController *breakVCF5 =
        [[FEBreakRulesViewController alloc] init];
        breakVCF5.title = @"调查问卷";
        NSString *VJstr = [NSString
                           stringWithFormat:
                           @"http://admin.feierlife.com/home/GetQuestion?regionid=%@",
                           info.villageId];
        breakVCF5.urlStr = VJstr;
        
        [self.navigationController pushViewController:breakVCF5 animated:YES];
    }
}
- (void)choseFEPaymentView:(FEPaymentView *)paymentView
    didSelectedItemAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        FEBreakRulesViewController *breakVCP0 =
        [[FEBreakRulesViewController alloc] init];
        breakVCP0.title = @"水费";
        breakVCP0.urlStr =[NSString stringWithFormat:@"http://admin.feierlife.com:8080/home/Livingexpenses?userid=%@&type=1",info.userId];
        [self.navigationController pushViewController:breakVCP0 animated:YES];
    }
    if (index == 1)
    {
        FEBreakRulesViewController *breakVCP1 =
        [[FEBreakRulesViewController alloc] init];
        breakVCP1.title = @"电费";
        breakVCP1.urlStr =[NSString stringWithFormat:@"http://admin.feierlife.com:8080/home/Livingexpenses?userid=%@&type=2",info.userId];
        [self.navigationController pushViewController:breakVCP1 animated:YES];
    }
    if (index == 2)
    {
        FEBreakRulesViewController *breakVCP2 =
        [[FEBreakRulesViewController alloc] init];
        breakVCP2.title = @"天燃气";
        breakVCP2.urlStr =[NSString stringWithFormat:@"http://admin.feierlife.com:8080/home/Livingexpenses?userid=%@&type=3",info.userId];
        
        
        [self.navigationController pushViewController:breakVCP2 animated:YES];
    }
    if (index == 3)
    {
        FEBreakRulesViewController *breakVCP3 =
        [[FEBreakRulesViewController alloc] init];
        breakVCP3.title = @"话费充值";
        breakVCP3.urlStr = [NSString stringWithFormat:@"http://admin.feierlife.com:8080/Home/Voucher?userid=%@",info.userId];
        [self.navigationController pushViewController:breakVCP3 animated:YES];
    }
    if (index == 4)
    {
        FEBreakRulesViewController *breakVC2 =
        [[FEBreakRulesViewController alloc] init];
        breakVC2.title = @"流量充值";
        breakVC2.urlStr =[NSString stringWithFormat:@"http://admin.feierlife.com:8080/Home/Flowrecharge?userid=%@",info.userId];
        [self.navigationController pushViewController:breakVC2 animated:YES];
    }
    if (index == 5)
    {
        FEBreakRulesViewController *breakVC2 =
        [[FEBreakRulesViewController alloc] init];
        breakVC2.title = @"油卡充值";
        breakVC2.urlStr =[NSString stringWithFormat:@"http://admin.feierlife.com:8080/Home/Petroleum?userid=%@",info.userId];
        [self.navigationController pushViewController:breakVC2 animated:YES];
    }
}
//全部按钮中弹出九个
- (void)choseNineCollectionBtnView:(FENineBtnView *)CollectionBtnView
            didSelectedItemAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            NSString *VJstr =
            [NSString stringWithFormat:@"http://admin.feierlife.com:8080/home/"
             @"Parkingreserve?regionid=%@&userid=%@",
             info.villageId, info.userId];
            [FEWebViewHelper webViewSetTiele:@"共享停车"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
            
        case 1:
        {
            NSString *VJstr = @"http://admin.feierlife.com:8080/Home/ViolationIndex";
            [FEWebViewHelper webViewSetTiele:@"违章查询"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
            
        case 2:
        {
            NSString *VJstr = @"http://admin.feierlife.com:8080/Home/ViolationIndex";
            [FEWebViewHelper webViewSetTiele:@"违章代缴"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
            
        case 3:
        {
            NSString *VJstr = [NSString
                               stringWithFormat:
                               @"http://admin.feierlife.com/home/GetQuestion?regionid=%@",
                               info.villageId];
            [FEWebViewHelper webViewSetTiele:@"调查问卷"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
            
        case 4:
        {
            NSString *VJstr = @"http://admin.feierlife.com:8080/Home/Tickets";
            [FEWebViewHelper webViewSetTiele:@"车票查询"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
            
        case 5:
        {
            NSString *VJstr = @"http://admin.feierlife.com:8080/Home/Flight";
            [FEWebViewHelper webViewSetTiele:@"航班查询"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
            
        case 6:
        {
            NSString *VJstr =
            [NSString stringWithFormat:
             @"http://admin.feierlife.com/roster/Phone?regionid=%@",
             info.villageId];
            [FEWebViewHelper webViewSetTiele:@"服务热线"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
        case 7:
        {
            NSString *VJstr =[NSString stringWithFormat: @"http://admin.feierlife.com:8080/Home/Flowrecharge?userid=%@",info.userId];
            [FEWebViewHelper webViewSetTiele:@"流量充值"
                                      andUrl:VJstr
                                 andSelfPush:self];
        }
            
            break;
        case 8:
        {
            NSString *VJstr =[NSString stringWithFormat: @"http://admin.feierlife.com:8080/Home/Voucher?userid=%@",info.userId];
            [FEWebViewHelper webViewSetTiele:@"话费充值"
                                      andUrl:VJstr
                                 andSelfPush:self]; 
        }
            
            break;
            
        default:
            break;
    }
}
- (void)dismissFourView
{
    // 消失视图
    FourView.hidden=YES;
    
}

- (void)dismissNineView
{
    // 消失视图
    nineView.hidden=YES;
    

}

- (void)dismisspayMentView
{
    payMentView.hidden=YES;
    

}

- (void)setnavtype
{
    UIImageView *imageView =
    [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    imageView.image = [UIImage imageNamed:@"app3_logo"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *leftNegativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil
                                           action:nil];
    leftNegativeSpacer.width = -10;
    
    UIBarButtonItem *settingItem =
    [[UIBarButtonItem alloc] initWithCustomView:imageView];
    self.navigationItem.leftBarButtonItems = @[leftNegativeSpacer, settingItem];
    
    // right
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil
                                       action:nil];
    negativeSpacer.width = -10;
    _choseRirionBtn = [[FL_Button fl_shareButton]
                       initWithAlignmentStatus:FLAlignmentStatusRight];
    [_choseRirionBtn setImage:[UIImage imageNamed:@"icon_address_label"]
                     forState:0];
    
    //[_choseRirionBtn setTitle:@"请选择小区" forState:0];
    [_choseRirionBtn setFrame:CGRectMake(0, 0, 200, 20)];
    _choseRirionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [_choseRirionBtn addTarget:self
                        action:@selector(choseRegion)
              forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *choseItem =
    [[UIBarButtonItem alloc] initWithCustomView:_choseRirionBtn];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, choseItem];
}

- (void)choseRegion
{
    //首先判断是否登录
    NSLog(@"是否 登录 ---info--%@", info.isLogin);
    if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] ||
        [info.isLogin isKindOfClass:[NSNull class]] ||
        [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
    {
        FELoginViewController *vc = [[FELoginViewController alloc] init];
        // vc.delegete=self;
        FEBaseNavControllerViewController *logNav =
        [[FEBaseNavControllerViewController alloc]
         initWithRootViewController:vc];
        
        [self presentViewController:logNav animated:YES completion:nil];
        return;
    }
    
    //判断小区
    if ([info.villageId intValue] <= 0)
    {
        //跳转健全信息页面
        // 没有的情况  去健全小区和上传信息
        FEAddinfoViewController *addinfoVC = [[FEAddinfoViewController alloc] init];
        FEBaseNavControllerViewController *addNav =
        [[FEBaseNavControllerViewController alloc]
         initWithRootViewController:addinfoVC];
        
        [self presentViewController:addNav animated:YES completion:nil];
        
        return;
    }
    
    FEMyRegionViewController *VC = [[FEMyRegionViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return _dataArray.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.dataArray.count > 0)
        {
            return 80;
        }
        else
        {
            
            return 0.01;
        }
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.dataArray.count> 0)
        {
            UIView *view2 =
            [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 80)];
            view2.backgroundColor = Colorgrayall239;
            UIView *view3 =
            [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, MainW, 79)];
            view3.backgroundColor = [UIColor whiteColor];
            [view2 addSubview:view3];
            
            UILabel *lab = [[UILabel alloc] init];
            lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
            lab.text = @"限时抢购";
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = RGB(254, 64, 64);
            lab.frame = CGRectMake(MainW / 2 - 100, 5, 200, 30);
            [view3 addSubview:lab];
            
            //
            FEGoodModel *good=self.dataArray[0];
            // dateLine  首页参数
            NSNumber *nunber = good.dateLine;
            NSInteger time = [nunber integerValue] / 1000;
            
            //倒计时
            countDown = [CZCountDownView countDown];
            countDown.frame =
            CGRectMake(MainW / 2 - 100, CGRectGetMaxY(lab.frame) + 5, 200, 30);
            // countDown.timestamp =//10000;
            countDown.timestamp = time;
            
            WeakSelf;
            
            countDown.timerStopBlock = ^{
                
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.hometableView reloadData];
            
            };
            
            // countDown.backgroundImageName = @"search_k";
            countDown.backgroundColor = [UIColor whiteColor];
            [view3 addSubview:countDown];
            countDown.timerStopBlock = ^{
                NSLog(@"时间停止");
            };
            return view2;
        }
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FEHomeLimitBuyCell countSecondHotSaleHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *secondCellID = @"FEHomeLimitBuyCell";
    FEHomeLimitBuyCell *cell2 =
    [tableView dequeueReusableCellWithIdentifier:secondCellID];
    if (cell2 == nil)
    {
        cell2 =
        [[FEHomeLimitBuyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:secondCellID];
        cell2.backgroundColor = [UIColor whiteColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FEGoodModel *curModel = _dataArray[indexPath.row];
    [cell2 setUpCellWithModel:curModel];
    WeakSelf;
    
    cell2.block = ^{
        StrongSelf;
        
        [strongSelf gogoClick:curModel];
        
        NSLog(@"点击了购物车");
    };
    
    return cell2;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"是否 登录 ---info--%@", info.isLogin);
    if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] ||
        [info.isLogin isKindOfClass:[NSNull class]] ||
        [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
    {
        FELoginViewController *vc = [[FELoginViewController alloc] init];
        // vc.delegete=self;
        FEBaseNavControllerViewController *logNav =
        [[FEBaseNavControllerViewController alloc]
         initWithRootViewController:vc];
        
        [self presentViewController:logNav animated:YES completion:nil];
        return;
    }
    
    //判断小区
    if ([info.villageId intValue] <= 0)
    {
        //跳转健全信息页面
        // 没有的情况  去健全小区和上传信息
        FEAddinfoViewController *addinfoVC = [[FEAddinfoViewController alloc] init];
        FEBaseNavControllerViewController *addNav =
        [[FEBaseNavControllerViewController alloc]
         initWithRootViewController:addinfoVC];
        
        [self presentViewController:addNav animated:YES completion:nil];
        
        return;
    }
    
    FEGoodModel *curModel = _dataArray[indexPath.row];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreDetialViewController *detailVC =
    [[StoreDetialViewController alloc] init];
    detailVC.curModel = curModel;
    
    detailVC.goodsId = curModel.goodsId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma-- ---- - 添加购物车-- ----------------
- (void)gogoClick:(FEGoodModel *)model
{
    NSString *diQu = model.origin;
    
    NSString *Msg = [NSString
                     stringWithFormat:
                     @"该商品只支持%@地区销售，确认添加购物车？", diQu];
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
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:model.goodsId forKey:@"goodsId"];
    NSNumber *nunber = [NSNumber numberWithInteger:model.productprice];
    [dic setObject:nunber forKey:@"productPrice"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"total"];
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]
     doOperationRequestHttpWithMethod:POST
     withPath:str
     withDictionary:dic
     withSuccessBlock:^(NSDictionary *dic) {
         
         [FENavTool showAlertViewByAlertMsg:@"添加成功"
                                    andType:@"提示"];
#pragma-- --通知本地购物车刷新-- ------
         //
         //        [[NSNotificationCenter defaultCenter]
         //        postNotificationName:NOTI_REFRESH_TOCar
         //        object:model];
         
     }
     withfialedBlock:^(NSString *msg){
         
     }];
}

@end
