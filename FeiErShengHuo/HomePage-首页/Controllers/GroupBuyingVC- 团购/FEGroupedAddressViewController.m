//
//  FEGroupedAddressViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupedAddressViewController.h"
#import "FEGroupedAddressInfoCell.h"
#import "FEgroupedAddressInfoSecondCell.h"
#import "YHJTextView.h"
#import "FEGroupedStausViewController.h"
#import "FEPersontuanModel.h"


@interface FEGroupedAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,GGActionSheetDelegate>
{
    UIButton *_nextBtn;
    YHJTextView *_textView;
    NSString *_tuansn;
    NSString * wxorderSn;
    
}
@property(nonatomic,strong)UITableView *addressTableView;

@end

@implementation FEGroupedAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.注册通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:NOTI_REFRESH_WX object:nil];
    

    self.title=@"收货地址";
    
    
    self.dataArray=[[NSMutableArray alloc]init];
    
    _addressTableView=[UITableView groupTableView];
    _addressTableView.frame=CGRectMake(0, 0, MainW, MainH-64);
    _addressTableView.delegate=self;
    _addressTableView.dataSource=self;
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 0.01)];
    _addressTableView.tableHeaderView=secView;
    secView.backgroundColor =[UIColor clearColor];
    _addressTableView.sectionFooterHeight=0.01;
    _addressTableView.sectionHeaderHeight=0.01;
    
    [self.view addSubview:_addressTableView];
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    
    NSArray *leftarray=@[@"手机号码",@"收件姓名",@"自提地址"];
    NSArray *rightarray=@[@"请输入手机号码",@"请输入收件姓名",@"请输入自提地址"];//@"请选择支付方式"
    NSArray *rigrtTFArray=@[info.mobile,info.nickName,info.regionTitle];
    
    [self.dataArray addObject:leftarray];
    [self.dataArray addObject:rightarray];
    [self.dataArray addObject:rigrtTFArray];
    [self.addressTableView reloadData];
    
    
}



- (void)InfoNotificationAction:(NSNotification *)notification{
    
    NSLog(@"%@",notification.userInfo);
    
    NSLog(@"---接收到通知---");
    
    //[self zhifubaoAndWX:3];
    [self xiugai:wxorderSn paytype:1];
    
    
    
}


-(void) zhifubaoAndWX:(NSInteger )payType
{
    //手机号码
    FEgroupedAddressInfoSecondCell *cell=[_addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSString *mobileStr=cell.rightTF.text;
    //姓名
    FEgroupedAddressInfoSecondCell *cell1=[_addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    NSString *nameStr=cell1.rightTF.text;
    //地址
    FEgroupedAddressInfoSecondCell *cell2=[_addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    NSString *addressStr=cell2.rightTF.text;

    
    NSString *pushId=[[NSUserDefaults standardUserDefaults]objectForKey:DeviceKey];
    
    
    FEGroupDetailModel *model=_model;
    NSString *str=@"020appd/nauriBin/jilu";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:model.tuanId forKey:@"tuanId"];
    [dic setObject:mobileStr forKey:@"mobile"];
    [dic setObject:nameStr forKey:@"userName"];
    [dic setObject:addressStr forKey:@"address"];
    [dic setObject:pushId forKey:@"pushId"];
    
    [dic setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
    
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
       
        
        NSLog(@"开团 sussess -- 字典dic --%@",dic);
        
        NSString *orderSn=dic[@"orderSn"];
        // 得到分享的URL
        self.backurl=dic[@"pay_url"];
        
        
        if (payType==1) {
            
            //更新余e
            FELoginInfo *info=[LoginUtil getInfoFromLocal];
            info.balance=dic[@"balance"] ;
            [LoginUtil removeUserInfoFromlocal];
            [LoginUtil saveing:info];
            [FENavTool showAlertViewByAlertMsg:@"余额支付" andType:@"提示"];
            //跳转  页面
            FEGroupedStausViewController *VC=[[FEGroupedStausViewController alloc]init];
            VC.model=_model;
            VC.url=self.backurl;
            [self.navigationController pushViewController:VC animated:YES];
           
            
        }
        
        if (payType==2) {
            [self doAlipayPay:orderSn];
            //支付宝
        }
        if (payType==3) {
            //weixin
            
            wxorderSn=orderSn;
            
             [MXWechatPayHandler jumpToWxPay:wxorderSn andPric:[NSString stringWithFormat:@"%ld",model.marketPrice] andType:@"菲儿生活"];

        }
        
        
    } withfialedBlock:^(NSString *msg) {
        
    }];

    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除了名称为tongzhi的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_REFRESH_WX object:nil];
    
    
}
#pragma mark - GGActionSheet代理方法
-(void)GGActionSheetClickWithIndex:(int)index{
    NSLog(@"--------->点击了第%d个按钮<----------",index);
    if (index==0) {
        NSLog(@"余额支付");
         [self zhifubaoAndWX:1];
        
        
    }
    if (index==1) {
        NSLog(@"支付宝支付");
       
        [self zhifubaoAndWX:2];
        
        
    }
    if (index==2) {
        NSLog(@"微信支付");
        [self zhifubaoAndWX:3];
        
        
    }
}


