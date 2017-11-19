//
//  FENoticeModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FENoticeModel : NSObject
@property(nonatomic,strong)NSString *annonceTitle; //标题
@property(nonatomic,strong)NSString *creatimeStr; //时间
@property(nonatomic,strong)NSString *annonceText; //内容
@property(nonatomic,strong)NSNumber *announceId;   //ID

@property(nonatomic,strong)NSString *startTimeStr; //开始
@property(nonatomic,strong)NSString *endTimeStr; //结束

@property(nonatomic,strong)NSString *location; //范围
@end

/*
"code" = 1,
"description" = success,
"announces" = 1 (
                 {
                     "annonceTitle" = 停电通知,
                     "creatimeStr" = 2016-12-19 10:39:57,
                     "annonceAuthor" = <null>,
                     "startTimeStr" = <null>,
                     "endTimeStr" = <null>,
                     "weid" = 0,
                     "annonceText" = <p>测试 停电通知</p><p><br/></p>,
                     "announceId" = 22,
                     "location" = <null>,
                     "endTime" = 0,
                     "createTime" = 1482115197,
                     "regionid" = 0,
                     "startTime" = 0,

*/
