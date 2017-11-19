//
//  FENavTool.h
//  zijinlian
//
//  Created by lzy on 2017/3/7.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^rightClick)();
typedef void(^cancelClick)();

typedef enum rightItemType{
    item_register,
    item_threeline,
    item_delete,
    item_publish,
    item_finish,
    item_whrite,
    item_sure,
    item_share,
    item_genhuan,
    item_shanchu
    
    
}RightItemType;

@interface FENavTool : NSObject


@property(nonatomic,copy)rightClick rightBlock;
@property(nonatomic,copy)cancelClick cancelClick;

+(void)backOnNavigationItemWithNavItem:(UINavigationItem *)navitem target:(id)target action:(SEL)action;
+(void)rightItemOnNavigationItem:(UINavigationItem *)navitem target:(id)target action:(SEL)action andType:(RightItemType)type;
+(void)showAlertViewByAlertMsg:(NSString *)msg andType:(NSString *)infoType;
+(void)showAlertRightAndCancelMsg:(NSString *)msg andType:(NSString *)title andRightClick:(rightClick)rightClick andCancelClick:(cancelClick)cancelClick;



+(BOOL)checkNetAndShowAlert;
//+(NSString *)getErrorMsgByErrorCode:(NSNumber *)errCode;
+(void)codeisEqualToStringOneWithDic:(NSDictionary *)dictionary withSucess:(NSString *)sucesssStr withFailed:(NSString *)failedStr;
//调整颜色
+(NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString  RangeColor:(UIColor *)Color;

+(NSMutableAttributedString *)withStr:(NSString *)rangeStr withRangeColor:(UIColor *)Color withRangeFont:(UIFont *)Font WithRange: (NSRange)Range;
//获取当前时间
+(NSString*)getCurrentTimes;

//拨打电话
+(void)view:(UIViewController *)controller phoneWithMoble:(NSString *)phoneStr;



@end
