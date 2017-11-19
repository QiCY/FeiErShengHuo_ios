//
//  FENeighberCommentModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FENeighberCommentModel : NSObject
@property(nonatomic,strong)NSString *headImgUrl;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *createTimeStr;
@property(nonatomic,strong)NSString *content;

@property(nonatomic,strong)NSNumber *rUserId;
@property(nonatomic,strong)NSNumber *regionid;
@property(nonatomic,strong)NSNumber *snsId;

@end


/*
 
 "headImgUrl" = http://192.168.1.133:8020/pic/headIcon/149681786041013338062713.jpg,
 "snsId" = 0,
 "mobile" = <null>,
 "parentid" = 0,
 "pic" = <null>,
 "createTimeStr" = 2017-06-20 18:22:33,
 "good" = 0,
 "createTime" = 1497954153,
 "userId" = 0,
 "nickName" = 老哥稳,
 "title" = <null>,
 "regionid" = 0,
 "themeId" = 0,
 "commentCount" = 0,
 "rUserId" = 0,
 "pictureMap" = 0 (
 ),
 "content" = 哈哈哈,
 
 */
