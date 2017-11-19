//
//  ZSLNetworkConnect.m
//  NetworkConnect
//
//  Created by 曾诗亮 on 2017/1/16.
//  Copyright © 2017年 zsl. All rights reserved.
//

#import "ZSLNetworkConnect.h"
#import "AFNetworking.h"

@implementation ZSLNetworkConnect

+ (void)canConnectNetworkWithVC:(UIViewController *)vc completion:(void (^)(BOOL))completion
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        if (status==-1 || status==0) {
            completion(NO);
            
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络，前往设置打开网络" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"cancelAction");
            }];
            UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                NSLog(@"ensureAction");
                
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                UIApplication *application = [UIApplication sharedApplication];
                if ([application canOpenURL:url]){
                    [application openURL:url];
                }
            }];
            
            [ac addAction:cancelAction];
            [ac addAction:ensureAction];
            [vc presentViewController:ac animated:YES completion:nil];
            
        }else {
            completion(YES);
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}




+(void)checkNetcompletion:(void(^)(BOOL ok))completion
{
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status==-1 || status==0) {
             completion(NO);
             
            
         }else {
             completion(YES);
         }
     }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    
    
}





@end
