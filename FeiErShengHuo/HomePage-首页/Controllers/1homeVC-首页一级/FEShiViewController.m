//
//  FEShiViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEShiViewController.h"
#import "FEShengShiQuModel.h"
#import "FEAreaViewController.h"

@interface FEShiViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *shiTabView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FEShiViewController

-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}
-(void)initView

{
    self.title=@"市";
    
    self.shiTabView=[UITableView groupTableView];
    self.shiTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.shiTabView.delegate=self;
    self.shiTabView.dataSource=self;
    self.shiTabView.sectionHeaderHeight=0.01;
    self.shiTabView.sectionFooterHeight=0.01;
    self.shiTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    self.shiTabView.tableHeaderView=[self headView];
    [self.view addSubview:self.shiTabView];
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
    [self doRRequest];
    
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
    [self doRequest:str];
    
    
}

////搜框中输入关键字的事件响应
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//
//    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
//    [self doRRRequest:searchText];
//
//}

//


-(void)doRequest:(NSString *)name
{
    NSString *str=@"020appd/region/findCity";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.provinceName forKey:@"provinceName"];
    [dic setObject:name forKey:@"fuzzySearch"];
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"获取市----dic--%@",dic);
        NSArray *array=[FEShengShiQuModel mj_objectArrayWithKeyValuesArray:dic[@"regions"]];
        _dataArray=[NSMutableArray arrayWithArray:array];
        [self.shiTabView reloadData];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self doRRequest];
    
}

-(void)doRRequest
{
    NSString *str=@"020appd/region/findCity";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.provinceName forKey:@"provinceName"];
    [dic setObject:@"null" forKey:@"fuzzySearch"];
    
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"获取市----dic--%@",dic);
        NSArray *array=[FEShengShiQuModel mj_objectArrayWithKeyValuesArray:dic[@"regions"]];
        _dataArray=[NSMutableArray arrayWithArray:array];
        [self.shiTabView reloadData];
        
        
        
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
    
    cell.textLabel.text=model.cityName;
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     FEShengShiQuModel *model=_dataArray[indexPath.row];
    FEAreaViewController *VC=[[FEAreaViewController alloc]init];
    VC.cityName=model.cityName;
    VC.number=self.number;
    
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


@end
