//
//  FEGroupStuesController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupStuesController.h"
#import "FEgroupedDetailModel.h"
#import "FEGroupStusHeadCollectionViewCell.h"
#import "FEGoeupedGoodCell.h"
#import "FEGroupedAddpersonCell.h"


@interface FEGroupStuesController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collections;
    UIButton *btn;
    UILabel *lab;
    
    
}
@property(nonatomic,strong)UITableView *TabView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *avterArray;

@property(nonatomic,strong)FEgroupedDetailModel *CURmodel;
@property(nonatomic,strong)FEGroupedPlayWayView *palView;

@end

@implementation FEGroupStuesController





-(void)initView
{
    
     [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(shareClick) andType:item_share];
 
    self.title=@"团购详情";
     _dataArray=[[NSMutableArray alloc]init];
    _avterArray=[[NSMutableArray alloc]init];
    self.TabView=[UITableView groupTableView];
    self.TabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.TabView.delegate=self;
    self.TabView.dataSource=self;
    self.TabView.sectionFooterHeight=0.01;
    self.TabView.sectionHeaderHeight=0.01;
    self.TabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 80);
    
   
    
   
    
    
   btn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusCenterImageLeft];
    [btn setImage:[UIImage imageNamed:@"[Details]-Circle_hook1"] forState:0];
    //[btn setTitle:tuan forState:0];
    [btn setTitleColor:Green_Color forState:0];
    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    btn.frame=CGRectMake(MainW/2-75, 20, 150, 20);
    [view addSubview:btn];
    
    lab=[MYUI createLableFrame:CGRectMake(0, 50, MainW, 20) backgroundColor:[UIColor clearColor] text:@"" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    lab.textAlignment=NSTextAlignmentCenter;
    
    [view addSubview:lab];
    
    self.TabView.tableHeaderView=view;
    [self.view addSubview:self.TabView];
}


-(void)doRequest
{
    NSString *str=@"020appd/nauriBin/showInfo";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.tunasn forKey:@"tuanSn"];
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        
        NSLog(@"图详情界面 啊啊啊 ---%@",dic);
        
        //self.dataArray
        NSArray *array=[FEgroupedDetailModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityTuans"]];
        self.dataArray=[NSMutableArray arrayWithArray:array];
        
        for (FEgroupedDetailModel * model in self.dataArray) {
            [self.avterArray addObject:model.avatar];
            
        }
        
        
        
        if ([self.model.num integerValue]>self.dataArray.count) {
            
            NSString * tuan=@"开团成功";
            NSString * sutse=@"快去邀请好友加入吧";
            [btn setTitle:tuan forState:0];
            lab.text=sutse;
            
            
        }
        if ([self.model.num integerValue]<=self.dataArray.count) {
     
            NSString * tuan=@"团购成功";
            NSString * sutse=@"我会尽快给您发货，请耐心等待";
            [btn setTitle:tuan forState:0];
            lab.text=sutse;
            
        }
        
        [collections reloadData];
    
        [self.TabView reloadData];
        
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    
}

