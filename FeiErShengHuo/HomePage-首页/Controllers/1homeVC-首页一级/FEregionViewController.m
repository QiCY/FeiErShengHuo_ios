//
//  FEregionViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEregionViewController.h"
#import "FERegionModel.h"

@interface FEregionViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *regionTabView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FEregionViewController

-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}
-(void)initView

{
    self.title=@"小区";
    
    self.regionTabView=[UITableView groupTableView];
    self.regionTabView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.regionTabView.delegate=self;
    self.regionTabView.dataSource=self;
    self.regionTabView.sectionHeaderHeight=0.01;
    self.regionTabView.sectionFooterHeight=0.01;
    self.regionTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
   
    self.regionTabView.tableHeaderView=[self headView];
    [self.view addSubview:self.regionTabView];
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
    [self doRRequest];
    
}

//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"搜索");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    NSString *str=searchBar.text;
    NSLog(@"输入的是-- %@",str);
    [self doRRequest:str];
    
    
}

////搜框中输入关键字的事件响应
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//
//    NSLog(@"输入的关键字是---%@---%lu",searchText,(unsigned long)searchText.length);
//    [self doRRRequest:searchText];
//
//}

//
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self doRRequest];
    
}


-(void)doRRequest
{
    NSString *str=@"020appd/region/showCommunity";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.cityCode forKey:@"cityCode"];
     [dic setObject:@"null" forKey:@"fuzzySearch"];
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"获取小区区----dic--%@",dic);
        NSArray *array=[FERegionModel mj_objectArrayWithKeyValuesArray:dic[@"regionInfos"]];
        
        _dataArray=[NSMutableArray arrayWithArray:array];
        [self.regionTabView reloadData];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    
    
}

-(void)doRRequest:(NSString *)name
{
    NSString *str=@"020appd/region/showCommunity";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:self.cityCode forKey:@"cityCode"];
    [dic setObject:name forKey:@"fuzzySearch"];
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"获取小区区----dic--%@",dic);
        NSArray *array=[FERegionModel mj_objectArrayWithKeyValuesArray:dic[@"regionInfos"]];
        
        _dataArray=[NSMutableArray arrayWithArray:array];
        [self.regionTabView reloadData];
        
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
    FERegionModel *model=_dataArray[indexPath.row];
    cell.textLabel.text=model.regionTitle;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FERegionModel *model=_dataArray[indexPath.row];
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    info.regionTitle=model.regionTitle;
    info.villageId=model.regionId;
    //[LoginUtil saveing:info];
    
    
       //上传小区
//    
//        NSString *str=@"020appd/region/updateUser";
//        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//        [dic setObject:model.regionId forKey:@"regionId"];
//    
//        [RYLoadingView showRequestLoadingView];
//        [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
//            NSLog(@"上传小区成功");
//    
//    
//        } withfialedBlock:^(NSString *msg) {
//            
//        }];
//        

    
    NSLog(@"--- 第几次健全--%@",self.number);
    

           [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_REGION object:info];
    
    if ([self.number isEqualToNumber:[NSNumber numberWithInt:1]]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
    
    if ([self.number isEqualToNumber:[NSNumber numberWithInt:2]]) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[FESecondAddInfoViewController class]]) {
                FESecondAddInfoViewController *A =(FESecondAddInfoViewController *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
          
            
        }
    
    }
    
}




@end
