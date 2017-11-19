//
//  RYLoadingView.m
//  CCICPhone
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import "RYLoadingView.h"
#import "AppDelegate.h"
#import "RYImageTool.h"

#define LOGIN_LOADING_VIEW_TAG   999
#define LOGIN_LOADING_VIEW_WIDTH 160
#define LOGIN_LOADING_VIEW_HEIGHT 50

#define REQUEST_LOADING_VIEW_TAG   888
#define REQUEST_LOADING_VIEW_WIDTH 50
#define REQUEST_LOADING_VIEW_HEIGHT 50

#define LOADING_VIEW_TAG    666
#define LOADING_VIEW_WIDTH  80
#define LOADING_VIEW_HEIGHT 90

#define NORESULT_VIEW_TAG   777
#define NONET_VIEW_TAG      888

@implementation RYLoadingView

+(void)showLoginLoadingView
{
    UIView *aphView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, MainH)];
    aphView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    aphView.tag = LOGIN_LOADING_VIEW_TAG;

    UIView *plaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LOGIN_LOADING_VIEW_WIDTH, LOGIN_LOADING_VIEW_HEIGHT)];
    plaView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *cirImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    cirImg.image = [UIImage imageNamed:@"icon_loading"];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [cirImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [plaView addSubview:cirImg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 30)];
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textColor = GLOBAL_BIG_FONT_COLOR;
    label.text = @"登录中，请稍候";
    [plaView addSubview:label];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    plaView.center = CGPointMake(MainW/2, (MainH-20)/2);
    [aphView addSubview:plaView];
    [delegate.window addSubview:aphView];
}

+(void)hideLoginLodaingView
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *tgView = (UIView *)[delegate.window viewWithTag:LOGIN_LOADING_VIEW_TAG];
    if (tgView) {
        [tgView removeFromSuperview];
        tgView = nil;
    }
}

+(void)showLoadingView:(id)tagView
{
    UIView *plaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LOADING_VIEW_WIDTH, LOADING_VIEW_HEIGHT)];
    plaView.tag = LOADING_VIEW_TAG;
    plaView.backgroundColor = [UIColor clearColor];
    
    UIImageView *cirImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    cirImg.image = [UIImage imageNamed:@"icon_loading"];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [cirImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [plaView addSubview:cirImg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 30)];
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.textColor = [UIColor whiteColor];
    label.text = @"努力加载中...";
    [plaView addSubview:label];
    
    UIView *fatherView = (UIView *)tagView;
    plaView.center = CGPointMake(MainW/2, (MainH-20)/2);
    [fatherView addSubview:plaView];
}

+(void)hideLoadingView:(id)tagView
{
    UIView *fatherView = (UIView *)tagView;
    UIView *tgView = (UIView *)[fatherView viewWithTag:LOADING_VIEW_TAG];
    if (tgView) {
        [tgView removeFromSuperview];
        tgView = nil;
    }
}

+(void)showNoResultView:(UIView *)tgView
{
    UIView *ftView = (UIView *)tgView;
    UIView *plaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, tgView.frame.size.height)];
    plaView.tag = NORESULT_VIEW_TAG;
    plaView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *cirImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 168, 168)];
    cirImg.image = [UIImage imageNamed:@"picture_empty"];
    cirImg.center = CGPointMake(MainW/2, tgView.frame.size.height/2-100);
    [plaView addSubview:cirImg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = GLOBAL_LITTLE_FONT_COLOR;
    label.text = @"内容为空";
    label.center = CGPointMake(cirImg.center.x, cirImg.center.y+114);
    [plaView addSubview:label];
    
    [ftView addSubview:plaView];
}

+(void)hideNoResultView:(UIView *)tagCtl
{
    UIView *fatherView = (UIView *)tagCtl;
    UIView *tgView = (UIView *)[fatherView viewWithTag:NORESULT_VIEW_TAG];
    if (tgView) {
        [tgView removeFromSuperview];
        tgView = nil;
    }
}

+(void)showNoNetView:(id)tagOwner action:(SEL)action
{
    UIViewController *tagCtl = (UIViewController *)tagOwner;
    UIView *ftView = (UIView *)tagCtl.view;
    UIView *plaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, MainH-64)];
    plaView.tag = NONET_VIEW_TAG;
    plaView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *cirImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 168, 168)];
    cirImg.image = [UIImage imageNamed:@"picture_nonet"];
    cirImg.center = CGPointMake(MainW/2, 160);
    [plaView addSubview:cirImg];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
    label.font = [UIFont boldSystemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = GLOBAL_LITTLE_FONT_COLOR;
    label.text = @"当前网络不可用";
    label.center = CGPointMake(cirImg.center.x, cirImg.center.y+104);
    [plaView addSubview:label];
    
    UIButton *reBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reBtn.layer.borderWidth = 1;
    reBtn.layer.borderColor = UIColorFromRGBValue(0xF3F3F3).CGColor;
    [reBtn setFrame:CGRectMake(0, 0, 128, 44)];
    [reBtn addTarget:tagOwner action:action forControlEvents:UIControlEventTouchUpInside];
    [reBtn setTitle:@"重试" forState:UIControlStateNormal];
    [reBtn setTitleColor:GLOBAL_BIG_FONT_COLOR forState:UIControlStateNormal];
    reBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    reBtn.center = CGPointMake(label.center.x, label.center.y + 50);
    [plaView addSubview:reBtn];
    
    [ftView addSubview:plaView];
}

+(void)hideNoNetView:(id)tagView
{
    UIView *fatherView = (UIView *)tagView;
    UIView *tgView = (UIView *)[fatherView viewWithTag:NONET_VIEW_TAG];
    if (tgView) {
        [tgView removeFromSuperview];
        tgView = nil;
    }
}

+(void)showRequestLoadingView
{
    UIView *plaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, REQUEST_LOADING_VIEW_WIDTH, REQUEST_LOADING_VIEW_HEIGHT)];
    plaView.tag = REQUEST_LOADING_VIEW_TAG;
    plaView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    
    UIImageView *cirImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    cirImg.image = [UIImage imageNamed:@"icon_loading"];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [cirImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [plaView addSubview:cirImg];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    plaView.center = CGPointMake(MainW/2, (MainH-20)/2);
    [delegate.window addSubview:plaView];

}
+(void)hideRequestLoadingView
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIView *tgView = (UIView *)[delegate.window viewWithTag:REQUEST_LOADING_VIEW_TAG];
    if (tgView) {
        [tgView removeFromSuperview];
        tgView = nil;
    }
}

@end
