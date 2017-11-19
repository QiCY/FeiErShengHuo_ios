//
//  LoginUtil.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "LoginUtil.h"

@implementation LoginUtil

+(void)saveing:(FELoginInfo *)info
{
   // [NSKeyedArchiver archiveRootObject:info toFile:[NSString stringWithFormat:@"%@",userpath]];
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *muDic=[info mj_keyValues];
    NSDictionary *dic=[NSDictionary dictionaryWithDictionary:muDic];
    
    [defaults setObject:dic forKey:USERINFO];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库


}
+(FELoginInfo *)getInfoFromLocal
{
    
      NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults objectForKey:USERINFO];
    FELoginInfo * saveUserInfo = [FELoginInfo mj_objectWithKeyValues:dic];
    
//    FELoginInfo* saveUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@",userpath]]];
    return saveUserInfo;
}

+(void)removeUserInfoFromlocal
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFO];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //[NSUserDefaults resetStandardUserDefaults];
    // [[NSFileManager defaultManager]removeItemAtPath:[NSString stringWithFormat:@"%@",userpath] error:nil];
}

@end
