//
//  ZSLNetworkConnect.h
//  NetworkConnect
//
//  Created by 曾诗亮 on 2017/1/16.
//  Copyright © 2017年 zsl. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ZSLNetworkConnect : NSObject

+ (void)canConnectNetworkWithVC:(UIViewController *)vc completion:(void(^)(BOOL ok))completion;
+(void)checkNetcompletion:(void(^)(BOOL ok))completion;



@end
