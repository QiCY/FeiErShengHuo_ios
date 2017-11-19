//
//  CheckConfig.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "CheckConfig.h"

@implementation CheckConfig


+(BOOL)checkMobileNumber:(NSString *)phoneStr
{
    //手机号码检查
    if (!phoneStr || [phoneStr isEmptyAfterTrimmingWhitespaceAndNewlineCharacters]) {
        [FENavTool showAlertViewByAlertMsg:@"请输入手机号码" andType:@"提示"];
        return NO;
    }
    
    if (phoneStr.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入手机号码" andType:@"提示"];
        return NO;
    }
    
    if ([phoneStr firstMatchUsingRegularExpressionPattern:@"\\s"]) {
        [FENavTool showAlertViewByAlertMsg:@"不能包含空白字符" andType:@"提示"];
        return NO;
    }
    
    if (![phoneStr matchesRegularExpressionPattern:kMobileNumberRegularExpression]) {
        [FENavTool showAlertViewByAlertMsg:@"手机格式错误" andType:@"提示"];
        return NO;
    }
    NSLog(@"输入的 手机号是%@",phoneStr);
    if (![regular checkRegular7:phoneStr]) {
        [FENavTool showAlertViewByAlertMsg:@"请输入正确的手机号码" andType:@"提示"];
        return NO;
    }
    return YES;
 
}
+(BOOL)checkVerifyCode:(NSString *)codeStr
{
    if ([codeStr firstMatchUsingRegularExpressionPattern:@"\\s"]) {
        [FENavTool showAlertViewByAlertMsg:@"不能包含空白字符" andType:@"提示"];
        return NO;
    }
    if (![codeStr matchesRegularExpressionPattern:kNumberRegularExpression] || !(codeStr.length == 6)) {
        [FENavTool showAlertViewByAlertMsg:@"输入的验证码有误，请重新输入" andType:@"提示"];
        return NO;
    }
    
    if (codeStr.length==0) {
        [FENavTool showAlertViewByAlertMsg:@"请输入验证码" andType:@"提示"];
        return NO;
    }
    return YES;
}
@end
