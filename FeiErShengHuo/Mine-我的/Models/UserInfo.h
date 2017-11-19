//
//  UserInfo.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <ShareSDKExtension/SSEBaseUser.h>

@interface UserInfo : SSEBaseUser

/**
 *  头像
 */
@property (nonatomic, copy) NSString *avatar;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  描述
 */
@property (nonatomic, copy) NSString *aboutMe;

///**
// *  性别
// */
//
//@property (nonatomic, copy) NSString *aboutMe;

@end
