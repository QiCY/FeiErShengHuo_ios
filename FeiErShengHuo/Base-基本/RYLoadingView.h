//
//  RYLoadingView.h
//  CCICPhone
//
//  Created by apple on 15/5/29.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSPopoverController.h"

@interface RYLoadingView : UIView
{
}

+(void)showLoginLoadingView;
+(void)hideLoginLodaingView;

+(void)showLoadingView:(id)tagView;
+(void)hideLoadingView:(id)tagView;

+(void)showNoResultView:(UIView *)tgView;
+(void)hideNoResultView:(UIView *)tagOwner;

+(void)showNoNetView:(id)tagOwner action:(SEL)action;
+(void)hideNoNetView:(id)tagView;

+(void)showRequestLoadingView;
+(void)hideRequestLoadingView;

@end
