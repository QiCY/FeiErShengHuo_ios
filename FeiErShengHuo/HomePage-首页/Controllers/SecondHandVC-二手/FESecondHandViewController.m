//
//  FESecondHandViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/29.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESecondHandViewController.h"
#import "FEsecondhandModel.h"
#import "FESecondHandCell.h"
#import "FEpublishSecondHViewController.h"
#import "FESecondHandDetialViewController.h"

@interface FESecondHandViewController ()<UITableViewDelegate,UITableViewDataSource,FESecondHandCellDelegate>
{
    NSString *imageStr;
    
    
}
@property(nonatomic,strong)NSMutableArray *dataAray;
@property(nonatomic,strong)UITableView *secondhandTab;

@end

@implementation FESecondHandViewController

-(void)initView
{
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(gopublishClick) andType:item_whrite];
    //监听发布动态的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publishSeconHandBack:) name:NOTI_REFRESH_DYNAMIC_SECONDHAND object:nil];
    
    _dataAray=[[NSMutableArray alloc]init];
    
    if ([self.shaChu isEqualToNumber:[NSNumber numberWithInt:1]]) {
       
        self.title=@"我的闲置";
    }
    else{
         self.title=@"邻里闲置";
    }
    
    
    self.secondhandTab=[UITableView groupTableView];
    self.secondhandTab.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.secondhandTab.delegate=self;
    self.secondhandTab.dataSource=self;
    self.secondhandTab.sectionFooterHeight=0.01;
    self.secondhandTab.sectionHeaderHeight=0.01;
    self.secondhandTab.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.secondhandTab.tableHeaderView=view;
    [self.view addSubview:self.secondhandTab];
    
}

-(void)gopublishClick
{
    FEpublishSecondHViewController *vc=[[FEpublishSecondHViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)publishSeconHandBack:(NSNotification *)info
{
    if ([_shaChu isEqualToNumber:[NSNumber numberWithInt:1]]) {
        self.personalFlag=[NSNumber numberWithInt:1];
        [self doRequest];
    }else{
        self.personalFlag=[NSNumber numberWithInt:0];
        [self doRequest];
    }

}



-(void)doRequest
{
    NSString *str=@"020appd/ershou/show";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.personalFlag forKey:@"personalFlag"];
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"闲置的列表--- %@",dic);
        NSArray *array=[FEsecondhandModel mj_objectArrayWithKeyValuesArray:dic[@"secondHandMarkets"]];
        if (array.count > 0) {
            [RYLoadingView hideNoResultView:self.view];
            
        }else{
            
            [RYLoadingView showNoResultView:self.secondhandTab];
        }
        
        imageStr=dic[@"pictureThumb"];

        _dataAray=[NSMutableArray arrayWithArray:array];
        [_secondhandTab reloadData];
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
    return self.dataAray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 8)];
    secView.backgroundColor =[UIColor clearColor];
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEsecondhandModel *curmodel=_dataAray[indexPath.section];
    CGFloat hgnum = [FESecondHandCell countSecondHandCellHeightByModel:curmodel];
    return hgnum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FESecondHandCellIndetify = @"FESecondHandCell";
    FESecondHandCell *cell = [tableView cellForRowAtIndexPath:indexPath];//[tableView dequeueReusableCellWithIdentifier:infoCellIndetify];
    if (cell == nil) {
        cell = [[FESecondHandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FESecondHandCellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        
    }
    FEsecondhandModel *curmodel=_dataAray[indexPath.section];
    cell.model=curmodel;
    WeakSelf;
    cell.block = ^(NSString *moblie) {
        [FENavTool view:weakSelf phoneWithMoble:moblie];
        
    };
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     FEsecondhandModel *curmodel=_dataAray[indexPath.section];
    FESecondHandDetialViewController *VC=[[FESecondHandDetialViewController alloc]init];
    VC.Dmodel=curmodel;
    VC.iamgeName=imageStr;
    VC.shaChu=self.shaChu;
    
    VC.secondHandId=curmodel.secondHandId;
    VC.block = ^{
        
        self.personalFlag=[NSNumber numberWithInt:1];
        [self doRequest];
        
    };
    
    
    [self.navigationController pushViewController:VC animated:NO];
    
}
-(void)doShowImgAction:(NSMutableArray *)tgImgArr andIndex:(NSInteger)idx
{
    RYImagePreViewController *previewController = [[RYImagePreViewController alloc] initWithImg:tgImgArr andIsPush:NO andIndex:idx];
    FEBaseNavControllerViewController *navCtl = [[FEBaseNavControllerViewController alloc] initWithRootViewController:previewController];
    [self presentViewController:navCtl animated:YES completion:nil];
}


@end
