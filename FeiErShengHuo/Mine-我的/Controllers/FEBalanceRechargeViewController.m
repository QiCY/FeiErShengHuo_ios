//
//  FEBalanceRechargeViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/3.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBalanceRechargeViewController.h"
#import "GGActionSheet.h"

@interface FEBalanceRechargeViewController () < GGActionSheetDelegate >

{
    UITextField *chargeTF;
    NSString *wxorderSn;
}
@property (nonatomic, strong) GGActionSheet *actionSheetImg;

@end

@implementation FEBalanceRechargeViewController

- (void)initView
{
    // 1.注册通知

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:NOTI_REFRESH_WX object:nil];

    self.title = @"余额充值";
    UILabel *lab = [MYUI createLableFrame:CGRectMake(10, 40, MainW - 20, 40) backgroundColor:[UIColor whiteColor] text:@" ¥" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:20] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    lab.layer.cornerRadius = 5;
    lab.layer.masksToBounds = YES;

    [self.view addSubview:lab];
    //
    chargeTF = [MYUI createTextFieldFrame:CGRectMake(30, 40, MainW - 20 - 20, 40) backgroundColor:[UIColor whiteColor] placeholder:@"请输入充值金额（元）" clearsOnBeginEditing:NO];
    chargeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:chargeTF];

    UIButton *chargeBtn = [MYUI creatButtonFrame:CGRectMake(10, 120, MainW - 20, 40) backgroundColor:Green_Color setTitle:@"余额充值" setTitleColor:[UIColor whiteColor]];
    [chargeBtn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];

    chargeBtn.layer.cornerRadius = 5;
    chargeBtn.layer.masksToBounds = YES;
    chargeBtn.titleLabel.font = FontAndStyle15;
    [self.view addSubview:chargeBtn];
}

- (void)InfoNotificationAction:(NSNotification *)notification
{
    NSLog(@"%@", notification.userInfo);

    NSLog(@"---接收到通知---");
    // [self xiuGaiAplipay];
    NSLog(@"wx odersn---%@", wxorderSn);

    [self xiugai:wxorderSn];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"移除了名称为tongzhi的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_REFRESH_WX object:nil];
}

- (void)charge
{
    [self.view endEditing:YES];
    if (chargeTF.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入金额" andType:@"提示"];
        return;
    }

    [self.actionSheetImg showGGActionSheet];
}

- (GGActionSheet *)actionSheetImg
{
    if (!_actionSheetImg)
    {
        _actionSheetImg = [GGActionSheet ActionSheetWithImageArray:@[ @"alipay233", @"wechatpay233" ] delegate:self];
        _actionSheetImg.cancelDefaultColor = [UIColor redColor];
    }
    return _actionSheetImg;
}

#pragma mark - GGActionSheet代理方法
- (void)GGActionSheetClickWithIndex:(int)index
{
    NSLog(@"--------->点击了第%d个按钮<----------", index);
    if (index == 0)
    {
        NSLog(@"支付宝支付");

        [self gotoAlipay];
    }
    if (index == 1)
    {
        NSLog(@"微信支付");
        [self gotoWXpay];
    }
}

- (void)gotoWXpay
{
    NSString *str = @"020appd/goto/alipay";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInt:[chargeTF.text intValue]*100] forKey:@"balance"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"WX余额预充值Dic--%@", dic);
                                                     wxorderSn = dic[@"orderSn"];

                                                     //微信支付

                                                       
                                                       
                                                        [MXWechatPayHandler jumpToWxPay:wxorderSn andPric:[NSString stringWithFormat:@"%d",[chargeTF.text intValue]*100] andType:@"菲儿生活"];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)gotoAlipay
{
    NSString *str = @"020appd/goto/alipay";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInt:[chargeTF.text intValue] * 100] forKey:@"balance"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"ZFB余额预充值Dic--%@", dic);
                                                     NSString *orderSn = dic[@"orderSn"];
                                                     [self doAlipayPay:orderSn];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)doAlipayPay:(NSString *)orderSn
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
    Order *order = [Order new];

    // NOTE: app_id设置
    order.app_id = appID;

    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";

    // NOTE: 参数编码格式
    order.charset = @"utf-8";

    // NOTE: 当前时间点
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];

    // NOTE: 支付版本
    order.version = @"1.0";

    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1) ? @"RSA2" : @"RSA";

    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = orderSn;//[self generateTradeNO];                    //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m";                                 //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [chargeTF.text floatValue]]; //商品价格

    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@", orderInfo);

    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner *signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1) ? rsa2PrivateKey : rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1))
    {
        signedString = [signer signString:orderInfo withRSA2:YES];
    }
    else
    {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }

    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil)
    {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo2017071207723277";

        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                                           orderInfoEncoded, signedString];

        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString
                                  fromScheme:appScheme
                                    callback:^(NSDictionary *resultDic) {
                                      NSLog(@"reslut = %@", resultDic);
                                      NSString *resultStatus = resultDic[@"resultStatus"];
                                      NSLog(@"stuse---- %@", resultStatus);

                                      NSInteger inter = [resultStatus integerValue];

                                      if (!(inter == 9000))
                                      {
                                          return;
                                      }

                                      [self xiugai:orderSn];

                                    }];
    }
}
- (void)xiugai:(NSString *)orderSn
{
    NSString *str = @"020appd/goto/chongzhi";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:orderSn forKey:@"orderSn"];
    [dic setObject:[NSNumber numberWithInt:[chargeTF.text intValue]*100] forKey:@"balance"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"更新余额充值--%@", dic);
                                                     

                                                     FELoginInfo *info = [FELoginInfo mj_objectWithKeyValues:dic[@"user"]];
                                                     info.isLogin = @"1";
                                                       
                                                       FELoginInfo *info2=[LoginUtil getInfoFromLocal];
                                                       info2.balance=info.balance;
                                                       info2.isLogin=@"1";
                                                       
                                                       [LoginUtil saveing:info2];
                                                       
                                                       [self.navigationController popViewControllerAnimated:YES];
                                                       

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
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

@end
