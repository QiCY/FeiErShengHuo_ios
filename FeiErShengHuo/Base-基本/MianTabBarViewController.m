//
//  TabBarViewController.m
//  yun
//
//  Created by xjm on 15/8/27.
//  Copyright (c) 2015年 yunzu. All rights reserved.
//

#import "MianTabBarViewController.h"
#import "FEBaseNavControllerViewController.h"
@interface MianTabBarViewController ()
{
    NSTimer *timer;
}
@end

@implementation MianTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.delegate=self;
    
    [self configureTabBarController];
}

- (void)configureTabBarController {
    
    //初始化首页
    FEHomeViewController *homeCtl = [[FEHomeViewController alloc] init];
    UINavigationController *homeNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:homeCtl];
    //homeCtl.title=@"菲尔生活";
    homeCtl.tabBarItem.title = @"首页";
    homeCtl.tabBarItem.image = [[UIImage imageNamed:@"home_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_clicked"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //初始化商城
    FEStoreViewController *storeCtl = [[FEStoreViewController alloc] init];
    UINavigationController *storeNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:storeCtl];
    storeCtl.title = @"菲尔商城";
    storeCtl.tabBarItem.title = @"菲尔商城";
    storeCtl.tabBarItem.image = [[UIImage imageNamed:@"store_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    storeCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"store_clicked"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //初始化邻居里圈
    
    FENeighborViewController *neighborCtl = [[FENeighborViewController alloc] init];
    UINavigationController *neighborNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:neighborCtl];
    neighborCtl.title = @"邻里圈";
    neighborCtl.tabBarItem.title = @"邻里圈";
    neighborCtl.tabBarItem.image =[[UIImage imageNamed:@"neighbor_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    neighborCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"neighbor_clicked"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ///购物车
    ShoppingCartViewController *shoppingCartCtl = [[ShoppingCartViewController alloc] init];
    UINavigationController *shoppingCartNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:shoppingCartCtl];
    shoppingCartCtl.title = @"购物车";
    shoppingCartCtl.tabBarItem.title = @"购物车";
    shoppingCartCtl.tabBarItem.image = [[UIImage imageNamed:@"shoppingcart_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shoppingCartCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"shoppingcart_clicked"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    //初始化我的
    FEMineViewController *mineCtl = [[FEMineViewController alloc] init];
    UINavigationController *mineNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:mineCtl];
    mineCtl.title = @"我的";
    mineCtl.tabBarItem.title = @"我的";
    mineCtl.tabBarItem.image = [[UIImage imageNamed:@"mine_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"mine_clicked"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.viewControllers = @[homeNav, storeNav, neighborNav,shoppingCartNav,mineNav];
    self.tabBar.tintColor = Green_Color;
    //[UIColor colorWithHexString:@"#1193d9"];
    self.tabBar.backgroundColor=[UIColor whiteColor];
    self.selectedIndex=0;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    //self.tabBar.hidden=YES;
    
    self.hidesBottomBarWhenPushed =YES;
    
    

}



-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController

{
    if ([viewController.title isEqualToString:@"购物车"])
    {
        FELoginInfo *info=[LoginUtil getInfoFromLocal];
        
        
        NSLog(@"是否 登录 ---info--%@",info.isLogin);
        if ([info.isLogin isEqualToString:@"0"]||[info.isLogin isEqual:nil]||[info.isLogin isKindOfClass:[NSNull class]]||[info.isLogin isEqual:[NSNull null]]||info.isLogin.length==0)
        {
                    FELoginViewController *vc=[[FELoginViewController alloc]init];
                    //vc.delegete=self;
                    FEBaseNavControllerViewController *logNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:vc];
            
                    [self presentViewController:logNav animated:YES completion:nil];
            //[FENavTool showAlertViewByAlertMsg:@"请先登录" andType:@"提示"];
            return NO;
        }
        
        
        
    }
        return YES;
        
    
}

@end
