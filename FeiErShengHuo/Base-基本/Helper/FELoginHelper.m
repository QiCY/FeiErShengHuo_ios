//
//  FELoginHelper.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/23.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FELoginHelper.h"

@implementation FELoginHelper

+(void) loginMoel:(FELoginInfo *)info andVC:(UIViewController *)selfVC andLoginedBlock:(void(^)())complete;

{
    
    if ([info.isLogin isEqualToString:@"0"]||[info.isLogin isEqual:nil]||[info.isLogin isKindOfClass:[NSNull class]]||[info.isLogin isEqual:[NSNull null]]||info.isLogin.length==0) {
        FELoginViewController *vc=[[FELoginViewController alloc]init];
        //vc.delegete=self;
        FEBaseNavControllerViewController *logNav=[[FEBaseNavControllerViewController alloc]initWithRootViewController:vc];
        
        [selfVC presentViewController:logNav animated:YES completion:nil];
        //return;
    }
    else
    {
        complete? complete():nil;
        
        
    }
}







@end
