//
//  LoginUtil.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#define userpath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/texts"]
#import <Foundation/Foundation.h>
@class FELoginInfo;


@interface LoginUtil : NSObject

+(void)saveing:(FELoginInfo *)info;

+(FELoginInfo *)getInfoFromLocal;

+(void)removeUserInfoFromlocal;
@end
