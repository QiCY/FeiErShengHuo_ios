//
//  FESmallFeiViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/26.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESmallFeiViewController.h"
#import "FESmallNoticeModel.h"
#import "FESmallListCell.h"
#import "FESmallLIstDetailViewController.h"

@interface FESmallFeiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *samllListTabView;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation FESmallFeiViewController
-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}

-(void)initView

{
    self.title=@"小菲说";
    
    self.samllListTabView=[UITableView groupTableView];
    self.samllListTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.samllListTabView.delegate=self;
    self.samllListTabView.dataSource=self;
    self.samllListTabView.sectionHeaderHeight=0.01;
    self.samllListTabView.sectionFooterHeight=0.01;
    self.samllListTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.samllListTabView.tableHeaderView=view;
    [self.view addSubview:self.samllListTabView];
}

-(void)doRequest

{
    NSString *str=@"020appd/xiaoxian/show";
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:nil withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"小菲说列表 dic---%@",dic);
        NSArray *array=[FESmallNoticeModel mj_objectArrayWithKeyValuesArray:dic[@"announcementInfos"]];
        _dataArray=[NSMutableArray arrayWithArray:array];
        [_samllListTabView reloadData];
        if (array.count > 0) {
            [RYLoadingView hideNoResultView:self.view];
            
        }else{
            
            [RYLoadingView showNoResultView:self.samllListTabView];
        }
        
        
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
    return _dataArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 1)];
    secView.backgroundColor =[UIColor clearColor];
    return secView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FESmallListCellID = @"FESmallListCell";
    FESmallListCell *cell = (FESmallListCell *)[tableView dequeueReusableCellWithIdentifier:FESmallListCellID];
    if (cell == nil) {
        cell = [[FESmallListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FESmallListCellID];
        cell.backgroundColor =[UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    FESmallNoticeModel *model=_dataArray[indexPath.section];
    [cell setupCellWithModel:model];
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FESmallNoticeModel *model=_dataArray[indexPath.section];
    FESmallLIstDetailViewController *vc=[[FESmallLIstDetailViewController alloc]init];
    vc.newsId=model.announceId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}




@end
