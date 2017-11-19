 
//  StoreDetialViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/18.
//  Copyright © 2017年 xjbyte. All rights reserved.

#import "StoreDetialViewController.h"
#import "GoodsPriceAndNameCell.h"
#import "GoodsChoseAndTypeCell.h"
#import "SDCycleScrollView.h"
#import "FDEGoodsDetailModel.h"
#import "FEGoodsArgumentsController.h"
#import "STPopupController.h"
#import "FEHomeViewController.h"
#import "FEStoreCommentModel.h"
#import "FEComentViewController.h"
#import "FEbuyNowViewController.h"
#import "FEcommmentView.h"
#import "FECanshuTableViewCell.h"
#import "FEFirstComentTableViewCell.h"
#import "MJRefresh.h"

static NSString *const cellId = @"DemoVC1Cell";

@interface StoreDetialViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,GoodsPriceAndNameCelldelegete>

{
    UILabel *bottomLab;
    NSArray *Comnttarray;
    FEcommmentView *view1;
    UIButton *bgbtn1;
    FDEGoodsDetailModel *_curDetailmodel;
    CGFloat HW;
}

@property(strong,nonatomic)UIScrollView *scrollV;   //滑动视图
@property(strong,nonatomic)NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imagesURLStrings;  //首页图片
@property(strong,nonatomic)UITableView *tableV;
@property(strong,nonatomic)UITableView *tableV2;
@property(strong,nonatomic)UIWebView *webV;
@property (nonatomic, strong) UIScrollView *imageScroll;
@property(nonatomic, copy)NSString *ad_targetid;
//@property(nonatomic,strong)FDEGoodsDetailModel *model;
@property(strong,nonatomic)UIButton *commentBtn;
@property(nonatomic,strong)UILabel *choseAndTypeLab;
@property(nonatomic,strong)NSMutableArray *imageDtailArray;
@property(nonatomic,strong)NSArray *dataArray2;


@end
@implementation StoreDetialViewController
-(NSArray *)dataArray2
{
    if (_dataArray2==nil) {
        _dataArray2=[[NSArray alloc]init];
        
    }
    return _dataArray2;
    
}

-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];
        
    }
    return _dataArray;
    
}
-(UIScrollView *)scrollV
{
    if (_scrollV == nil)
    {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainW, MainH- 64)];
        _scrollV.contentSize = CGSizeMake(MainW, MainH * 2);
        //设置分页效果
        _scrollV.pagingEnabled = YES;
        //禁用滚动
        _scrollV.scrollEnabled = NO;
    }
    return _scrollV;
}

-(NSMutableArray *)imageDtailArray{
    if(_imageDtailArray==nil)
    {
        _imageDtailArray=[[NSMutableArray alloc]init];
    
    }
    return _imageDtailArray;
}

-(void)viewDidLoad
{

    [super viewDidLoad];
    [self RRRuqest];
    self.title=@"商品详情";
    
    [self.view addSubview:self.scrollV];
    [self.scrollV addSubview:self.tableV];
    [self.scrollV addSubview:self.tableV2];
    
    [self.tableV2 registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉，执行对应的操作---改变底层滚动视图的滚动到对应位置
        //设置动画效果
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollV.contentOffset = CGPointMake(0, MainH);
            
            //[self.tableV2 reloadData];
            
        } completion:^(BOOL finished) {
            //结束加载
            [self.tableV.mj_footer endRefreshing];
        }];
        
    }];
    
    //设置UIWebView 有下拉操作
    self.tableV2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        self.scrollV.contentOffset = CGPointMake(0, 0);
        //结束加载
        [self.tableV2.mj_header endRefreshing];
    }];


    [self creatBottomView];
    [self RRRuqest];
}

-(UITableView *)tableV

