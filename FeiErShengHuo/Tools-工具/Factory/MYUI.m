//
//  MYUI.m
//  ZiJinLian
//
//  Created by lzy on 2017/3/8.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "MYUI.h"

@implementation MYUI

+(UIView *)createViewFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (UILabel*)createLableFrame:(CGRect)frame  backgroundColor:(UIColor *)color  text:(NSString *)str  textColor:(UIColor *)textcolor font:(UIFont *)font  numberOfLines:(int)numberOfLines adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth{
    
    UILabel*lable = [[UILabel alloc]initWithFrame:frame];
    lable.backgroundColor = color;
    lable.text = str;
    lable.textColor =textcolor;
    lable.font = font;
    lable.numberOfLines = numberOfLines;
    lable.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    return lable;
}

+ (ZJInsertLab *)createLableFrame:(CGRect)frame  backgroundColor:(UIColor *)color  text:(NSString *)str  textColor:(UIColor *)textColor font:(UIFont *)font  numberOfLines:(int)numberOfLines   adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth insert:(UIEdgeInsets)inserts
{
    ZJInsertLab*lable = [[ZJInsertLab alloc]initWithFrame:frame];
    lable.backgroundColor = color;
    lable.text = str;
    lable.textColor =textColor;
    lable.font = font;
    lable.insets=inserts;
    lable.numberOfLines = numberOfLines;
    lable.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    return lable;
 
}


+(UIButton *)creatButtonFrame:(CGRect )frame   backgroundColor:(UIColor*)color setTitle:(NSString *)title  setTitleColor:(UIColor *)TitleColor  {
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    button.backgroundColor = color;
    button.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    //[button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
}
+(UIButton *)creatButtonFrame:(CGRect)frame setBackgroundImage:(UIImage *)image
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    //[button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
    
}

+(UIButton *)creatButtonFrame:(CGRect )frame   backgroundColor:(UIColor*)color
{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    
    //[button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
}

+(UIButton *)creatNormalButtonFrame:(CGRect )frame  setBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor  {
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    //[button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;
}

//上图下文
+(ZJButton *)creatButtonFrame:(CGRect )frame  setZJBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor  {
    
    ZJButton *button =[ZJButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    //[button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;
}



+(UIButton *)creatButtonFrame:(CGRect )frame  setBackgroundImage:(UIImage *)image  setTitle:(NSString *)title setTitleColor:(UIColor *)TitleColor
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    //[button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    return button;

}

+(UIImageView *)creatImageViewFrame:(CGRect)frame image:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView setImage:image];
    
    return  imageView;
    
}
+(UIImageView *)creatImageViewFrame:(CGRect)frame imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:imageName];
    
    [imageView setImage:image];
    return imageView;
    
}

+ (UIImageView *)creatCircleImageViewFrame:(CGRect)frame imageName:(NSString*)imageName
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:imageName];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=frame.size.width/2;
    [imageView setImage:image];
    return imageView;
    
}
//创建textField,无图片，有密码。
+(ZJCustomTF *)createTextFieldFrame:(CGRect )frame backgroundColor:(UIColor*)color secureTextEntry:(BOOL)secureTextEntry    placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing {
    
    ZJCustomTF *textField = [[ZJCustomTF alloc]init];
    textField.frame = frame ;
    textField.backgroundColor = color;
    textField.secureTextEntry =secureTextEntry;
    //textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    //字体 颜色
    textField.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [textField setValue:[UIColor colorWithHexString:@"#999999"]
             forKeyPath:@"_placeholderLabel.textColor"];
    //键盘样式
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.clearButtonMode = UITextFieldViewModeAlways;

    return textField;
    
}
//创建textField,无图片，无密码。
+(ZJCustomTF *)createTextFieldFrame:(CGRect )frame backgroundColor:(UIColor*)color  placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing  {
    
    ZJCustomTF *textField = [[ZJCustomTF alloc]init];
    textField.frame = frame ;
    textField.backgroundColor = color;
    //textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.font=[UIFont fontWithName:@"PingFangSC-Regular" size:14];
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    [textField setValue:[UIColor colorWithHexString:@"#999999"]
          forKeyPath:@"_placeholderLabel.textColor"];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.layer.cornerRadius=5;
    textField.layer.masksToBounds=YES;
    textField.returnKeyType = UIReturnKeyDone;
    return textField;
}

//创建textField,有图片，无密码。
+(ZJCustomTF *)createTextFieldFrame:(CGRect )frame background:(UIImage *)image    placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing {
    
    ZJCustomTF *textField = [[ZJCustomTF alloc]init];
    textField.frame = frame ;
    textField.background = image ;
    //textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    
    return textField;
}
//创建textField,有图片，有密码。
+(ZJCustomTF *)createTextFieldFrame:(CGRect )frame background:(UIImage *)image secureTextEntry:(BOOL)secureTextEntry   placeholder:(NSString *)str clearsOnBeginEditing:(BOOL)clearsOnBeginEditing  {
    ZJCustomTF *textField = [[ZJCustomTF alloc]init];
    textField.frame = frame ;
    textField.background = image ;
    textField.secureTextEntry =secureTextEntry;
    // textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = str;
    textField.clearsOnBeginEditing =clearsOnBeginEditing;
    return textField;
    
}

@end



