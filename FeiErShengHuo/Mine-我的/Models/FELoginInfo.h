//
//  FELoginInfo.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FEbaseModel.h"


@interface FELoginInfo : FEbaseModel

//归档

@property(nonatomic,strong)NSString *registrationID;

@property (nonatomic, strong) NSNumber *appointmentNum;
@property (nonatomic, strong) NSNumber *isRecommend;
@property (nonatomic, strong) NSNumber *provinceId;
@property (nonatomic, strong) NSNumber *_id;
@property (nonatomic, strong) NSNumber *integral;
@property (nonatomic, strong) NSString * company;
@property (nonatomic, strong) NSNumber *lastLoginTime;
@property (nonatomic, strong) NSNumber *created;
@property (nonatomic, strong) NSString * idCard;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * myNote;
@property (nonatomic, strong) NSNumber *isEnabled;
@property (nonatomic, strong) NSNumber *sortOrder;
@property (nonatomic, strong) NSNumber *villageId;
@property (nonatomic, strong) NSNumber * hostNumber;
@property (nonatomic, strong) NSString * upLoadify;
@property (nonatomic, strong) NSNumber *addTime;
@property (nonatomic, strong) NSString * hostPwd;
@property (nonatomic, strong) NSString * district;
@property (nonatomic, strong) NSNumber *userGenre;
@property (nonatomic, strong) NSNumber * sex;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *rankId;
@property (nonatomic, strong) NSNumber *isPushing;
@property (nonatomic, strong) NSString * birthday;
@property (nonatomic, strong) NSNumber *isValidate;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSNumber *signBillNumber;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString * payPassword;
@property (nonatomic, strong) NSNumber *concernNum;
@property (nonatomic, strong) NSString * strueName;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSNumber *city;
@property (nonatomic, strong) NSNumber *isHot;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSString * referrer;
@property (nonatomic, strong) NSNumber *loginNum;
@property (nonatomic, strong) NSString * nativePlace;
@property (nonatomic, strong) NSNumber *adminId;
@property (nonatomic, strong) NSNumber *commentsNum;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSNumber *regStatus;
@property (nonatomic, strong) NSNumber *areaId;
@property (nonatomic, strong) NSNumber *latitude;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,assign)NSNumber * balance;
@property(nonatomic,strong)NSString *isLogin;
@property(nonatomic,strong)NSString *isSignIn;

@property(nonatomic,strong)NSNumber *regionId;
@property(nonatomic,strong)NSString *regionTitle;
@property(nonatomic,strong)NSString *regionrationId;
@property(nonatomic,strong)NSNumber *xCode;//邀请码;



// 保存的文件路劲
+(NSString *)filePath;
//单例类
+(instancetype)shareUserInfoSingleton;
//+(FELoginInfo *)getUserInfoFromlocal;

-(BOOL)saveUserInfoTolocal;

+(BOOL)removeUserInfoFromlocal;
//是否登录
+(BOOL)isLogin;
//登录信息
-(BOOL)resetUserInfo;



@end

/*

 "appointmentNum" = 0,
 "areaId" = 0,
 "isRecommend" = 0,
 "provinceId" = 0,
 "company" = <null>,
 "integral" = 20000,
 "lastLoginTime" = 0,
 "created" = 0,
 "idCard" = <null>,
 "address" = <null>,
 "myNote" = <null>,
 "isEnabled" = 0,
 "sortOrder" = 0,
 "villageId" = 112,
 "hostNumber" = <null>,
 "upLoadify" = <null>,
 "addTime" = 0,
 "regionTitle" = 测试小区,
 "hostPwd" = <null>,
 "checkTime" = 0,
 "district" = 南通,
 "userGenre" = 0,
 "sex" = <null>,
 "email" = <null>,
 "rankId" = 0,
 "isPushing" = 0,
 "birthday" = <null>,
 "isValidate" = 0,
 "nickName" = 老司机,
 "signBillNumber" = 0,
 "longitude" = 0,
 "payPassword" = <null>,
 "concernNum" = 0,
 "strueName" = <null>,
 "avatar" = http://192.168.1.129:8080/pic/headIcon/149622064967715240543995.jpg,
 "city" = 0,
 "isHot" = 0,
 "mobile" = 15240543995,
 "code" = 0,
 "referrer" = <null>,
 "loginNum" = 0,
 "nativePlace" = <null>,
 "adminId" =
 
 */
