//
//  FESearchViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESearchViewController.h"
#import "FEHomeLimitBuyCell.h"

@interface FESearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *searchTabView;


@end

@implementation FESearchViewController

-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}
-(void)initView
{
    self.title=@"搜索商品";
    
    self.searchTabView=[UITableView groupTableView];
    self.searchTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.searchTabView.delegate=self;
    self.searchTabView.dataSource=self;
    //self.searchTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.searchTabView.tableHeaderView=[self headView];
    
    //断尾灰色
    self.searchTabView.sectionFooterHeight=0.01f;
    self.searchTabView.sectionHeaderHeight=0.01f;
    [self.view addSubview:self.searchTabView];
}

-(void)doRRRequest :(NSString *)goodsName
{
    NSString *str=@"020appd/shop/zhanshi";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:goodsName forKey:@"goodsName"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog( @"搜索商品的Dic--%@",dic);
        
        NSArray *array=[FEGoodModel mj_objectArrayWithKeyValuesArray:dic[@"xCommunityGoods"]];
        self.dataArray=[NSMutableArray arrayWithArray:array];
        
        
        [self.searchTabView reloadData];
        
        
    } withfialedBlock:^(NSString *msg) {
        
    }];

}

//UISearchBar作为tableview的头部
-(UIView *)headView{
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 100, 44)];
    searchBar.keyboardType = UIKeyboardAppearanceDefault;
    searchBar.placeholder = @"请输入搜索关键字";
    searchBar.delegate = self;
    //底部的颜色
    searchBar.barTintColor = [UIColor grayColor];
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    searchBar.barStyle = UIBarStyleDefault;
    return searchBar;
}
#pragma mark-searchBarDelegate

//在搜索框中修改搜索内容时，自动触发下面的方法
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"开始输入搜索内容");
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //改变取消的文本
    for(UIView *view in [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"输入搜索内容完毕");
}

//取消的响应事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"取消搜索");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"搜索");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    NSString *str=searchBar.text;
    NSLog(@"输入的是-- %@",str);
    [self doRRRequest:str];
    
    
}

////搜框中输入关键字的事件响应
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    
//    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
//    [self doRRRequest:searchText];
//    
//}

//
#pragma -------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FEHomeLimitBuyCell countSecondHotSaleHeight];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *secondCellID=@"FEHomeLimitBuyCell";
    FEHomeLimitBuyCell *cell2 = [tableView dequeueReusableCellWithIdentifier:secondCellID];
    if (cell2 == nil) {
        cell2 = [[FEHomeLimitBuyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];
        cell2.backgroundColor = [UIColor whiteColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FEGoodModel *curModel=_dataArray[indexPath.row];
    [cell2 setUpCellWithModel:curModel];
    cell2.block = ^{
        //首先判断是否登录
        FELoginInfo *info=[LoginUtil getInfoFromLocal];
        
        
        NSLog(@"是否 登录 ---info--%@",info.isLogin);
        if ([info.isLogin isEqualToString:@"0"]||[info.isLogin isEqual:nil]||[info.isLogin isKindOfClass:[NSNull class]]||[info.isLogin isEqual:[NSNull null]]||info.isLogin.length==0) {
            FELoginViewController *vc=[[FELoginViewController alloc]init];
            //vc.delegete=self;
            FEBaseNavControllerViewController *logNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:vc];
            
            [self presentViewController:logNav animated:YES completion:nil];
            return;
        }
        
        
               
        //判断小区
        if (info.villageId<=0) {
            
            //跳转健全信息页面
            // 没有的情况  去健全小区和上传信息
            FEAddinfoViewController *addinfoVC=[[FEAddinfoViewController alloc]init];
            FEBaseNavControllerViewController *addNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:addinfoVC];
            
            [self presentViewController:addNav animated:YES completion:nil];
            
            return;
        }
        

        
        FEGoodModel *curModel=_dataArray[indexPath.row];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        StoreDetialViewController *detailVC=[[StoreDetialViewController alloc]init];
        detailVC.curModel=curModel;
        
        detailVC.goodsId=curModel.goodsId;
        [self.navigationController pushViewController:detailVC animated:YES];
        NSLog(@"点击了购物车");
     };
    
    return cell2;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FEGoodModel *curModel=_dataArray[indexPath.row];
    
    
    StoreDetialViewController *detailVC=[[StoreDetialViewController alloc]init];
    detailVC.curModel=curModel;
    
    detailVC.goodsId=curModel.goodsId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
