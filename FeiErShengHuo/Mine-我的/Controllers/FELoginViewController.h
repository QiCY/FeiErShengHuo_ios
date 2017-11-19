//
//  FELoginViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "MianTabBarViewController.h"
// MianTabBarViewController *tabVC = [[MianTabBarViewController alloc] init];
//#import <UMSocialCore/UMSocialCore.h>


@class FELoginViewController;
@protocol refreshDelegete <NSObject>

//商品
-(void)refreshHeaddelegete:(FELoginInfo *)userinfo;

@end



//
//@interface UMSAuthInfo : NSObject
//
//@property (nonatomic, assign) UMSocialPlatformType platform;
//@property (nonatomic, strong) UMSocialUserInfoResponse *response;
//
//+ (instancetype)objectWithType:(UMSocialPlatformType)platform;
//
//@end



@interface FELoginViewController : FEBaseViewController

@property(nonatomic,weak)id<refreshDelegete> delegete;


@end
