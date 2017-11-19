//
//  FELoginViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FELoginViewController.h"
#import "CheckConfig.h"
#import "FELoginInfo.h"
#import "FELoginView.h"
#import "LoginUtil.h"

#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

#import <MOBFoundation/MOBFoundation.h>

//
//@implementation UMSAuthInfo
//
//+ (instancetype)objectWithType:(UMSocialPlatformType)platform
//{
//    UMSAuthInfo *obj = [UMSAuthInfo new];
//    obj.platform = platform;
//    UMSocialUserInfoResponse *resp = nil;
//
//    NSDictionary *authDic = [[UMSocialDataManager defaultManager ] getAuthorUserInfoWithPlatform:platform];
//    if (authDic) {
//        resp = [[UMSocialUserInfoResponse alloc] init];
//        resp.uid = [authDic objectForKey:kUMSocialAuthUID];
//        resp.unionId = [authDic objectForKey:kUMSocialAuthUID];
//        resp.accessToken = [authDic objectForKey:kUMSocialAuthAccessToken];
//        resp.expiration = [authDic objectForKey:kUMSocialAuthExpireDate];
//        resp.refreshToken = [authDic objectForKey:kUMSocialAuthRefreshToken];
//        resp.openid = [authDic objectForKey:kUMSocialAuthOpenID];
//
//        if (platform == UMSocialPlatformType_QQ) {
//            resp.uid = [authDic objectForKey:kUMSocialAuthOpenID];
//        }
//
//        obj.response = resp;
//    }
//    return obj;
//}
//
//@end
//

@interface FELoginViewController () < UITextFieldDelegate >
{
    NSTimer *countTimer;
    NSInteger curSecondNum;
    NSString *usercode;
    NSMutableDictionary *_platforemUserInfos;
}
@property (nonatomic, strong) FELoginView *FELoginView;

@end

@implementation FELoginViewController
- (void)initView
{
    //监听发布动态的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(publishCallBack:) name:NOTI_REFRESH_ADVICE object:nil];

    _platforemUserInfos = [[NSMutableDictionary alloc] init];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化倒计时60S
    curSecondNum = 60;
    [FENavTool backOnNavigationItemWithNavItem:self.navigationItem target:self action:@selector(dobackAction)];
    self.FELoginView = [[FELoginView alloc] init];
    self.FELoginView.frame = self.view.frame;
    [self thirPartLogin];

    [self.view addSubview:self.FELoginView];
    //代理和监听
    [self setbtnTargetAndTFDelegete];
}

