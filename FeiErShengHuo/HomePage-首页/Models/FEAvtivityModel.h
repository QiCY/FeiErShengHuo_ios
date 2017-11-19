//
//  FEAvtivityModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEAvtivityModel : NSObject
@property(nonatomic,strong)NSString *activityTitle;
@property(nonatomic,strong)NSNumber *activityId;

@property(nonatomic,strong)NSString *activityMark;
@property(nonatomic,strong)NSString *activityCreateTimeStr;
@property(nonatomic,strong)NSString *activityEndTimeStr;
@property(nonatomic,strong)NSString *avatar;

@end
