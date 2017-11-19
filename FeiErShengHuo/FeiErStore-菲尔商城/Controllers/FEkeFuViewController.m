//
//  FEkeFuViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/17.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEkeFuViewController.h"

@interface FEkeFuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *kefuTab;
@property(nonatomic,strong)NSMutableArray *nameArray;

@end

@implementation FEkeFuViewController

-(NSMutableArray *)nameArray
{
    if (_nameArray==nil) {
        _nameArray=[[NSMutableArray alloc]init];
    
    }
    return _nameArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"客服中心";
    
    
    // Do any additional setup after loading the view.
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image=[UIImage imageNamed:@"service_centerbg3"];
    [self.view addSubview:imageView];
    
    _kefuTab=[UITableView groupTableView];
    _kefuTab.frame=CGRectMake(0, MainH/2, MainW, MainH/2);
    _kefuTab.delegate=self;
    _kefuTab.dataSource=self;
    _kefuTab.sectionFooterHeight=0.01;
    _kefuTab.sectionHeaderHeight=0.01;
    _kefuTab.scrollEnabled = NO;
    _kefuTab.backgroundColor=[UIColor clearColor];
    
    
    [self.view addSubview:self.kefuTab];
    
    [self nameArray];
    [self.nameArray addObject:@"18020131385"];
    [self.nameArray addObject:@"18012982739"];
    [self.nameArray addObject:@"18061670283"];
    [self.nameArray addObject:@"025-83315833"];
    [self.kefuTab reloadData];
    

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _dataArray.count;
    return self.nameArray.count;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 5;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 5)];
//    secView.backgroundColor = [UIColor clearColor];
//    return secView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    FEDynamicModel *curModel = _dataArray[indexPath.section];
    //    CGFloat hgnum = [FEDynamicStateCell countCellHeightByModel:curModel isContainComment:YES];
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FENoticeCellID = @"FENoticeCell";
    FEKefuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FENoticeCellID];
    if (cell == nil)
    {
        cell = [[FEKefuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FENoticeCellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.cornerRadius = 6;
        cell.layer.masksToBounds = YES;
    }
   
    cell.nameLab.text=[NSString stringWithFormat:@"小菲客服0%ld",indexPath.row+1];
    cell.phonelab.text=self.nameArray[indexPath.row];
    //cell.imageView.image=[UIImage imageNamed:@"servicec_phone3"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self moblie:indexPath.row];
    
}


-(void)moblie:(NSInteger )index
{
    NSString *phone=self.nameArray[index];
    
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    [self.view addSubview:callWebview];
    
}




@end
