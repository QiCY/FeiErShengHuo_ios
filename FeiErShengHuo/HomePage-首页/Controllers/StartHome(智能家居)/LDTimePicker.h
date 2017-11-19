//
//  LDTimePicker.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDTimePicker : UIView

@property (nonatomic,copy) void (^didSelectTime) (NSString *time);

/// HH:mm:ss
+ (LDTimePicker *)pickerWithTime:(NSString *)time;

- (void)show;

@end
