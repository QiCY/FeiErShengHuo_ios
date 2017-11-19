//
//  FEgroupedDetailModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"

@interface FEgroupedDetailModel : FEbaseModel
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *datelineStr;
@property(nonatomic,strong)NSString *isTuanMember;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSNumber *tuanId;

@end
/*

"description" = <null>,
"userStaus" = 1,
"datelineStr" = 2017-07-01 16:13:53,
"nickName" = 老司机,
"tuanId" = 0,
"title" = <null>,
"payNum" = 0,
"regionId" = 0,
"endTimeStr" = <null>,
"pay_url" = <null>,
"tuanSn" = <null>,
"endTime" = 0,
"slideList" = 0 (
),
"marketPrice" = 0,
"dateLine" = 1498896833,
"thumb" = <null>,
"num" = 0,
"mobile" = <null>,
"slide" = <null>,
"isTuanMember" = 团长,
"productPrice" = 0,
"avatar" = http://192.168.1.133:8020/pic/headIcon/149786068348115240543995.jpg,
"userName" = <null>,
"address" = <null>,
"userId" = 0,


*/
