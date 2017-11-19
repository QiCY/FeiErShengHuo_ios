//
//  FEbuyAllNowViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbuyAllNowViewController.h"
#import "FEBuyNowCell.h"
#import "YHJTextView.h"

@interface FEbuyAllNowViewController () < UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, GGActionSheetDelegate, UITextFieldDelegate >
{
    UITextField *TF1;
    UITextField *TF2;
    YHJTextView *_textView;
    UIButton *sureBtn;
    NSString *wxorderSn;
}
@property (nonatomic, strong) UITableView *buyNowtabView;
@property (nonatomic, strong) GGActionSheet *actionSheetImg;
@property (nonatomic, strong) GGActionSheet *actionSheetTitle;

@end

@implementation FEbuyAllNowViewController

- (void)initView
{
    NSLog(@"结单商品列表 ---- %@", self.dataArray);

    self.title = @"确认支付";

    // 1.注册通知

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:NOTI_REFRESH_WX object:nil];
    //监听价格
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Refresh:) name:@"BottomRefresh" object:nil];

    self.buyNowtabView = [UITableView groupTableView];
    self.buyNowtabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.buyNowtabView.delegate = self;
    self.buyNowtabView.dataSource = self;
    self.buyNowtabView.sectionFooterHeight = 0.01;
    self.buyNowtabView.sectionHeaderHeight = 0.01;
    //self.buyNowtabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.buyNowtabView.tableHeaderView = view;
    [self.view addSubview:self.buyNowtabView];
}

-(NSString * )gettotolPriceFromdataArray{
   
    
    int index1 = 0;
    int index2 = 0;
    CGFloat goodsSum = 0.00;
    for (int i=0; i<_NdataArray.count; i++) {
        index1++;
        FECarGoodsModel *goodModel=_NdataArray[i];
        
        if ([goodModel.isChose isEqualToString:@"1"]) {
            index2++;
            CGFloat product;
            int baiPrice=[goodModel.marketPrice intValue];
            CGFloat Price = baiPrice/100.0;
            NSInteger num=[goodModel.total integerValue];
            product=Price*num;
            //累计
            goodsSum = goodsSum + product;
        }
    }
    
    NSString *String  = [NSString stringWithFormat:@"%.2f",goodsSum];
    return String;
}