{
    if (_tableV==nil) {
        _tableV=[UITableView groupTableView];
        _tableV.frame=CGRectMake(0, 0, MainW, MainH-64-49);
        _tableV.delegate=self;
        _tableV.dataSource=self;
        _tableV.sectionHeaderHeight=0.01;
        _tableV.sectionFooterHeight=0.01;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        //_tableV.tableHeaderView=self.tableheadview;

    }
    return _tableV;

}
-(UITableView *)tableV2
{
    
    if (_tableV2==nil) {
        _tableV2=[UITableView groupTableView];
        _tableV2.frame=CGRectMake(0, MainH, MainW, MainH-64-49);
        _tableV2.delegate=self;
        _tableV2.dataSource=self;
        _tableV2.sectionHeaderHeight=0.01;
        _tableV2.sectionFooterHeight=0.01;
        _tableV2.separatorStyle=UITableViewCellSeparatorStyleNone;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 0.1)];
        _tableV2.tableHeaderView=view;
        
        
    }
    return _tableV2;
    
}
 
-(void)RRRuqest
{
    NSLog(@"suoying----%@",self.goodsId);
    NSString *str=@"020appd/mall/detail";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:_goodsId forKey:@"goodsId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        
        NSLog(@"商品相亲详情--------%@",dic);
        _curDetailmodel=[FDEGoodsDetailModel mj_objectWithKeyValues:dic[@"mallList"]];
        //[self.dataArray addObject:curmodel];
        
        NSMutableArray *imageArray=[[NSMutableArray alloc]init];
        
        for (FECarouselList * model in _curDetailmodel.carouselList) {
            NSString *url=model.url;
            [imageArray addObject:url];
        }
        
        
//        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images" ofType:@"json"]];
//        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
//        self.dataArray2 = json[@"data"];
        self.dataArray2=[_curDetailmodel.commodityimgList copy];
        
        [self.tableV2 reloadData];
        
        NSString *url=imageArray[0];
        //处理网络图片大小
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"w = %f,h = %f" ,image.size.width,image.size.height);
        NSLog(@"宽高比---%f",image.size.height/image.size.width);
        HW=image.size.height/image.size.width;
        self.tableV.tableHeaderView=self.tableheadview;
        
        _cycleScrollView2.imageURLStringsGroup = imageArray;
        Comnttarray=[FEStoreCommentModel mj_objectArrayWithKeyValuesArray:dic[@"contentList"]];
        
        bgbtn1=[[UIButton alloc]init];
        bgbtn1.frame=CGRectMake(0, 0, MainW, MainH);
        [bgbtn1 addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
        
        bgbtn1.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
        bgbtn1.hidden=YES;
        
        [self.view addSubview:bgbtn1];

        view1=[[FEcommmentView alloc]init];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmiss)];
        [view1 addGestureRecognizer:tap];
        view1.userInteractionEnabled=YES;
        view1.comntlist=Comnttarray;
        [_commentBtn setTitle:[NSString stringWithFormat:@"%ld",Comnttarray.count]forState:UIControlStateNormal];
        
        if (Comnttarray.count>0) {
            [self.view addSubview:view1];
            [view1 makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.view.centerX);
                make.bottom.equalTo(self.view.bottom);
                make.width.equalTo(MainW);
                make.height.equalTo(Comnttarray.count*60);
            }];
            view1.hidden=YES;
        }
        else
        {
            view1=nil;
            
        }
        [self.tableV reloadData];
        
    } withfialedBlock:^(NSString *msg) {
    }];
}