-(void)shareClick
{
    
    
    NSMutableDictionary *shareParams = [[NSMutableDictionary alloc]init];
    NSArray* imageArray = @[[[NSBundle mainBundle] pathForResource:@"feierlife" ofType:@"png"]];
    //NSArray* imageArray=@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.thumb]]]];
    
    NSLog(@"当前分享的地址是啥啊---%@",self.url);
    
    
    [shareParams SSDKSetupShareParamsByText:self.model.title
                                     images:imageArray
                                        url:[NSURL URLWithString:self.url]
                                      title:@"菲尔生活"
                                       type:SSDKContentTypeWebPage];
    
    //优先使用平台客户端分享
    [shareParams SSDKEnableUseClientShare];
    // 分享
    NSArray *items = @[
                       
                       @(SSDKPlatformTypeWechat),
                       
                       ];
    
    //[MOBShareSDKHelper shareInstance].platforems
    
    [ShareSDK showShareActionSheet:self.view
                             items:items
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //设置UI等操作
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Instagram、Line等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeInstagram)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           NSLog(@"%@",error);
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
    
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return self.dataArray.count;
    }
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        NSInteger num=self.avterArray.count;
        
        
        NSInteger imgHangNum =num/3 + 1;
        CGFloat height=10+10+imgHangNum*80+10*(imgHangNum-1);
        return height;
        
    }
    else
    {
        return 9;
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        NSInteger num=self.avterArray.count;
        
        
        NSInteger imgHangNum =num/3 + 1;
        
        UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
        [clay setMinimumLineSpacing:10];
        CGFloat width=10;
        [clay setMinimumInteritemSpacing:width];
        clay.itemSize=CGSizeMake(80,80);
        clay.sectionInset = UIEdgeInsetsMake(10,10,10, 10);
        collections=[[UICollectionView alloc]initWithFrame:CGRectMake((MainW-80*3-10*4)/2, 0, MainW-80*3-10*4,10+10+imgHangNum*80+10*(imgHangNum-1)) collectionViewLayout:clay];
        collections.delegate = self;
        collections.dataSource = self;
        collections.scrollsToTop=NO;
        collections.scrollEnabled=NO;
        
        collections.backgroundColor = [UIColor clearColor];
        [collections registerClass:NSClassFromString(@"FEGroupStusHeadCollectionViewCell") forCellWithReuseIdentifier:@"cellectionCell"];
        return collections;
        
    }
    
    else
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 9)];
        view.backgroundColor=Colorgrayall239;
        return view;
    }
    
    return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        static NSString *FEGoeupedGoodCellCellID = @"FEGoeupedGoodCell";
        FEGoeupedGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:FEGoeupedGoodCellCellID];
        if (cell == nil) {
            cell = [[FEGoeupedGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEGoeupedGoodCellCellID];
            cell.backgroundColor =[UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        [cell setupCellWithModel:self.model];
        
        return cell;
    }
    
    if (indexPath.section==1) {
        
        static NSString *FEGroupedAddpersonCellCell = @"FEGroupedAddpersonCell";
        FEGroupedAddpersonCell *cell = [tableView dequeueReusableCellWithIdentifier:FEGroupedAddpersonCellCell];
        if (cell == nil) {
            cell = [[FEGroupedAddpersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEGroupedAddpersonCellCell];
            cell.backgroundColor =RGB(53, 53, 53);
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        FEgroupedDetailModel *curmodel=self.dataArray[indexPath.row];
        
        [cell setupCellWithModel:curmodel];
        return cell;
        
        
    }
    return nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    if (section==0) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 90)];
        view.backgroundColor=RGB(235, 233, 234);
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, MainW, 20)];
        lab.textAlignment=NSTextAlignmentCenter;
        
        if ([self.model.num integerValue]>self.dataArray.count) {
            lab.text=[NSString stringWithFormat:@"还差%ld人，盼你如南方人盼暖气",[self.model.num integerValue]-self.dataArray.count];
        }
        if ([self.model.num integerValue]<=self.dataArray.count) {
            lab.text=@"对诸位大侠的帮助,团长感激涕零!";
        }
        
        
        lab.font=[UIFont systemFontOfSize:14];
        [view addSubview:lab];
        return view;
        
    }
    if (section==1) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 130)];
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 9)];
        view1.backgroundColor=Colorgrayall239;
        [view addSubview:view1];
        
        
        //玩法
        UILabel * playWay=[MYUI createLableFrame:CGRectMake(10,20, MainW/2, 20)  backgroundColor:[UIColor clearColor] text: @"拼团玩法" textColor:RGB(85, 85, 85) font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
        [view addSubview:playWay];
        
        UILabel * playWayDeatilLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text: @"查看详情" textColor:RGB(85, 85, 85) font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
        playWayDeatilLab.textAlignment=NSTextAlignmentCenter;
        [view addSubview:playWayDeatilLab];
        
        _palView=[[FEGroupedPlayWayView alloc]init];
        
        if (self.dataArray.count==[self.model.num integerValue]) {
            UILabel *lab=[_palView viewWithTag:10086];
            lab.text=@"1.选择心仪商品";
            lab.backgroundColor=[UIColor clearColor];//RGB(162, 9, 13);
            lab.textColor=RGB(85, 85, 85);
            
            UILabel *lab2=[_palView viewWithTag:10086+3];
            lab2.text=@"4.达到人数参团成功";
            lab2.backgroundColor=RGB(162, 9, 13);
            lab2.textColor=[UIColor whiteColor];
            
            [view addSubview:_palView];
            
            UILabel * grayLineLab=[[UILabel alloc]init];
            grayLineLab.backgroundColor=Colorgrayall239;
            [view addSubview: grayLineLab];
            
            
            [playWayDeatilLab makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(playWay);
                make.width.equalTo(MainW/3);
                make.right.equalTo(view.right);
                
            }];
            _palView.frame=CGRectMake(0, CGRectGetMaxY(playWay.frame)+10, MainW, 60);

        }
        else
        {
            
            UILabel *lab=[_palView viewWithTag:10086];
            lab.text=@"1.选择心仪商品";
            lab.backgroundColor=[UIColor clearColor];//RGB(162, 9, 13);
            lab.textColor=RGB(85, 85, 85);
            
            UILabel *lab2=[_palView viewWithTag:10086+2];
            lab2.text=@"3.等待好友参团支付";
            lab2.backgroundColor=RGB(162, 9, 13);
            lab2.textColor=[UIColor whiteColor];
            
            [view addSubview:_palView];
            
            UILabel * grayLineLab=[[UILabel alloc]init];
            grayLineLab.backgroundColor=Colorgrayall239;
            [view addSubview: grayLineLab];
            
            
            [playWayDeatilLab makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(playWay);
                make.width.equalTo(MainW/3);
                make.right.equalTo(view.right);
                
            }];
            _palView.frame=CGRectMake(0, CGRectGetMaxY(playWay.frame)+10, MainW, 60);

        }
        
        
        
        return view;
        
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==1) {
        return 130;
        
    }
    if (section==0) {
        return 90;
        
    }
    return 0.01;
    
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return   self.avterArray.count;                          //[self.model.num integerValue];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FEGroupStusHeadCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellectionCell" forIndexPath:indexPath];
   
    // FEgroupedDetailModel *curmodel=_dataArray[indexPath.row];
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    
    
    for (FEgroupedDetailModel * model in self.dataArray) {
        [imageArray addObject:model.avatar];
    
    }
    
    NSString *url=self.avterArray[indexPath.item];
        [cell.headView sd_setImageWithURL:[NSURL URLWithString:url]];
        

//    else
//    {
//        cell.headView.image=[UIImage imageNamed:@"pic"];
//    }
    
    
    return cell;
}



@end