- (void)InfoNotificationAction:(NSNotification *)notification
{
    NSLog(@"%@", notification.userInfo);

    NSLog(@"---接收到通知---");
    // [self xiuGaiAplipay];
    NSLog(@"wx odersn---%@", wxorderSn);

    [self xiugai:wxorderSn paytype:1];
}
- (void)dealloc
{
    
    NSLog(@"移除了名称为tongzhi的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_REFRESH_WX object:nil];
}

-(void)setMoney:(NSMutableArray *)goodsModels
{

   
    
}

- (void)sureBuyNowClick
{
    if (TF1.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入姓名" andType:@"提示"];
        return;
    }
    if (TF2.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入电话" andType:@"提示"];
        return;
    }
    if (_textView.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入收获地址" andType:@"提示"];
        return;
    }

    [self.actionSheetImg showGGActionSheet];
}

- (NSMutableArray *)creatlist
{
    NSMutableArray *arrayList = [[NSMutableArray alloc] init];

    for (FEGoodModel *model in _dataArray)
    {
        NSMutableDictionary *params =@{}.mutableCopy;
        params[@"goodsId"] = model.goodsId;
        params[@"goodsNum"] = model.Gtotal;

        params[@"price"] = [NSNumber numberWithInteger:model.marketprice];

        [arrayList addObject:params];
    }
    return arrayList;
}
//
- (void)creatOderAPLY:(NSInteger)payType
{
    NSString *str = @"020appd/shop/createOrder";
    NSMutableDictionary *DDD =@{}.mutableCopy;
    NSMutableArray *array = [self creatlist];
    NSString *jasonStr = [array mj_JSONString]; //[self toJSONData:array];
    [DDD setObject:jasonStr forKey:@"goodsList"];
    [DDD setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
    [DDD setObject:TF1.text forKey:@"orderName"];
    [DDD setObject:_textView.text forKey:@"orderAdress"];
    [DDD setObject:TF2.text forKey:@"orderPhone"];

    NSLog(@"goodlistSTR-----%@", jasonStr);

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:DDD
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"支付宝预支付dic--%@", dic);
                                                     NSString *orderSn = dic[@"orderNum"];
                                                     //支付宝支付
                                                     [self doAlipayPay:orderSn];

                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}

- (void)creatOderWX:(NSInteger)payType
{
    NSString *str = @"020appd/shop/createOrder";
    NSMutableDictionary *DDD =@{}.mutableCopy;
    NSMutableArray *array = [self creatlist];
    NSString *jasonStr = [array mj_JSONString]; //[self toJSONData:array];

    [DDD setObject:jasonStr forKey:@"goodsList"];
    [DDD setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
    [DDD setObject:TF1.text forKey:@"orderName"];
    [DDD setObject:_textView.text forKey:@"orderAdress"];
    [DDD setObject:TF2.text forKey:@"orderPhone"];

    NSLog(@"goodlistSTR-----%@", jasonStr);

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:DDD
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"WX预支付dic--%@", dic);
                                                     wxorderSn = dic[@"orderNum"];

                                                     //微信支付

                                                       NSString * _price=[self gettotolPriceFromdataArray];
                                                       NSInteger F=[_price floatValue]*100;
                                                    
                                       
                                                        [MXWechatPayHandler jumpToWxPay:wxorderSn andPric:[NSString stringWithFormat:@"%ld",F] andType:@"菲儿生活"];

                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:nil];

    if ([jsonData length] && error == nil)
    {
        return jsonData;
    }
    else
    {
        return nil;
    }
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
    order.biz_content.out_trade_no = orderSn;//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m";              //超时时间设置

    //NSNumber *price=[NSNumber numberWithInteger:self.IBAIprice];
    NSString * _price=[self gettotolPriceFromdataArray];
 

    order.biz_content.total_amount =_price; //商品价格

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
                                      NSLog(@"reslut  haha = %@", resultDic);
                                      NSString *resultStatus = resultDic[@"resultStatus"];
                                      NSLog(@"stuse---- %@", resultStatus);

                                      NSInteger inter = [resultStatus integerValue];

                                      if (!(inter == 9000))
                                      {
                                          return;
                                      }

                                      // 修改支付支付订单
                                      [self xiugai:orderSn paytype:2];

                                    }];
    }
}

- (void)xiugai:(NSString *)orderSn paytype:(NSInteger)payType
{
    NSString *str = @"020appd/shop/xiugai";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:orderSn forKey:@"orderNum"];
    [dic setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"purchaseType"];
    [dic setObject:[NSNumber numberWithInteger:self.IBAIprice] forKey:@"totalPrice"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"修改支付订单状态--%@", dic);
                                                     [self.navigationController popViewControllerAnimated:YES];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic

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

#pragma mark - GGActionSheet代理方法
- (void)GGActionSheetClickWithIndex:(int)index
{
    NSLog(@"--------->点击了第%d个按钮<----------", index);
    if (index == 0)
    {
        NSLog(@"余额支付");
        // [self balancePay];
        [self balancePay:3];
    }
    if (index == 1)
    {
        NSLog(@"支付宝支付");
        [self creatOderAPLY:2];
    }
    if (index == 2)
    {
        NSLog(@"微信支付");
        [self creatOderWX:1];
    }
}

- (GGActionSheet *)actionSheetImg
{
    if (!_actionSheetImg)
    {
        _actionSheetImg = [GGActionSheet ActionSheetWithImageArray:@[ @"blance2", @"alipay233", @"wechatpay233" ] delegate:self];
        _actionSheetImg.cancelDefaultColor = [UIColor redColor];
    }
    return _actionSheetImg;
}