#pragma mark -bottomview
-(void)creatBottomView{
    //首页
    UIButton *homeBtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusTop];
    [homeBtn setImage:[UIImage imageNamed:@"[Details]-home_page"] forState:0];
    [homeBtn setTitle:@"首页" forState:0];
    homeBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [homeBtn setTitleColor:[UIColor blackColor] forState:0];
    homeBtn.frame=CGRectMake(0, MainH-64-49, (MainW/2-25)/2, 49);
    homeBtn.backgroundColor=[UIColor whiteColor];
    [homeBtn addTarget:self action:@selector(gohomeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    //客服
    UIButton *clientele =[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusTop];
    [clientele setImage:[UIImage imageNamed:@"[Details]-Customer_service"] forState:0];
    [clientele setTitle:@"客服" forState:0];
    clientele.titleLabel.font=[UIFont systemFontOfSize:10];
    [clientele setTitleColor:[UIColor blackColor] forState:0];
    clientele.frame=CGRectMake((MainW/2-25)/2, MainH-64-49, (MainW/2-25)/2, 49);
    clientele.backgroundColor=[UIColor whiteColor];
    [clientele addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:clientele];
    
    UIButton *addShopCar=[MYUI creatNormalButtonFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"[Details]-Button_Shoppingcart"] setTitle:@"加入购物车" setTitleColor:[UIColor whiteColor]];
    [addShopCar addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addShopCar];
    addShopCar.frame=CGRectMake(MainW/2-25, MainH-64-49, (MainW/2+25)/2, 49);
    UIButton *buyNow=[MYUI creatNormalButtonFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"[Details]-Button_purchase"] setTitle:@"立即购买" setTitleColor:[UIColor whiteColor]];
    [buyNow addTarget:self action:@selector(buyNowClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyNow];
    buyNow.frame=CGRectMake(MainW-((MainW/2+25)/2), MainH-64-49, (MainW/2+25)/2, 49);
}
-(void)phone
{
    FEkeFuViewController *VC=[[FEkeFuViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}
//去首页
-(void)gohomeClick
{
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[FEHomeViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//购买

-(void)buyNowClick
{
    
    
    NSString *diQu=_curDetailmodel.origin;
    
    NSString *Msg=[NSString stringWithFormat:@"该商品只支持%@地区销售，确认立即购买？",diQu];
    
    [FENavTool showAlertRightAndCancelMsg:Msg andType:@"提示" andRightClick:^{
        
       // [self addCarRequest];
        
        FEbuyNowViewController *buyNowVC=[[FEbuyNowViewController alloc]init];
        
       // FEGoodModel *modelll=[[FEGoodModel alloc]init];
        
        buyNowVC.goodModel=self.curModel;
        
        
        buyNowVC.buyFromWhereType=[NSNumber numberWithInteger:0];
        [self.navigationController pushViewController:buyNowVC animated:YES];

        
    } andCancelClick:^{
        
    }];
    
}

-(UIView *)tableheadview
{
    if (!_tableheadview) {
        
        _tableheadview=[[UIView alloc]initWithFrame:CGRectMake(0,0, MainW,MainW*HW)];
        _tableheadview.backgroundColor=Colorgrayall239;
        _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,MainW, MainW*HW) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView2.autoScrollTimeInterval=5;
        _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [_tableheadview addSubview:self.cycleScrollView2];

    }

    return _tableheadview;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    
    if (tableView==self.tableV) {
        
        return 3;
        
    }
    if (tableView==self.tableV2) {
        return 1;
        
    }
    return 0;
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView==self.tableV) {
        
        return 1;
        
    }
    
    if (tableView==self.tableV2) {
        return self.dataArray2.count;
        
    }
    return 0;
    
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.tableV) {
        if (indexPath.section==0)
        {
            static NSString *GoodsPriceAndNameCellID=@"cellID0";
            
            GoodsPriceAndNameCell *cell=[tableView dequeueReusableCellWithIdentifier:GoodsPriceAndNameCellID];
            if (cell==nil) {
                cell=[[GoodsPriceAndNameCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoodsPriceAndNameCellID];
                cell.contentView.backgroundColor=[UIColor whiteColor];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.delegete=self;
            }
            // FDEGoodsDetailModel *curmodel=self.dataArray[0];
            
            [cell setupCellWithModel:_curDetailmodel];
            return cell;
        }
        
        if (indexPath.section==1)
        {
            static NSString *GoodsPriceAndNameCellID1=@"cellID1";
            
            FECanshuTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:GoodsPriceAndNameCellID1];
            if (cell1==nil) {
                cell1=[[FECanshuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GoodsPriceAndNameCellID1];
                cell1.contentView.backgroundColor=[UIColor whiteColor];
                [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
                
            }
            //FDEGoodsDetailModel *curmodel=self.dataArray[0];
            cell1.model=_curDetailmodel;
            return cell1;
            
        }
        if (indexPath.section==2)
        {
            static NSString *FEFirstComentTableViewCellID=@"FEFirstComentTableViewCell";
            
            FEFirstComentTableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:FEFirstComentTableViewCellID];
            if (cell2==nil) {
                cell2=[[FEFirstComentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEFirstComentTableViewCellID];
                cell2.contentView.backgroundColor=[UIColor whiteColor];
                [cell2 setSelectionStyle:UITableViewCellSelectionStyleNone];
                
            }
            if (Comnttarray.count>0) {
                FEStoreCommentModel *curmodel=Comnttarray[0];
                
                [cell2 setupStoreCellWithModel:curmodel];
                cell2.block = ^{
                    view1.hidden=NO;
                    bgbtn1.hidden=NO;
                };
                return cell2;
            }
            else
            {
                FEStoreCommentModel *curmodel=[[FEStoreCommentModel alloc]init];
                [cell2 setupStoreCellWithModel:curmodel];
                cell2.block = ^{
                    view1.hidden=NO;
                    bgbtn1.hidden=NO;
                };
                return cell2;
                
            }
        }
        
    
    }
    if (tableView==self.tableV2)
    {
        
        DemoVC1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell)
        {
            cell = [[DemoVC1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        FEcommodityimgList *picmodel=self.dataArray2[indexPath.row];
        
        NSString *url = picmodel.commodityimgStr;

        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            /**
             *  缓存image size
             */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                
                //reload row
                if(result)  [tableView  xh_reloadRowAtIndexPath:indexPath forURL:imageURL];
                
            }];
            
        }];
        return cell;

        
    }
    
       return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView==self.tableV) {
        return 5;
        
    }
    else
    {
        return 0;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (tableView==self.tableV) {
       return 1;
        
    }
    else
    {
        return 0;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.tableV) {
        
        
        
        if (indexPath.section==0) {
            
            return [GoodsPriceAndNameCell CountHeight];
        }
        if (indexPath.section==1) {
            return 120;
            
        }
        if (indexPath.section==2) {
            return 120;
            
        }
        
        
    }
    
    if (tableView==self.tableV2) {
        

        FEcommodityimgList *picmodel=self.dataArray2[indexPath.row];

        NSString *url = picmodel.commodityimgStr;
        
        
        /**
         *  参数1:图片URL
         *  参数2:imageView 宽度
         *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
         */
        return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:MainW estimateHeight:200];
        
    }

    return 0;
    
}

