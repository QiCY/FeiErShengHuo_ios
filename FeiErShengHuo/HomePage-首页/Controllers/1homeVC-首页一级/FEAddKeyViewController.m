//
//  FEAddKeyViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//
#import "FEAddKeyViewController.h"
@interface FEAddKeyViewController ()
{
    UITextField *AddKeyTF;
    UITextField *phoneTF;
}
@end
@implementation FEAddKeyViewController
- (void)initView
{
    UILabel *lab = [MYUI createLableFrame:CGRectMake(10, 40, MainW - 20, 40) backgroundColor:[UIColor whiteColor] text:@" 姓名" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    lab.layer.cornerRadius = 5;
    lab.layer.masksToBounds = YES;
    [self.view addSubview:lab];
    UILabel *lab2 = [MYUI createLableFrame:CGRectMake(10, 100, MainW - 20, 40) backgroundColor:[UIColor whiteColor] text:@" 手机" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    lab2.layer.cornerRadius = 5;
    lab2.layer.masksToBounds = YES;
    [self.view addSubview:lab2];
    FELoginInfo *info = [LoginUtil getInfoFromLocal];
    //
    AddKeyTF = [MYUI createTextFieldFrame:CGRectMake(60, 40, MainW - 70, 40) backgroundColor:[UIColor whiteColor] placeholder:@"请输入真实姓名" clearsOnBeginEditing:NO];
    //AddKeyTF.keyboardType=UIKeyboardTypeNumberPad;
    AddKeyTF.text = info.strueName;
    [self.view addSubview:AddKeyTF];
    phoneTF = [MYUI createTextFieldFrame:CGRectMake(60, 100, MainW - 70, 40) backgroundColor:[UIColor whiteColor] placeholder:@"请输入电话号码" clearsOnBeginEditing:NO];
    phoneTF.text = info.mobile;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneTF];
    UIButton *chargeBtn = [MYUI creatButtonFrame:CGRectMake(10, 160, MainW - 20, 40) backgroundColor:Green_Color setTitle:@"去申请" setTitleColor:[UIColor whiteColor]];
    [chargeBtn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    chargeBtn.layer.cornerRadius = 5;
    chargeBtn.layer.masksToBounds = YES;
    chargeBtn.titleLabel.font = FontAndStyle15;
    [self.view addSubview:chargeBtn];
    //
    UILabel *textlab1 = [MYUI createLableFrame:CGRectMake(10, CGRectGetMaxY(chargeBtn.frame) + 40, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:@"申请钥匙说明" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    textlab1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textlab1];
    //
    UILabel *textlab2 = [MYUI createLableFrame:CGRectMake(10, CGRectGetMaxY(textlab1.frame) + 8, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:@"1.提交申请后，请及时提醒你的管理员进行审核！" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    textlab2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textlab2];
    //
    UILabel *textlab3 = [MYUI createLableFrame:CGRectMake(10, CGRectGetMaxY(textlab2.frame) + 8, MainW - 20, 20) backgroundColor:[UIColor clearColor] text:@"2.如果管理员为您发放新的钥匙，会有短信提醒！" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    textlab3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textlab3];
}
- (void)charge
{
    //FELoginInfo *info=[LoginUtil getInfoFromLocal];
    if (AddKeyTF.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入姓名" andType:@"提示"];
        return;
    }
    if (phoneTF.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入电话号码" andType:@"提示"];
        return;
    }
    NSString *str = @"020appd/auth/jianquan";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:phoneTF.text forKey:@"mobile"];
    [dic setObject:AddKeyTF.text forKey:@"username"];
    // [dic setObject:info.userId forKey:@"userId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"申请成功Dic--%@", dic);
                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}
@end
