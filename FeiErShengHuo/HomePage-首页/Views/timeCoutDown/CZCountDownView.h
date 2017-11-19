//
//  CZCountDownView.h
//  countDownDemo
//
//  Created by 孔凡列 on 15/12/9.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimerStopBlock)();

@interface CZCountDownView : UIView

@property (nonatomic,strong)NSMutableArray *timeLabelArrM;
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;
// day
@property (nonatomic,strong)UILabel *dayLabel;
// hour
@property (nonatomic,strong)UILabel *hourLabel;
// minues
@property (nonatomic,strong)UILabel *minuesLabel;
// seconds
@property (nonatomic,strong)UILabel *secondsLabel;






// 时间戳
@property (nonatomic,assign)NSInteger timestamp;
// 背景
@property (nonatomic,copy)NSString *backgroundImageName;
// 时间停止后回调
@property (nonatomic,copy)TimerStopBlock timerStopBlock;
/**
 *  创建单例对象
 */
+ (instancetype)shareCountDown;// 工程中使用的倒计时是唯一的

/**
 *  创建非单例对象
 */
+ (instancetype)countDown; // 工程中倒计时不是唯一的

@end
