//
//  FEIntertingDeitalWebViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEIntertingDetailModel.h"

// MOB
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import "AppDelegate.h"
#import "MobScreenshotCenter.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ShareSDK/SSDKVideoUploadCenter.h>

#import "MOBShareSDKHelper.h"


#define DAY @"day"
#define NIGHT @"night"
static CGFloat textFieldH = 40;


@interface FEIntertingDeitalWebViewController : FEBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)FEIntertingDetailModel *cuModel;

@property(nonatomic,strong)NSNumber *TopicId;

@end
