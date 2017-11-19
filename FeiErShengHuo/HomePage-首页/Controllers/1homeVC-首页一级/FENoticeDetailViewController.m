//
//  FENoticeDetailViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FENoticeDetailViewController.h"
#import "FENoticeModel.h"

@interface FENoticeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *titlelab;
    UILabel *markTimelab;
    UILabel *contentLab;
    
    UILabel *noticeTime;
    UILabel *noticeRange;
  
    
    
}
@property(nonatomic,strong)UITableView *noticeDetailTabView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FENoticeDetailViewController

-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}
-(void)initView
{
    self.title=@"社区公告";
   // _dataArray=[[NSMutableArray alloc]init];
    self.noticeDetailTabView=[UITableView groupTableView];
    self.noticeDetailTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.noticeDetailTabView.delegate=self;
    self.noticeDetailTabView.dataSource=self;
    self.noticeDetailTabView.sectionHeaderHeight=0.01;
    self.noticeDetailTabView.sectionFooterHeight=0.01;
    self.noticeDetailTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.noticeDetailTabView.tableHeaderView=view;
    
    [self.view addSubview:self.noticeDetailTabView];

}



-(void)doRequest
{
    NSString *str=@"020appd/annonce/message";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.announceId forKey:@"announceId"];
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"公告详情 ---%@",dic);
        FENoticeModel *model=[FENoticeModel mj_objectWithKeyValues:dic[@"announce"]];
      
        

        
        [self.dataArray addObject:model];
        [self.noticeDetailTabView reloadData];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    
    

}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 60;
        
    }
    if (indexPath.row==1)
    {
        FENoticeModel *model=_dataArray[0];
       CGFloat height=[model.annonceText  heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:MainW-20];
        return height+30;
    
    }
    if (indexPath.row==2)
    
    {
        return 100;
        
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==0)
        {
            switch (indexPath.row)
            {
                case 0:
                    // 标题
                    titlelab=[[UILabel alloc]init];
                    titlelab.font=[UIFont systemFontOfSize:15];
                    titlelab.frame=CGRectMake(10, 10, MainW-20, 20);
                    titlelab.textAlignment=NSTextAlignmentCenter;
                    
                    [cell addSubview:titlelab];
                    
                    
                    markTimelab=[[UILabel alloc]init];
                    markTimelab.font=[UIFont systemFontOfSize:15];
                    markTimelab.textAlignment=NSTextAlignmentCenter;
                    markTimelab.textColor=[UIColor colorWithHexString:@"#727272"];
                    markTimelab.frame=CGRectMake(10, 35, MainW-20, 20);
                    [cell addSubview:markTimelab];
            
                    break;
                    
                case 1:
                    contentLab=[[UILabel alloc]init];
                    contentLab.numberOfLines=0;
                    contentLab.textColor=[UIColor colorWithHexString:@"#727272"];
                    contentLab.font=[UIFont systemFontOfSize:15];
                    
                    [cell addSubview:contentLab];
                
                    break;
                    
                case 2:
                    
                    // 标题
                    noticeTime=[[UILabel alloc]init];
                    noticeTime.font=[UIFont systemFontOfSize:15];
                    noticeTime.frame=CGRectMake(10, 10, MainW-20, 20);
                    noticeTime.textAlignment=NSTextAlignmentLeft;
                    noticeTime.textColor=[UIColor colorWithHexString:@"#727272"];
                    [cell addSubview:noticeTime];
                    
                    noticeRange=[[UILabel alloc]init];
                    noticeRange.font=[UIFont systemFontOfSize:15];
                    noticeRange.textAlignment=NSTextAlignmentLeft;
                    noticeRange.frame=CGRectMake(10, CGRectGetMaxY(noticeTime.frame)+5, MainW-20, 20);
                    noticeRange.textColor=[UIColor colorWithHexString:@"#727272"];
                    [cell addSubview:noticeRange];

                    
                    break;
                    
                default:
                    break;
            }
        }
        
    }
    
    
    FENoticeModel *model=_dataArray[0];
    titlelab.text=model.annonceTitle;
    markTimelab.text=[NSString stringWithFormat:@"%@",model.startTimeStr];
    contentLab.text=model.annonceText;
    CGFloat height=[model.annonceText  heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:MainW-20];
    
    contentLab.frame=CGRectMake(10, 10, MainW-20, height);
    NSLog( @"高度------%f",height);
    
    
    noticeTime.text=[NSString stringWithFormat:@"通知时间:%@~%@",model.startTimeStr,model.endTimeStr];
    noticeRange.text=[NSString stringWithFormat:@"通知范围:%@",model.location];
    

        return cell;
}
//-(CGFloat) countheight
//{
//     FENoticeModel *model=_dataArray[0];
//     CGFloat height=[model.annonceText  heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:MainW-20];
//    
//    return height+30;
//    
//}

@end