-(void)gocommitClick
{
    view1.hidden=NO;
    bgbtn1.hidden=NO;
}

-(void)dissmiss
{
    view1.hidden=YES;
    bgbtn1.hidden=YES;
}

//添加购物车

-(void)btnClick:(UIButton *)btn
{
    NSString *diQu=_curDetailmodel.origin;
    
    NSString *Msg=[NSString stringWithFormat:@"该商品只支持%@地区销售，确认添加购物车？",diQu];
    
    [FENavTool showAlertRightAndCancelMsg:Msg andType:@"提示" andRightClick:^{
        
        [self addCarRequest];
        
    } andCancelClick:^{
        
    }];

}


-(void)addCarRequest
{
    NSString *str=@"020appd/cart/addGoods";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:_goodsId forKey:@"goodsId"];
    NSNumber *nunber=[NSNumber numberWithInteger:_curDetailmodel.productPrice];
    [dic setObject:nunber forKey:@"productPrice"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"total"];
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        
        [FENavTool showAlertViewByAlertMsg:@"添加成功" andType:@"提示" ];
#pragma ----通知本地购物车刷新--------
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_TOCar object:_curDetailmodel];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
}

// 收藏和取消收藏
-(void)startClick
{
    
    NSString *str=@"020appd/collection/addCollection";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:_goodsId forKey:@"goodsId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"收藏成功");
        [FENavTool showAlertViewByAlertMsg:@"收藏成功" andType:@"提示"];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
}
-(void)cancelStartClick
{
    
    NSString *str=@"020appd/collection/quxiao";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:_goodsId forKey:@"goodsId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"取消收藏");
        [FENavTool showAlertViewByAlertMsg:@"已取消收藏" andType:@"提示"];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    
}



@end
