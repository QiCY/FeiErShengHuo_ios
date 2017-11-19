//
//  FEShengViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEShengViewController.h"
#import "FEShengShiQuModel.h"
#import "FEShiViewController.h"

@interface FEShengViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *shengTabView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FEShengViewController

-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}
-(void)initView

{
    self.title=@"省";
    
    self.shengTabView=[UITableView groupTableView];
    self.shengTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.shengTabView.delegate=self;
    self.shengTabView.dataSource=self;
    self.shengTabView.sectionHeaderHeight=0.01;
    self.shengTabView.sectionFooterHeight=0.01;
    self.shengTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.shengTabView.tableHeaderView=view;
    [self.view addSubview:self.shengTabView];
}

-(void)doRequest
{
    NSString *str=@"020appd/region/showSheng";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
   
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"获取省地方份----dic--%@",dic);
        NSArray *array=[FEShengShiQuModel mj_objectArrayWithKeyValuesArray:dic[@"regions"]];
        _dataArray=[NSMutableArray arrayWithArray:array];
        [self.shengTabView reloadData];
        
        
        
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
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    
    FEShengShiQuModel *model=_dataArray[indexPath.row];
    
    cell.textLabel.text=model.provinceName;
    
    

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     FEShengShiQuModel *model=_dataArray[indexPath.row];
    FEShiViewController *vc=[[FEShiViewController alloc]init];
    vc.provinceName=model.provinceName;
    vc.number=self.number;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