#pragma mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];

        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _dataArray.count;
    }
    else
    {
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 9)];
    secView.backgroundColor = [UIColor clearColor];
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    if (indexPath.section == 1)
    {
        return 80;
    }

    if (indexPath.section == 2)
    {
        return 60;
    }

    if (indexPath.section == 3)
    {
        return 120;
    }

    if (indexPath.section == 4)
    {
        return MainH - 100 - 60 * 2 - 120;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *FEBuyNowCellCellID = @"FEBuyNowCell";

        FEBuyNowCell *cell = [tableView dequeueReusableCellWithIdentifier:FEBuyNowCellCellID];
        if (cell == nil)
        {
            cell = [[FEBuyNowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEBuyNowCellCellID];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.layer.cornerRadius=5;
            cell.layer.masksToBounds=YES;
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }

        cell.goodModel = _dataArray[indexPath.row];

        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            switch (indexPath.section)
            {
                case 1:

                    TF1 = [MYUI createTextFieldFrame:CGRectMake(10, 20, MainW - 20, 40) backgroundColor:[UIColor whiteColor] placeholder:@"请输入收件人姓名" clearsOnBeginEditing:NO];
                    TF1.text = [LoginUtil getInfoFromLocal].nickName;

                    [cell addSubview:TF1];

                    break;
                case 2:
                    TF2 = [MYUI createTextFieldFrame:CGRectMake(10, 10, MainW - 20, 40) backgroundColor:[UIColor whiteColor] placeholder:@"请输入收件人电话号码" clearsOnBeginEditing:NO];
                    TF2.text = [LoginUtil getInfoFromLocal].mobile;

                    TF2.keyboardType = UIKeyboardTypeNumberPad;
                    [cell addSubview:TF2];

                    break;
                case 3:

                    _textView = [[YHJTextView alloc] initWithFrame:CGRectMake(10, 10, MainW - 20, 120)];
                    _textView.backgroundColor = [UIColor whiteColor];
                    _textView.delegate = self;
                    _textView.tag = 10087;

                    _textView.myPlaceholder = @"填写您的收获地址";
                    _textView.font = [UIFont systemFontOfSize:14];
                    _textView.myPlaceholderColor = [UIColor lightGrayColor];
                    _textView.returnKeyType = UIReturnKeyDone;
                    _textView.keyboardType = UIKeyboardTypeDefault;
                    _textView.text = [LoginUtil getInfoFromLocal].regionTitle;

                    [cell addSubview:_textView];

                    break;
                case 4:
                    sureBtn = [MYUI creatButtonFrame:CGRectMake(10, 25, MainW - 20, 40) backgroundColor:Green_Color setTitle:@"确认支付" setTitleColor:[UIColor whiteColor]];
                    [sureBtn addTarget:self action:@selector(sureBuyNowClick) forControlEvents:UIControlEventTouchUpInside];
                    sureBtn.layer.masksToBounds = YES;
                    sureBtn.layer.cornerRadius = 5;
                    [cell addSubview:sureBtn];

                    break;

                default:
                    break;
            }
        }
        return cell;
    }

    return nil;
}

- (void)balancePay:(NSInteger)payType
{
    NSString *str = @"020appd/shop/createOrder";
    NSMutableDictionary *DDD =@{}.mutableCopy;
    NSMutableArray *array = [self creatlist];
    NSString *jasonStr = [array mj_JSONString]; //[self toJSONData:array];

    [DDD setObject:jasonStr forKey:@"goodsList"];
    [DDD setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
    [DDD setObject:TF1.text forKey:@"orderName"];
    [DDD setObject:_textView.text forKey:@"orderAdress"];
    [DDD setObject:TF2.text forKey:@"orderPhone"];

    NSLog(@"goodlistSTR-----%@", jasonStr);

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:DDD
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"YUE预支付dic--%@", dic);
                                                     NSString *orderSn = dic[@"orderNum"];
                                                       
                                                     [self YUEXIUGAI:orderSn paytype:payType];

                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}

- (void)YUEXIUGAI:(NSString *)orderSn paytype:(NSInteger)payType
{
    NSString *str = @"020appd/shop/xiugai";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:orderSn forKey:@"orderNum"];
    [dic setObject:[NSNumber numberWithInteger:payType] forKey:@"payType"];
    [dic setObject:[NSNumber numberWithInt:1] forKey:@"purchaseType"];
    [dic setObject:[NSNumber numberWithInteger:self.IBAIprice] forKey:@"totalPrice"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"修改支付订单状态--%@", dic);
                                                       [FENavTool showAlertViewByAlertMsg:@"购买成功" andType:@"提示"];
                                                       
                                                       if (payType==3) {
                                                           //更新本地缓存
                                                           
                                                           FELoginInfo *info=[LoginUtil getInfoFromLocal];
                                                           NSNumber * resultBalance=dic[@"resultBalance"];
                                                           //        NSInteger resultBalanceI=[resultBalance integerValue];
                                                           info.balance=resultBalance;
                                                           [LoginUtil removeUserInfoFromlocal];
                                                           [LoginUtil saveing:info];
                                                           
                                                       }

                                                     [self.navigationController popViewControllerAnimated:YES];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}



@end
