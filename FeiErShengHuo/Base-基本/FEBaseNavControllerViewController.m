//
//  ZJBaseNavControllerViewController.m
//  ZiJinLian
//
//  Created by lzy on 2017/3/17.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "FEBaseNavControllerViewController.h"

@interface FEBaseNavControllerViewController ()<UIGestureRecognizerDelegate>
@end
@implementation FEBaseNavControllerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_navigation_bar"] forBarMetrics:UIBarMetricsDefault];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
//公开的隐藏方法
-(void)hideNav{
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self childViewControllers].count>0) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        //左边返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 12, 18);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"Navigation_arrows"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem=leftItem;
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:YES];
}
-(void)backClick{
    
    [self popViewControllerAnimated:YES];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return !(self.childViewControllers.count==1);
}


@end
