//
//  FESecondHandDetialViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/30.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESecondHandDetialViewController.h"
#import "FESecondHandCell.h"
#import "FESecondHandDCell.h"


@interface FESecondHandDetialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *secondDTabview;


@end

@implementation FESecondHandDetialViewController

-(void)initView
{
    if ([self.shaChu isEqualToNumber:[NSNumber numberWithInt:1]]) {
        [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(shanchuClick) andType:item_shanchu];
        
    }
    
    self.secondDTabview=[UITableView groupTableView];
    self.secondDTabview.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.secondDTabview.delegate=self;
    self.secondDTabview.dataSource=self;
    self.secondDTabview.sectionFooterHeight=0.01;
    self.secondDTabview.sectionHeaderHeight=0.01;
    self.secondDTabview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    UIView*view=[[UIView alloc]init];
     view.frame=CGRectMake(0, 0, MainW, 180);
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(0, 0, MainW, 180);
    imageView.clipsToBounds=YES;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.iamgeName]];
    
    [view addSubview:imageView];
    self.secondDTabview.tableHeaderView=view;
    [self.view addSubview:self.secondDTabview];
    
    //短信
    UIButton *duanxin=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusCenterImageLeft];
    [duanxin setImage:[UIImage imageNamed:@"icon_message"] forState:0];
    [duanxin setTitle:@"短信" forState:0];
    [duanxin addTarget:self action:@selector(duanxin) forControlEvents:UIControlEventTouchUpInside];
    duanxin.titleLabel.font=[UIFont systemFontOfSize:14];
    [duanxin setTitleColor:[UIColor blackColor] forState:0];
    duanxin.frame=CGRectMake(0,MainH-64-49, MainW/2-1, 49);
    
    [self.view addSubview:duanxin];

    //电话
    UIButton *moblile=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusCenterImageLeft];
    [moblile setImage:[UIImage imageNamed:@"icon_phone"] forState:0];
    [moblile setTitle:@"电话" forState:0];
    [moblile addTarget:self action:@selector(moblie) forControlEvents:UIControlEventTouchUpInside];
    moblile.titleLabel.font=[UIFont systemFontOfSize:14];
    [moblile setTitleColor:[UIColor blackColor] forState:0];
    moblile.frame=CGRectMake(MainW/2,MainH-64-49, MainW/2, 49);
    [self.view addSubview:moblile];
}



-(void)shanchuClick
{
   
    
    NSString *str=@"020appd/ershou/shanchushangpin";
    NSDictionary *dic=@{@"secondHandId":self.secondHandId};
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog( @"删除Dic--%@",dic);
        [FENavTool showAlertViewByAlertMsg:@"删除成功" andType:@"提示"];
        [self.navigationController popViewControllerAnimated:YES];
        
        if (self.block) {
            self.block();
            
        }
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    

}

-(void)duanxin
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",self.Dmodel.mobile]];
    
    [[UIApplication sharedApplication] openURL:url];
}
-(void)moblie
{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.Dmodel.mobile];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    [self.view addSubview:callWebview];

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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 120;
        
    }
    if (indexPath.section==1) {
        return [FESecondHandCell countSecondHandCellHeightByModel:self.Dmodel];
        
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 8)];
        secView.backgroundColor =[UIColor clearColor];
        return secView;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        
        static NSString *FESecondHandDCellIndetify = @"FESecondHandDCell";
        FESecondHandDCell *cell = [tableView cellForRowAtIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:infoCellIndetify];
        if (cell == nil) {
            cell = [[FESecondHandDCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FESecondHandDCellIndetify];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FEsecondhandModel *curmodel=self.Dmodel;
        [cell setupCellWithModel:curmodel];
        return cell;

    }
    if (indexPath.section==1) {
        static NSString *FESecondHandCellIndetify = @"FESecondHandCell";
        FESecondHandCell *cell = [tableView cellForRowAtIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:infoCellIndetify];
        if (cell == nil) {
            cell = [[FESecondHandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FESecondHandCellIndetify];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.originPriceLab removeFromSuperview];
            [cell.nowPriceLab removeFromSuperview];
            [cell.phoneBtn removeFromSuperview];
            [cell.personReciveBtn removeFromSuperview];
            [cell.personReciveBtn removeFromSuperview];
            
        }
        FEsecondhandModel *curmodel=self.Dmodel;
        cell.model=curmodel;
    
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
