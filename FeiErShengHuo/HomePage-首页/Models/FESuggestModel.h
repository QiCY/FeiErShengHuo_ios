//
//  FESuggestModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/3.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEbaseModel.h"
#import "FEpictureMapModel.h"

@interface FESuggestModel : FEbaseModel

@property(nonatomic,strong)NSString *adviceResolveInfo;
@property(nonatomic,strong)NSString *requirementAdvice;
@property(nonatomic,strong)NSString *adviceContent;
@property(nonatomic,strong)NSString *xcommunityAdviceImages;
@property(nonatomic,strong)NSString *propertyPhone;
@property(nonatomic,strong)NSNumber *adviceId;
@property(nonatomic,strong)NSMutableArray *pictureMap;


/*
 
 "description" = success,
 "xcommunityAdvice" = {
 "categoryName" = <null>,
 "adviceResolve" = <null>,
 "xcommunityTypeId" = 0,
 "review" = ,
 "mobile" = <null>,
 "xcommunityAdviceImages" = http://192.168.1.133:8020/pic/snsImage/,
 "adviceCreateTimeStr" = <null>,
 "requirementAdvice" = cheshi,
 "userId" = 0,
 "adviceContent" = ceshi,
 "adviceCreateTime" = 0,
 "regionid" = 0,
 "propertyPhone" = 15235894561,
 "adviceId" = 0,
 
 */

@end
