//
//  AppDelegate.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "AppDelegate.h"
#import "MianTabBarViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件                                                                                                                                                                                                                                                                                                                                          
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
//微信SDK头文件

#import "MDManager.h"
#import "WXApi.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <CocoaLumberjack/DDTTYLogger.h>

// BMKGeneralDelegate


@interface AppDelegate () <BMKGeneralDelegate,JPUSHRegisterDelegate, WXApiDelegate >
{
    BMKMapManager *mapManager;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    //初始化。BroadLinkHelper
    [BroadLinkHelper sharedBroadLinkHelper];

    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
  
    application.applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
//#ifdef __IPHONE_8_0
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories   UIUserNotificationTypeBadge
//        [JPUSHService registerForRemoteNotificationTypes:(
//                                                          UIUserNotificationTypeSound |UIUserNotificationTypeAlert)
//                                              categories:nil];
//        [JPUSHService setBadge:0];
//        application.applicationIconBadgeNumber = 0;
//    } else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//        [JPUSHService setBadge:0];
//        application.applicationIconBadgeNumber = 0;
//    }
//    
//#endif
    
    

    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPushAppKey
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:advertisingId];

    //
    mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:BAIDU_APPKEY generalDelegate:self];
    if (!ret)
    {
        NSLog(@"启动百度地图管理失败!");
    }

    [self setMob];
    [self setMD];

    MianTabBarViewController *tabVC = [[MianTabBarViewController alloc] init];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];

#pragma-- --键盘相关-- -- -
    //关闭设置为NO, 默认值为NO.
    [IQKeyboardManager sharedManager].enable = YES;

    //如果产品需要当键盘弹起时，点击背景收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //而当产品需要支持内联编辑(Inline Editing), 这就需要隐藏键盘上的工具条(默认打开)
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    //极光监听通知
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];

    [defaultCenter addObserver:self

                      selector:@selector(networkDidLogin:)

                          name:kJPFNetworkDidLoginNotification

                        object:nil];

    //
    //向微信注册wxd930ea5d5a258f4f
    // [WXApi registerApp:WXAppID withDescription:@"一只帅B程序员"];
    [WXApi registerApp:WXAppID];

    return YES;
}

- (void)networkDidLogin:(NSNotification *)notification
{
    if ([JPUSHService registrationID])
    {
        NSLog(@"get------- RegistrationID:%@", [JPUSHService registrationID]); //获取registrationID

        [[NSUserDefaults standardUserDefaults] setObject:[JPUSHService registrationID] forKey:DeviceKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

        //        FEE *E=[FEE getRegistrationID];
        //        E.RegistrationID=[JPUSHService registrationID];
    }
}

- (void)setMD
{
    [[MDManager sharedManager] setAppKey:MD_app_Key];
}

- (void)setMob
{
    [ShareSDK registerActivePlatforms:@[ @(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ) ]
        onImport:^(SSDKPlatformType platformType) {

          switch (platformType)
          {
              case SSDKPlatformTypeWechat:
                  //[ShareSDKConnector connectWeChat:[WXApi class]];
                  [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                  break;
              case SSDKPlatformTypeQQ:
                  [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                  break;
              default:
                  break;
          }
        }
        onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {

          switch (platformType)
          {
              case SSDKPlatformTypeWechat:
                  [appInfo SSDKSetupWeChatByAppId:@"wxeefc0b60f30d5364"
                                        appSecret:@"392ade7b18b9013e1555790a92f488f3"];
                  break;
              case SSDKPlatformTypeQQ:
                  [appInfo SSDKSetupQQByAppId:QQAppID
                                       appKey:QQAPPKEY
                                     authType:SSDKAuthTypeBoth];
                  break;

              default:
                  break;
          }
        }];
}


-(void)setDDLOG
{
   
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

//
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary< UIApplicationOpenURLOptionsKey, id > *)options
{
    NSLog(@"handleOpenURL openURL %@", url);

    if ([url.host isEqualToString:@"safepay"])
    {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                    NSLog(@"result = %@", resultDic);
                                                  }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                           NSLog(@"result = %@", resultDic);
                                           // 解析 auth code
                                           NSString *result = resultDic[@"result"];
                                           NSString *authCode = nil;
                                           if (result.length > 0)
                                           {
                                               NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                               for (NSString *subResult in resultArr)
                                               {
                                                   if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="])
                                                   {
                                                       authCode = [subResult substringFromIndex:10];
                                                       break;
                                                   }
                                               }
                                           }
                                           NSLog(@"授权结果 authCode = %@", authCode ?: @"");
                                         }];
    }

    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];

    return YES;
};

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"哈哈哈哈哈哈哈哈");

    if ([url.host isEqualToString:@"safepay"])
    {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                    NSLog(@"result = %@", resultDic);
                                                  }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                           NSLog(@"result = %@", resultDic);
                                           // 解析 auth code
                                           NSString *result = resultDic[@"result"];
                                           NSString *authCode = nil;
                                           if (result.length > 0)
                                           {
                                               NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                               for (NSString *subResult in resultArr)
                                               {
                                                   if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="])
                                                   {
                                                       authCode = [subResult substringFromIndex:10];
                                                       break;
                                                   }
                                               }
                                           }
                                           NSLog(@"授权结果 authCode = %@", authCode ?: @"");
                                         }];
    }

    //NSLog(@"application handleOpenURL %@",url);
    return YES;
}
//PUSH

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark - JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
    // Required
    NSDictionary *userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置

    NSLog(@"尼玛的推送消息呢===%@", userInfo);
    // 取得 APNs 标准信息内容，如果没需要可以不取
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容

    NSLog(@"xxxxx 消息消息。————————%@", content);

    if ([content isEqualToString:@"您的用户审核已通过"])
    {
        FELoginInfo *info = [LoginUtil getInfoFromLocal];
        info.isValidate = [NSNumber numberWithInt:1];
        [LoginUtil saveing:info];
    }
    
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    //[application setApplicationIconBadgeNumber:0];//小红点清0操作
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    // Required
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(); // 系统要求执行这个方法

    NSLog(@"////////推送的消息1-- %@", userInfo);
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    //[application setApplicationIconBadgeNumber:0];//小红点清0操作
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"////////推送的消息2-- %@", userInfo);
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    [application setApplicationIconBadgeNumber:0];//小红点清0操作

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    [application setApplicationIconBadgeNumber:0];//小红点清0操作
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"////////推送的消息3-- %@", userInfo);

    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
    [application setApplicationIconBadgeNumber:0];//小红点清0操作
    
}

//

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
