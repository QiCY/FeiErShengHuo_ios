//
//  MYUI.h
//  ZiJinLian
//
//  Created by lzy on 2017/3/8.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZJInsertLab.h"
#import "ZJCustomTF.h"
#import "ZJButton.h"

@interface MYUI : NSObject

//创建view ，指定背景色
+ (UIView*)createViewFrame:(CGRect)frame backgroundColor:(UIColor*)color;

//创建lable
+ (UILabel*)createLableFrame:(CGRect)frame  backgroundColor:(UIColor *)color  text:(NSString *)str  textColor:(UIColor *)textColor font:(UIFont *)font  numberOfLines:(int)numberOfLines   adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth;

//创建带字体偏移的label

+ (ZJInsertLab *)createLableFrame:(CGRect)frame  backgroundColor:(UIColor *)color  text:(NSString *)str  textColor:(UIColor *)textColor font:(UIFont *)font  numberOfLines:(int)numberOfLines   adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth insert:(UIEdgeInsets)inserts;


//创建imageView
+ (UIImageView *)creatImageViewFrame:(CGRect)frame image:(UIImage*)image;
+ (UIImageView *)creatImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
// 创建 imageView
+ (UIImageView *)creatCircleImageViewFrame:(CGRect)frame imageName:(NSString*)imageName ;

//创建button，无背景图片
//+ (UIButton *)creatButtonFrame:(CGRect )frame  backgroundColor:(UIColor*)color    setTitle:(NSString *)title   setTitleColor:(UIColor *)TitleColor    addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents ;
+(UIButton *)creatButtonFrame:(CGRect )frame   backgroundColor:(UIColor*)color setTitle:(NSString *)title  setTitleColor:(UIColor *)TitleColor ;
//创建button，有背景图片,无字体
+ (UIButton *)creatButtonFrame:(CGRect )frame  setBackgroundImage:(UIImage *)image ;

+(UIButton *)creatNormalButtonFrame:(CGRect )frame  setBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor;
    

//创建button，有背景图片      ／／图片在上 文字在下
+ (ZJButton *)creatButtonFrame:(CGRect )frame  setZJBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor;



+(UIButton *)creatButtonFrame:(CGRect )frame  setBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor;




//创建textField,无图片，有密码。
+(UITextField *)createTextFieldFrame:(CGRect )frame backgroundColor:(UIColor*)color secureTextEntry:(BOOL)secureTextEntry    placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing ;

//创建textField,无图片，无密码。
+(ZJCustomTF *)createTextFieldFrame:(CGRect )frame backgroundColor:(UIColor*)color   placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing ;

//创建textField,有图片，无密码。
+(ZJCustomTF *)createTextFieldFrame:(CGRect )frame background:(UIImage *)image    placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing ;
//创建textField,有图片，有密码。
+(ZJCustomTF *)createTextFieldFrame:(CGRect )frame background:(UIImage *)image secureTextEntry:(BOOL)secureTextEntry   placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing ;

@end
