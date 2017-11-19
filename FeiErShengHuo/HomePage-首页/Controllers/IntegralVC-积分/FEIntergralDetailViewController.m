//
//  FEIntergralDetailViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntergralDetailViewController.h"
#import "FEIntergralDeatialModel.h"
#import "FEIntergralDetailFirstCell.h"
#import "FEIntergralDetailSecondCell.h"
#import "PersonnalAddressViewController.h"

@interface FEIntergralDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FEIntergralDetailSecondCellDelegete>
{
    UIImageView *headimageView;
    
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *intergralDetailTableView;

@end

@implementation FEIntergralDetailViewController
-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}

-(void)initView
{
    self.title=@"积分详情";
    
    self.intergralDetailTableView=[UITableView groupTableView];
    self.intergralDetailTableView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.intergralDetailTableView.delegate=self;
    self.intergralDetailTableView.dataSource=self;
    self.intergralDetailTableView.sectionHeaderHeight=0.01;
    self.intergralDetailTableView.sectionFooterHeight=0.01;
    self.intergralDetailTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
//    UIView *view=[[UIView alloc]init];
//    view.frame=CGRectMake(0, 0, MainW, 150);
    
    headimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainW, 0.01)];
    //[view addSubview:headimageView];
    
    self.intergralDetailTableView.tableHeaderView=headimageView;
    [self.view addSubview:self.intergralDetailTableView];
    
}
-(void)doRequest
{
    NSString *str=@"020appd/integral/detailgo";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.integralId forKey:@"integralId"];
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@" 积分详情-----%@" ,dic);
        
        
        FEIntergralDeatialModel *model=[FEIntergralDeatialModel mj_objectWithKeyValues:dic[@"integralMall"]];
        if ([model.integralPic isEqualToString:@""]||model.integralPic.length==0) {
            
            headimageView.frame=CGRectMake(0, 0,MainW , 0.01);
            
        }else{
             [headimageView sd_setImageWithURL:[NSURL URLWithString:model.integralGoodUrl]];
        }
        
        [self.dataArray addObject:model];
        [self.intergralDetailTableView reloadData];
        
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
    
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 9)];
    secView.backgroundColor =[UIColor clearColor];
    return secView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [FEIntergralDetailFirstCell intergralCountFirstCellHeight];
        
    }
    if (indexPath.section==1) {
        return [FEIntergralDetailSecondCell intergralCountSecondCellHeight];
        
    }
    return 0;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        static NSString *FEIntergralDetailFirstCellID = @"FEIntergralDetailFirstCell";
        FEIntergralDetailFirstCell *cell1 = [tableView dequeueReusableCellWithIdentifier:FEIntergralDetailFirstCellID];
        if (cell1 == nil) {
            cell1 = [[FEIntergralDetailFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEIntergralDetailFirstCellID];
            cell1.backgroundColor =[UIColor whiteColor];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FEIntergralDeatialModel *model1=_dataArray[0];
        
        [cell1 setupFirstCellWithModel:model1];
        
        return cell1;

    }
    if (indexPath.section==1) {
        static NSString *FEIntergralDetailSecondCellID = @"FEIntergralDetailSecondCell";
        FEIntergralDetailSecondCell *cell2 = [tableView dequeueReusableCellWithIdentifier:FEIntergralDetailSecondCellID];
        if (cell2 == nil) {
            cell2 = [[FEIntergralDetailSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEIntergralDetailSecondCellID];
            cell2.backgroundColor =[UIColor whiteColor];
            cell2.delegete=self;
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FEIntergralDeatialModel *model2=_dataArray[0];
        
        [cell2 setupSecondCellWithModel:model2];

        
        return cell2;
    }
    
    return nil;
    
    
}

#pragma -----去自提信息页面-----

-(void)goDetailInfoAdress
{
    PersonnalAddressViewController * VC=[[PersonnalAddressViewController alloc]init];
    
    
    FEIntergralDeatialModel *model2=_dataArray[0];
    VC.curModel=model2;
    
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


@end