-(void)xiugai:(NSString *)orderSn paytype:(NSInteger)payType
{
    
    FEGroupDetailModel *model=_model;
    
    NSString *str=@"020appd/shop/xiugai";
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:orderSn forKey:@"orderNum"];
    [dic setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
    [dic setObject:[NSNumber numberWithInt:3] forKey:@"purchaseType"];
    [dic setObject:[NSNumber numberWithInteger:model.marketPrice] forKey:@"totalPrice"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog( @"修改支付订单状态--%@",dic);
        
                //跳转  页面
                FEGroupedStausViewController *VC=[[FEGroupedStausViewController alloc]init];
                VC.model=_model;
        
                VC.url=self.backurl;
        
                [self.navigationController pushViewController:VC animated:YES];
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    
}

- (void)doAlipayPay:(NSString *)odersn
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = APlayAPPID;
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJ2doSqhQhfccTB1OrFcmQ24ZNlf3yl2Z0B0xd1/3hju27pMwZYgYN4gtthgFoZcO0PI5bCoheB9rsJ339HKb6AZCKROueShmdkKsihlqJGd+4TxSPU1Ukw+M4y4RjbB7zenrRQWm2+6dA4NmypPKapjvCGCH80Fv+jb1puOzPkhAgMBAAECgYB6Y86kVbgG40yZfk5nLypCNy9IhGO7xI+Ew6hpyULjRYcl8ThZpSbTFcAl4Odcyf3TMwr41MOwgKfVplQMig+Gn9S0UOU672fMYAW7EUOnDm19u1HajtIjtrFgpWtqHs+d27B1ocRAknzHf3b0iA8ZM1CQYu+0k2dtDZ+FQsiDyQJBANLln4jxyq9dITciF3OB7OX286r0p4E/cZ6eP0nh2nU+6f1HJJnnVltPMQIxffVxYXnuiKO86uJJ0TOqOByu0AMCQQC/Uur9DG0GrWGdhmmMITBVcDAz8znzUCR0zHhEPx4KnraqMgO37sXNTeHDDWonk/+yq6SfUvBzGn7bRRf3ngMLAkAlin51kCT2RmutNsJZ61zSKr2BRv+yQCrng1/ctPmAOWzJiyp2wvlaU6RzsX+sezxQyidEjlJ5aY511e0bHfslAkBg0Eme0Qnehh/OQXTpduXpZgLOVvbtG5HHFKyLBFFkWFngl7xv98BaGl3ygLhF3MtYEykTgjmwVSj6NeVh5LBvAkEAi35PIfVwfpPED8THuBgw0fHwh6rS/428nscTtxH2LbPcTP8cNlP4kV10WPOuSz6CVKQM9D1raEqiCzJiTIVYBg==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = odersn;//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    
    
    CGFloat P=_model.marketPrice/100.0;
    
    
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", P]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo2017071207723277";
        
        
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            NSString * resultStatus=resultDic[@"resultStatus"];
            NSLog(@"stuse---- %@",resultStatus);
            
            NSInteger inter=[resultStatus integerValue];
            
            if (!(inter==9000)) {
                return ;
                
            }

//            // 修改支付支付订单
            [self xiugai:odersn paytype:2];
            
            
        }];
    }
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


-(GGActionSheet *)actionSheetImg{
    if (!_actionSheetImg) {
        _actionSheetImg = [GGActionSheet ActionSheetWithImageArray:@[@"blance2",@"alipay233",@"wechatpay233"] delegate:self];
        _actionSheetImg.cancelDefaultColor = [UIColor redColor];
    }
    return _actionSheetImg;
}


