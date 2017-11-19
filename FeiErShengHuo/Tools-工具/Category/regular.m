//
//  regular.m
//  yun
//
//  Created by dangyongxing on 16/1/7.
//  Copyright © 2016年 yunzu. All rights reserved.
//

#import "regular.h"

@implementation regular
/**
 *  正则表达式(只能由中文、字母或数字组成)
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)checkRegular:(NSString *)str
{
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject: str])
    {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能由中文、字母或数字组成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
        return  NO;
    }
   return  YES;
}

/**
 *  正则表达式(只能由字母或数字组成)
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)checkRegular2:(NSString *)str
{
    NSString *regex =@"^[A-Za-z0-9\u4e00-\u9fa5]+";;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject:str])
    {
        return  NO;
    }
    return  YES;
}
/**
 *  正则表达式(ip地址)
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)checkRegular3:(NSString *)str
{
    NSString *regex = @"\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject: @""])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能由字母和数字组成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return  NO;
    }
    return  YES;
}
/**
 *  正则表达式(中文字符)
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)checkRegular4:(NSString *)str
{
    NSString *regex = @"[\u4e00-\u9fa5]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject: @""])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能由中文字符组成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return  NO;
    }
    return  YES;
}
/**
 *  匹配Email地址的正则表达式
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)checkRegular5:(NSString *)str
{
     NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject: @""])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能由中文字符组成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return  NO;
    }
    return  YES;
}
/**
 *  匹配网址URL的正则表达式
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)checkRegular6:(NSString *)str
{
    NSString *regex = @"[a-zA-z]+://[^\\s]* ";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject: @""])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能由中文字符组成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return  NO;
    }
    return  YES;
}
+(BOOL)checkRegular7:(NSString *)str
{
    NSString *regex =@"^[0-9]{11}+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject:str])
    {
        //        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"只能由字母和数字组成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //        [alertView show];
        return  NO;
    }
    return  YES;
}
+(BOOL)checkRegular8:(NSString *)str
{
    NSString *regex =@"^[A-Za-z0-9]{6,20}+$";;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject:str])
    {
        return  NO;
    }
    return  YES;
}

@end
