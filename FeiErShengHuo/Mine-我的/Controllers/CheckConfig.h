//
//  CheckConfig.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckConfig : NSObject

//检查手机号码
+(BOOL)checkMobileNumber:(NSString *)phoneStr;

//检查验证码
+(BOOL)checkVerifyCode:(NSString *)codeStr;

@end
