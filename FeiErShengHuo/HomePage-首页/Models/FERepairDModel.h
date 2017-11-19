//
//  FERepairDModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"
#import "FEpicturemapmodel2.h"

@interface FERepairDModel : FEbaseModel
@property(nonatomic,strong)NSString *repaireImages;
@property(nonatomic,strong)NSString *repaireContent;
@property(nonatomic,strong)NSString *repaireRequirement;
@property(nonatomic,strong)NSString *propertyPhone;
@property(nonatomic,strong)NSMutableArray *pictureMap;

@property(nonatomic,strong)NSString *resolve;
@end
/*
"xcommunityTypeId" = 0,
"categoryName" = <null>,
"resolve" = <null>,
"review" = ,
"mobile" = <null>,
"repaireImages" = http://192.168.1.133:8020/pic/snsImage/1499134319140.jpg@1499134319156.jpg,
"userId" = 0,
"repaireId" = 0,
"regionid" = 0,
"repaireContent" = 我yyizhiz,
"repaireCreateTime" = 0,
"repaireRequirement" = 你自以为,
"timeStr" = <null>,
"propertyPhone" = 15346258941,

*/
