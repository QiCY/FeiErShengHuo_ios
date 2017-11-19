//
//  FEActivityDetailModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FEpicListModel.h"

@interface FEActivityDetailModel : NSObject
@property(nonatomic,strong)NSString *activityEndTimeStr;
@property(nonatomic,strong)NSNumber *activityNnmber;
@property(nonatomic,strong)NSString *activityTitle;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *activityContent;
@property(nonatomic,strong)NSString *  activityEndDateStr;
@property(nonatomic,strong)NSString *activityPlace;
@property(nonatomic,strong)NSMutableArray *picList;
@property(nonatomic,strong)NSString *activityRemark;
@property(nonatomic,strong)NSString *activityStartTimeStr;


@end
/*
"activityEndTimeStr": "string,活动结束时间",
"activityNnmber": "integer,人数限制",
"activityTitle": "string,活动标题",
"nickName": "string,发起人",
"activityContent": "string,活动内容",
"activityEndDateStr": "string,报名截止时间",
"activityPlace": "string,活动地址",
"picList": {
    "activityUrl": "string,图片"
},
"activityRemark": "string,参与方式",
"activityStartTimeStr": "string,活动起始时间"

*/
