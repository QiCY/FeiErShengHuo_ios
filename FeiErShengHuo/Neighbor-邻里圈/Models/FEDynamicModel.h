//
//  FEDynamicModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FEPictureModel.h"


@interface FEDynamicModel : NSObject
@property(nonatomic,strong)NSString *headImgUrl;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSNumber *createTime;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *createTimeStr;
@property(nonatomic,strong)NSNumber *themeId;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSNumber *rUserId;
@property(nonatomic,strong)NSNumber *good;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSNumber *snsId;
@property(nonatomic,strong)NSNumber *commentCount;
@property(nonatomic,strong)NSNumber *regionid;


//图片数组
@property(nonatomic,strong)NSMutableArray *pictureMap;


/*
 
 "snsId" = 1172,
 "mobile" = ,
 "parentid" = 0,
 "pic" = 14973507521360.jpg,
 "createTimeStr" = 2017-06-13 18:45:50,
 "good" = 0,
 "createTime" = 1497350750,
 "userId" = 8699,
 "nickName" = sos,
 "title" = <null>,
 "regionid" = 2,
 "themeId" = 0,
 "commentCount" = 1,
 "rUserId" = 0,
 
 */





@end
