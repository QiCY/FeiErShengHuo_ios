//
//  PersonnalAddressViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "PersonnalAddressViewController.h"
#import "FEpersonAddressInfo.h"

@interface PersonnalAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    FELoginInfo  *info;
    
    
}
@property(nonatomic,strong)UITableView *persionalInfoTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation PersonnalAddressViewController
-(NSMutableArray *)dataArray
{
    _dataArray=[[NSMutableArray alloc]init];
    return _dataArray;
    
}

-(void)initView
{
    self.title=@"自提信息";
    self.persionalInfoTableView=[UITableView groupTableView];
    self.persionalInfoTableView.frame=CGRectMake(0, 0, MainW, MainH-64);
    self.persionalInfoTableView.delegate=self;
    self.persionalInfoTableView.dataSource=self;
    self.persionalInfoTableView.sectionHeaderHeight=0.01;
    self.persionalInfoTableView.sectionFooterHeight=0.01;
    //self.persionalInfoTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, MainW, 0.1);
    self.persionalInfoTableView.tableHeaderView=view;
    [self.view addSubview:self.persionalInfoTableView];
    
    
    _dataArray=[[NSMutableArray alloc]init];
    info=[LoginUtil getInfoFromLocal];
    [_dataArray addObject:info.nickName];
    [_dataArray addObject:info.mobile];
    //地址
    [_dataArray addObject:@""];
    
    [self.persionalInfoTableView reloadData];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 3;
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
        return 80;
        
    }
    if (indexPath.section==1) {
        return 80;
        
    }
    if (indexPath.section==2) {
        return 150;
        
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //FEpersonAddressInfo
    static NSString *cellIdentifier = @"cell";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.tag=indexPath.section+10086;
        //        cell.InfoTF.delegate=self;
        //        cell.InfoTF.tag=indexPath.section+10086;
        NSArray *array=@[@"请输入姓名",@"请输入手机号码", @"请输入收获地址"];
        if (indexPath.section==0) {
            self.TF=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor clearColor] secureTextEntry:NO placeholder:@"" clearsOnBeginEditing:YES];
            [self.TF FEInputTextFieldStyle];
            self.TF.textAlignment=NSTextAlignmentLeft;
            self.TF.backgroundColor=[UIColor whiteColor];
            self.TF.layer.masksToBounds=YES;
            self.TF.layer.cornerRadius=5;
            self.TF.text=_dataArray[0];
            self.TF.placeholder=array[0];
            self.TF.tag=10086+indexPath.section;
            
            
            self.TF.clearButtonMode=UITextFieldViewModeWhileEditing;
            self.TF.frame=CGRectMake(10, 20, MainW-20, 40);
            [cell addSubview:self.TF];
            
        }
        if (indexPath.section==1) {
            self.TF1=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor clearColor] secureTextEntry:NO placeholder:@"" clearsOnBeginEditing:YES];
            [self.TF1 FEInputTextFieldStyle];
            self.TF1.textAlignment=NSTextAlignmentLeft;
            self.TF1.backgroundColor=[UIColor whiteColor];
            self.TF1.layer.masksToBounds=YES;
            self.TF1.layer.cornerRadius=5;
            self.TF1.text=_dataArray[1];
            self.TF1.placeholder=array[1];
            self.TF1.tag=10086+indexPath.section;
            
            
            self.TF1.clearButtonMode=UITextFieldViewModeWhileEditing;
            self.TF1.frame=CGRectMake(10, 20, MainW-20, 40);
            [cell addSubview:self.TF1];
            
        }
        if (indexPath.section==2) {
            self.TF2=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor clearColor] secureTextEntry:NO placeholder:@"" clearsOnBeginEditing:YES];
            [self.TF2 FEInputTextFieldStyle];
            self.TF2.textAlignment=NSTextAlignmentLeft;
            self.TF2.backgroundColor=[UIColor whiteColor];
            self.TF2.layer.masksToBounds=YES;
            self.TF2.layer.cornerRadius=5;
            self.TF2.text=_dataArray[2];
            
            self.TF2.placeholder=array[2];
            self.TF2.tag=10086+indexPath.section;
            
            self.TF2.clearButtonMode=UITextFieldViewModeWhileEditing;
            self.TF2.frame=CGRectMake(10, 20, MainW-20, 40);
            [cell addSubview:self.TF2];
            
            
            UIButton *exchangeBtn=[MYUI creatButtonFrame:CGRectMake(10, 80, MainW-20, 40) backgroundColor:Green_Color setTitle:@"马上兑换" setTitleColor:[UIColor whiteColor]];
            [exchangeBtn addTarget:self action:@selector(goDetailClick) forControlEvents:UIControlEventTouchUpInside];
            exchangeBtn.layer.masksToBounds=YES;
            exchangeBtn.layer.cornerRadius=5;
            [cell addSubview:exchangeBtn];
        }
        
    }
    
    return cell;
    
    
    
}
//兑换请求
-(void)goDetailClick
{
    
    if (_TF.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入姓名" andType:@"提示"];
        return;
        
        
    }
    if (_TF1.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入电话" andType:@"提示"];
        return;
        
    }
    
    if (_TF2.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入收获地址" andType:@"提示"];
        return;
      }
    
    
    NSLog(@"点击了兑换");
    //
    NSString *str=@"020appd/integral/updateIntegralInfo";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:_curModel.integralId forKey:@"integralId"];
    [dic setObject:_TF2.text forKey:@"integralAddress"];
    [dic setObject:_curModel.integralCredit forKey:@"integralCredit"];
    [dic setObject:_curModel.status forKey:@"status"];
    [dic setObject:_TF.text forKey:@"nickName"];
    [dic setObject:_TF1.text forKey:@"mobile"];
    [dic setObject:_curModel.endTimeStr forKey:@"endTimeStr"];
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        
        [FENavTool showAlertViewByAlertMsg:@"兑换成功"andType:@"提示"];
        FELoginInfo *loginfo=[LoginUtil getInfoFromLocal];
        loginfo.integral=(NSNumber *)dic[@"resultCredit"];
        [LoginUtil saveing:loginfo];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[FEIntergralViewController class]]) {
                 [self.navigationController popToViewController:controller animated:YES];
                 break;
            }
           
            
        }
        
        
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
}


#pragma mark textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length <= 0) {
        //恢复原来内容
        // [self updateTextFielData];
        FELoginInfo  *info=[LoginUtil getInfoFromLocal];
        NSLog(@"tf索引导--- %ld",textField.tag);
        
        textField.text=_dataArray[textField.tag-10086];
    }
}



@end
