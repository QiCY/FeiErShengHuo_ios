//
//  FEComplainViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEComplainViewController.h"
#import "FEComplainCell.h"
#import "FEadviceModel.h"
#import "FEWriteAdviceViewController.h"
#import "FEComplianDtialViewController.h"

@interface FEComplainViewController ()<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>
{
    NSInteger curPage;
    NSInteger totNum;
    NSInteger pageSize;
    BOOL isLoadMore;
}
@property(nonatomic,strong)UITableView *FEComplainTab;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FEComplainViewController
-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
}
-(void)initView
{
    self.title=@"投诉建议";
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(rightClick) andType:item_whrite];
    // _dataArray=[[NSMutableArray alloc]init];
    self.FEComplainTab=[UITableView groupTableView];
    self.FEComplainTab.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.FEComplainTab.delegate=self;
    self.FEComplainTab.dataSource=self;
    self.FEComplainTab.sectionFooterHeight=0.01;
    self.FEComplainTab.sectionHeaderHeight=0.01;
    //self.FEComplainTab.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.FEComplainTab.tableHeaderView=view;
    [self.view addSubview:self.FEComplainTab];
//    //监听发布动态的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publishCallBack:) name:NOTI_REFRESH_ADVICE object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self ddoRequest];
    
}
//#pragma mark NOTIFICATION
//-(void)publishCallBack:(NSNotification *)noti
//{
//    [self doRequest];
//}
-(void)ddoRequest
{
    NSString *str=@"020appd/advice/showAdvice";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"投诉建议列表 ---%@",dic);
        
        NSArray *array=[FEadviceModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityAdvices"]];
        
        
        if (array.count > 0) {
            [RYLoadingView hideNoResultView:self.view];
            
        }else{
            
            [RYLoadingView showNoResultView:self.FEComplainTab];
        }
        

        
        self.dataArray=[NSMutableArray arrayWithArray:array];
        [self.FEComplainTab reloadData];
    } withfialedBlock:^(NSString *msg) {
    }];
}

-(void)rightClick
{
    FEWriteAdviceViewController *vc=[[FEWriteAdviceViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 5)];
    secView.backgroundColor =[UIColor clearColor];
    return secView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEComplainCellID = @"FEComplainCell";
    FEComplainCell *cell =[tableView dequeueReusableCellWithIdentifier:FEComplainCellID];
    if (cell == nil) {
        cell = [[FEComplainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEComplainCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.cornerRadius = 6;
        cell.layer.masksToBounds = YES;
        
        
    }
    FEadviceModel *model=_dataArray[indexPath.section];
    [cell setupCellWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEadviceModel *model=_dataArray[indexPath.section];
    FEComplianDtialViewController *VC=[[FEComplianDtialViewController alloc]init];
    VC.Model=model;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}
@end