#pragma mark textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 5)];
    secView.backgroundColor =[UIColor clearColor];
    return secView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 100;
            break;
        case 1:
            return 50;
            break;
        case 2:
            if (indexPath.row==0) {
                return 200;
                
            }
            if (indexPath.row==1) {
                return 60;
                
            }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString * FEGroupedAddressInfoCellID = @"FEGroupedAddressInfoCell";
        
        FEGroupedAddressInfoCell *cell = [[FEGroupedAddressInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEGroupedAddressInfoCellID];
        cell.backgroundColor =[UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FEGroupDetailModel *model=_model;
        
        [cell setupCellWithModel:model];
        
        return cell;
    }
    if (indexPath.section==1) {
        
        static NSString * FEgroupedAddressInfoSecondCellID = @"FEgroupedAddressInfoSecondCell";
         FEgroupedAddressInfoSecondCell *cell = [[FEgroupedAddressInfoSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEgroupedAddressInfoSecondCellID];
        cell.backgroundColor =[UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.rightTF.tag=10086+indexPath.row;
        
        
        if (cell.rightTF.tag==10086) {
            cell.rightTF.keyboardType=UIKeyboardTypeNumberPad;
            
        }

        cell.rightTF.delegate=self;
        cell.leftLab.text=self.dataArray[0][indexPath.row];
        cell.rightTF.placeholder=self.dataArray[1][indexPath.row];
    
        cell.rightTF.text=self.dataArray[2][indexPath.row];

        
        return cell;
    }
    if (indexPath.section==2)
    {
        static NSString *cellID=@"cell1";
        UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==0) {
            _textView=[[YHJTextView alloc]initWithFrame:CGRectMake(0, 0,MainW,110)];
            _textView.backgroundColor=[UIColor whiteColor];
            _textView.delegate=self;
            _textView.myPlaceholder=@"有特殊要求请在此注明";
            _textView.font=[UIFont systemFontOfSize:14];
            _textView.myPlaceholderColor=[UIColor  lightGrayColor];
            _textView.returnKeyType= UIReturnKeyDone;
            _textView.keyboardType= UIKeyboardTypeDefault;
            [cell addSubview:_textView];
            
        }
        if (indexPath.row==1) {
            _nextBtn=[MYUI creatButtonFrame:CGRectMake(10, 10, MainW-20, 40) backgroundColor:Green_Color setTitle:@"支付开团" setTitleColor:[UIColor whiteColor]];
            _nextBtn.layer.cornerRadius=5;
            [_nextBtn addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
            
            _nextBtn.layer.masksToBounds=YES;
            _nextBtn.titleLabel.font=FontAndStyle15;
            [cell addSubview:_nextBtn];
        }
        
        return cell;
    }
    return nil;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==10086+3) {
         //[self.actionSheetImg showGGActionSheet];
    }
}


-(void)zhifu
{
    
    
    UITableViewCell *cell0=[self.addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    UITextField *TF0=[cell0 viewWithTag:10086+0];
    if (TF0.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入电话" andType:@"提示"];
        return;
    }
    UITableViewCell *cell1=[self.addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    UITextField *TF1=[cell1 viewWithTag:10086+1];
    if (TF1.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入名字" andType:@"提示"];
        return;
    }

    UITableViewCell *cell2=[self.addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    UITextField *TF2=[cell2 viewWithTag:10086+2];
    if (TF2.text.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入地址" andType:@"提示"];
        return;
    }


    [self.actionSheetImg showGGActionSheet];

}

-(void)balancePay:(NSInteger)payType
{
    //手机号码
    FEgroupedAddressInfoSecondCell *cell=[_addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSString *mobileStr=cell.rightTF.text;
    //姓名
    FEgroupedAddressInfoSecondCell *cell1=[_addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    NSString *nameStr=cell1.rightTF.text;
    //地址
    FEgroupedAddressInfoSecondCell *cell2=[_addressTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    NSString *addressStr=cell2.rightTF.text;
    
    
    FEGroupDetailModel *model=_model;
    NSString *str=@"020appd/nauriBin/jilu";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setObject:model.tuanId forKey:@"tuanId"];
    [dic setObject:mobileStr forKey:@"mobile"];
    [dic setObject:nameStr forKey:@"userName"];
    [dic setObject:addressStr forKey:@"address"];
    [dic setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
     [dic setObject:@"" forKey:@"pushId"];
    

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@"开团 sussess -- 字典dic --%@",dic);
        // 得到分享的URL
        self.backurl=dic[@"pay_url"];
        
        //更新余e
        FELoginInfo *info=[LoginUtil getInfoFromLocal];
        info.balance=dic[@"balance"] ;
          [LoginUtil removeUserInfoFromlocal];
        [LoginUtil saveing:info];
        
        //跳转  页面
        FEGroupedStausViewController *VC=[[FEGroupedStausViewController alloc]init];
        VC.model=_model;
        VC.url=self.backurl;
        [self.navigationController pushViewController:VC animated:YES];
              //通知传值
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_MONEY object:info];
        
        
    } withfialedBlock:^(NSString *msg) {
        
    }];
    
    
}


-(void)tuangou
{
    NSString *str=@"020appd/nauriBin/gerentuan";
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
        FEGroupDetailModel *curmodel =_model;
        
        
        NSLog(@"个人团购----%@",dic);
        NSMutableArray *array=[FEPersontuanModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityTuans"]];
        
        
        for (FEPersontuanModel *model in array) {
            if ([model.tuanId isEqualToNumber:curmodel.tuanId]) {
                _tuansn=model.tuanSn;
                
                NSLog(@"  团SN---%@",_tuansn);
                break;
                
            }
        }
        
    } withfialedBlock:^(NSString *msg) {
        
    }];

}

@end