- (void)thirPartLogin
{
    WeakSelf;

    self.FELoginView.qBlock = ^{
      StrongSelf;
      NSLog(@"qq登录");

      [strongSelf getAuthWithUserInfoFromQQ];

    };

    self.FELoginView.wBlock = ^{
      StrongSelf;
      [strongSelf getAuthWithUserInfoFromWechat];

    };
}
- (void)getAuthWithUserInfoFromQQ
{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
        onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {

          //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
          //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
          associateHandler(user.uid, user, user);

          NSDictionary *rawDatadic = user.rawData;
          NSString *city = rawDatadic[@"city"];
          NSString *gender = rawDatadic[@"gender"];

          NSLog(@"uid=%@", user.uid);
          NSLog(@"token=%@", user.credential.token);
          // NSLog(@"token=%@",user.credential.token);
          NSLog(@"nickname=%@", user.nickname);
          NSLog(@"icon=%@", user.icon);

          NSLog(@"rawData=%@", user.rawData);

          NSLog(@"city=%@", city);
          NSLog(@"gender=%@", gender);

          NSString *str = @"020appd/qqlogin/perfect";
          NSMutableDictionary *dic = [NSMutableDictionary dictionary];
          [dic setObject:user.uid forKey:@"qqOpenId"];
          [dic setObject:user.credential.token forKey:@"qqAccessToken"];
          [dic setObject:user.nickname forKey:@"nickName"];
          [dic setObject:gender forKey:@"sex"];
          [dic setObject:user.icon forKey:@"avatar"];
          [dic setObject:city forKey:@"district"];

          [RYLoadingView showRequestLoadingView];
          [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                                 withPath:str
                                                           withDictionary:dic
                                                         withSuccessBlock:^(NSDictionary *dic) {

                                                           NSLog(@"qq登录成功");
                                                           FELoginInfo *info = [FELoginInfo mj_objectWithKeyValues:dic[@"userList"]];
                                                           info.isLogin = @"1";

                                                           // info.villageId=dic[@"villageId"];

                                                           [LoginUtil saveing:info];
                                                           [self updateID];

                                                           //这里面改成通知

                                                           [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_INFO object:info];

                                                           [self dismissViewControllerAnimated:YES completion:nil];

                                                         }
                                                          withfialedBlock:^(NSString *msg){

                                                          }];

        }
        onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {

          if (state == SSDKResponseStateSuccess)
          {
          }

        }];
}
- (void)getAuthWithUserInfoFromWechat
{
    NSLog(@"WX");
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
        onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {

          //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
          //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
          associateHandler(user.uid, user, user);
          NSDictionary *rawDatadic = user.rawData;
          NSString *city = rawDatadic[@"city"];

          NSLog(@"uid=%@", user.uid);
          NSLog(@"token=%@", user.credential.token);
          // NSLog(@"token=%@",user.credential.token);
          NSLog(@"nickname=%@", user.nickname);
          NSLog(@"icon=%@", user.icon);

          NSLog(@"rawData=%@", user.rawData);

          NSLog(@"city=%@", city);
          NSLog(@"gender=%ld", user.gender);

          NSString *str = @"020appd/weixin/userInfo";
          NSMutableDictionary *dic = [NSMutableDictionary dictionary];
          [dic setObject:user.uid forKey:@"wx_openid"];
          [dic setObject:user.credential.token forKey:@"wx_access_token"];
          [dic setObject:user.nickname forKey:@"nickName"];

          [dic setObject:user.icon forKey:@"avatar"];
          [dic setObject:city forKey:@"district"];

          [RYLoadingView showRequestLoadingView];
          [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                                 withPath:str
                                                           withDictionary:dic
                                                         withSuccessBlock:^(NSDictionary *dic) {

                                                           NSLog(@"WX登录成功--%@", dic);

                                                           FELoginInfo *info = [FELoginInfo mj_objectWithKeyValues:dic[@"user"]];

                                                           info.isLogin = @"1";
                                                           [LoginUtil saveing:info];

                                                           [self updateID];

                                                           //这里面改成通知

                                                           [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_INFO object:info];
                                                           [self dismissViewControllerAnimated:YES completion:nil];

                                                         }
                                                          withfialedBlock:^(NSString *msg){

                                                          }];

        }
        onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {

          if (state == SSDKResponseStateSuccess)
          {
          }

        }];
}

