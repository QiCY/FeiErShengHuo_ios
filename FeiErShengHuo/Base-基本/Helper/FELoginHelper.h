//
//  FELoginHelper.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/23.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FELoginInfo.h"
@interface FELoginHelper : NSObject

+(void) loginMoel:(FELoginInfo *)info andVC:(UIViewController *)selfVC andLoginedBlock:(void(^)())complete;

@end
