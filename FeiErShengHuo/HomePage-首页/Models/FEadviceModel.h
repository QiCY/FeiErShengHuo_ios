//
//  FEadviceModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/8.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEadviceModel : NSObject
@property(nonatomic,strong)NSString *categoryName;
@property(nonatomic,strong)NSString *adviceCreateTimeStr;
@property(nonatomic,strong)NSString *adviceResolve;
@property(nonatomic,strong)NSString *adviceContent;
@property(nonatomic,strong)NSNumber *adviceId;


@end


/*
 
 
 "categoryName" = 安全监控,
 "adviceResolve" = 未处理,
 "xcommunityTypeId" = 0,
 "review" = <null>,
 "mobile" = <null>,
 "xcommunityAdviceImages" = <null>,
 "adviceCreateTimeStr" = 2017-06-06 15:36:31,
 "requirementAdvice" = <null>,
 "userId" = 0,
 "adviceContent" = ceshi,
 "adviceCreateTime" = 1496734591,
 "regionid" = 0,
 "propertyPhone" = <null>,
 "adviceId" = 174,
 
 */