//更新设备ID
- (void)updateID
{
    //    //上传设备标识别
    NSString *registrationID = [[NSUserDefaults standardUserDefaults] objectForKey:DeviceKey];

    NSString *str = @"020appd/goto/xiugaizhuce";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:registrationID forKey:@"regionrationId"];

    [RYLoadingView showRequestLoadingView];

    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"更新设备标示Dic--%@", dic);

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)dobackAction
{
    if (countTimer)
    {
        [countTimer invalidate];
        countTimer = nil;
    }
    [self dismissViewControllerAnimated:YES
                             completion:^{

                             }];
}
- (void)textFieldDidChange:(id)sender
{
    UITextField *_field = (UITextField *)sender;
    NSString *str = _field.text;
    if (str)
    {
        [self.FELoginView.nextBtn setBackgroundColor:Green_Color];
        [self.FELoginView.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
- (void)setbtnTargetAndTFDelegete
{
    //文本框输入状态监测
    [self.FELoginView.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_FELoginView.nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [_FELoginView.getsecuritycodeBtn addTarget:self action:@selector(SendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _FELoginView.phoneTF.delegate = self;
    _FELoginView.securitycodeTF.delegate = self;
}
#pragma-- ---------------- - 获取验证码 按钮 方法————————————————————————
- (void)SendBtnClick:(UIButton *)btn

{
    NSString *phone = self.FELoginView.phoneTF.text;
    //检查手机号码正确
    if (![CheckConfig checkMobileNumber:phone])
    {
        return;
    }
    //创建一个可变字典
    NSMutableDictionary *parametersDic = @{}.mutableCopy;

    //往字典里面添加需要提交的参数
    [parametersDic setObject:self.FELoginView.phoneTF.text forKey:@"mobile"];
    NSString *str = @"020appd/goto/verifyUser";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:parametersDic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     usercode = dic[@"userCode"];

                                                     //  清空输入框开启定时器
                                                     self.FELoginView.securitycodeTF.text = @"";
                                                     [self.FELoginView.securitycodeTF becomeFirstResponder];
                                                     [self updateGetCodeBtnStatus:NO];
                                                     if (countTimer == nil)
                                                     {
                                                         countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCountNumber) userInfo:nil repeats:YES];
                                                     }

                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}
- (void)updateGetCodeBtnStatus:(BOOL)isEnable
{
    if (isEnable)
    {
        //分别设置按钮状态和风格
        _FELoginView.getsecuritycodeBtn.enabled = YES;
        [_FELoginView.getsecuritycodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        _FELoginView.getsecuritycodeBtn.enabled = NO;
    }
}
- (void)updateCountNumber
{
    curSecondNum--;
    [_FELoginView.getsecuritycodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发", curSecondNum] forState:UIControlStateNormal];
    if (curSecondNum <= 0)
    {
        NSLog(@"超过60s，可继续获取验证码");
        [self updateGetCodeBtnStatus:YES];
        curSecondNum = 60;
        if (countTimer)
        {
            [countTimer invalidate];
            countTimer = nil;
        }
    }
}

- (void)nextClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    NSString *phone = self.FELoginView.phoneTF.text;
    NSString *code = self.FELoginView.securitycodeTF.text;
    if ([CheckConfig checkMobileNumber:phone] && [CheckConfig checkVerifyCode:code])
    {
        NSMutableDictionary *parametersDic = @{}.mutableCopy; //[[NSMutableDictionary alloc]init];
        //往字典里面添加需要提交的参数
        int a = [self.FELoginView.securitycodeTF.text intValue];
        NSNumber *random = [NSNumber numberWithInt:a];

        if ([usercode isKindOfClass:[NSNull class]] || [usercode isEqual:[NSNull null]] || usercode.length == 0)
        {
            [FENavTool showAlertViewByAlertMsg:@"请重新获取验证码" andType:@"提示"];
            return;
        }
        [parametersDic setContailNilObject:self.FELoginView.phoneTF.text forKey:@"mobile"];
        [parametersDic setContailNilObject:random forKey:@"random"];
        [parametersDic setContailNilObject:usercode forKey:@"userCode"];

        NSString *str = @"020appd/goto/verifyCode";
        [RYLoadingView showRequestLoadingView];
        [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                               withPath:str
                                                         withDictionary:parametersDic
                                                       withSuccessBlock:^(NSDictionary *dic) {
                                                              [BLJSON propertyCodeWithDictionary:dic[@"userList"]];
                                                           
                                                        
                                                         //字典转模型
                                                         FELoginInfo *userLogInfo = [FELoginInfo mj_objectWithKeyValues:dic[@"userList"]];

                                                           
                                                         userLogInfo.isLogin = @"1";
                                                         // userLogInfo.villageId=dic[@"villageId"];
                                                         [LoginUtil saveing:userLogInfo];
                                                         [self updateID];
                                                           
                                                           
                                                         //通知
                                                         [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_INFO object:userLogInfo];
                                                           
                                                           
                                                           
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                         NSLog(@"用户信息-----%@", dic);
                                                           
                                                         
                                                           
                                                           
                                                       }
                                                        withfialedBlock:^(NSString *msg){
                                                        }];
    }
}

- (void)chongzai
{
    //    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    UIViewController *rootViewController1 = appdelegate.window.rootViewController;

    MianTabBarViewController *tabVC = [[MianTabBarViewController alloc] init];

    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = tabVC;
    NSLog(@"重载");
}

@end
