//
//  FEPersontuanModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"

@interface FEPersontuanModel : FEbaseModel
@property(nonatomic,strong)NSString *pay_url;
@property(nonatomic,strong)NSString *thumb;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *tuanSn;
@property(nonatomic,strong)NSNumber *tuanId;
@property(nonatomic,strong)NSNumber *num;
@property(nonatomic,assign)NSInteger marketPrice;

@end

/*

"description" = <null>,
"userStaus" = 0,
"datelineStr" = <null>,
"nickName" = <null>,
"tuanId" = 603,
"title" = 【全橙热恋】超值水果零食礼盒，全城限量2000份！,
"payNum" = 0,
"regionId" = 0,
"endTimeStr" = <null>,
"pay_url" = http://jjxfj.xjbyte.com/Group/GroupMsg?weid=1&regionId=110&tuan_sn=86185332703298128213603098832925&my=1&id=603,
"tuanSn" = 86185332703298128213603098832925,
"endTime" = 0,
"slideList" = 0 (
),
"marketPrice" = 100,
"dateLine" = 0,
"thumb" = http://pic.xjbyte.com/store/tuan/1/huodong1.jpg,
"num" = 3,
"mobile" = <null>,
"slide" = <null>,
"isTuanMember" = <null>,
"productPrice" = 0,
"avatar" = <null>,
"userName" = <null>,
"address" = <null>,
"userId" = 0,

*/
