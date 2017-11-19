//
//  ZLActionSheet.h
//  IndustryProxy
//
//  Created by TAKUMI on 2016/12/29.
//  Copyright © 2016年 TAKUMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClickAction)();

@interface ZLActionSheet : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic,strong) NSMutableAttributedString *changeTitle;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,strong) UIFont *font;
/**
 * @param title    标题
 * @param message  提示内容
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)setTitle:(NSString *)title message:(NSString *)message;

/**
 * @brief 添加按钮及事件，多个按钮便多次调用，按钮按照添加顺序显示
 */
- (void)addBtnTitle:(NSString *)title action:(ClickAction)action;

/**
 * @brief 显示提示框
 */
- (void)showActionSheetWithSender:(UIViewController *)sender;


NS_ASSUME_NONNULL_END

@end

