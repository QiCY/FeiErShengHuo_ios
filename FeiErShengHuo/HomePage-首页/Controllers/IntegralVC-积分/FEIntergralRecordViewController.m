//
//  FEIntergralRecordViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntergralRecordViewController.h"
#import "FERecordModel.h"
#import "FERecordCell.h"
#import "FEIntergraalRecodDetailViewController.h"

@interface FEIntergralRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *recordTabView;

@end

@implementation FEIntergralRecordViewController
-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}

-(void)initView
{
    self.title=@"兑换记录";
    self.recordTabView=[UITableView groupTableView];
    self.recordTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.recordTabView.delegate=self;
    self.recordTabView.dataSource=self;
    self.recordTabView.sectionHeaderHeight=0.01;
    self.recordTabView.sectionFooterHeight=0.01;
    self.recordTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.recordTabView.tableHeaderView=view;
    [self.view addSubview:self.recordTabView];
}

-(void)doRequest
{
    NSString *str=@"020appd/integral/showUserExchange";
    
    [RYLoadingView showRequestLoadingView];
    
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:GET withPath:str withDictionary:nil withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"兑换记录----- %@",dic);
        
        
        NSArray *array=[FERecordModel mj_objectArrayWithKeyValuesArray:dic[@"integralMalls"]];
        if (array.count > 0) {
            [RYLoadingView hideNoResultView:self.view];
            
        }else{
            
            [RYLoadingView showNoResultView:self.recordTabView];
        }

        self.dataArray=[NSMutableArray arrayWithArray:array];
        [self.recordTabView reloadData];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FERecordCellID = @"FERecordCell";
    FERecordCell *cell = [tableView dequeueReusableCellWithIdentifier:FERecordCellID];
    if (cell == nil) {
        cell = [[FERecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FERecordCellID];
        cell.backgroundColor =[UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FERecordModel *model=_dataArray[indexPath.row];
    [cell setupCellWithModel:model];
    
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FERecordModel *model=_dataArray[indexPath.row];
    FEIntergraalRecodDetailViewController *VC=[[FEIntergraalRecodDetailViewController alloc]init];
    VC.curmodel=model;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


@end
