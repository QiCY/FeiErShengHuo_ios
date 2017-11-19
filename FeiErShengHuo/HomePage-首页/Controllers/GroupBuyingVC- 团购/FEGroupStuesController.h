//
//  FEGroupStuesController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//


#import "FEBaseViewController.h"
#import "FEPersontuanModel.h"
#import "FEGroupedPlayWayView.h"
// MOB
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import "AppDelegate.h"
#import "MobScreenshotCenter.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ShareSDK/SSDKVideoUploadCenter.h>

#import "MOBShareSDKHelper.h"

@interface FEGroupStuesController : FEBaseViewController
@property(nonatomic,strong)NSString *url;

@property(nonatomic,strong)NSString *tunasn;

@property(nonatomic,strong) FEPersontuanModel *model;
@end
