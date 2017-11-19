//
//  YHJTextView.m
//  TextView~Placeholder
//
//  Created by lzy on 16/6/23.
//  Copyright © 2016年 Ruyun. All rights reserved.
//

#import "YHJTextView.h"
#import "UIView+Extension.h"

@interface YHJTextView ()

//这里先拿出这个label以方便我们后面的使用
@property (nonatomic,strong) UILabel *placeholderLabel;

@end

@implementation YHJTextView

-(instancetype)initWithFrame:(CGRect)frame
{

    self=[super initWithFrame:frame];

    if(self) {
        
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;

        self.backgroundColor= [UIColor clearColor];

        // 添加一个占位label
        UILabel *placeholderLabel=[[UILabel alloc]init];
        placeholderLabel.backgroundColor=[UIColor clearColor];
        // 设置可以输入多行文字时可以自动换行
        placeholderLabel.numberOfLines=0;
        [self addSubview:placeholderLabel];

        // 赋值保存
        self.placeholderLabel= placeholderLabel;
        // 设置占位文字默认颜色
        self.myPlaceholderColor= [UIColor lightGrayColor];

        // 设置默认的字体
        self.font= [UIFont systemFontOfSize:15];

        // 通知:监听文字的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
    
}

#pragma mark -监听文字改变
- (void)textDidChange
{
    self.placeholderLabel.hidden=self.hasText;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    // 设置UILabel 的 y值
    //self.placeholderLabel.y=16;

    // 设置 UILabel 的 x 值
    //self.placeholderLabel.x=16;

    // 设置 UILabel 的 x
    //self.placeholderLabel.width=self.width-self.placeholderLabel.x*2.0;

    // 根据文字计算高度
    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    //self.placeholderLabel.height= [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
    self.placeholderLabel.frame=CGRectMake(16, 16, self.frame.size.width-32,  [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height);
    

}

- (void)setMyPlaceholder:(NSString*)myPlaceholder
{
    _myPlaceholder= [myPlaceholder copy];

    // 设置文字
    self.placeholderLabel.text= myPlaceholder;

    //重新计算子控件frame
    [self setNeedsLayout];

}
- (void)setMyPlaceholderColor:(UIColor*)myPlaceholderColor
{
    _myPlaceholderColor= myPlaceholderColor;

    //设置颜色
    self.placeholderLabel.textColor= myPlaceholderColor;
}

// 重写这个set方法保持font一致
- (void)setFont:(UIFont*)font
{
    [super setFont:font];
    self.placeholderLabel.font= font;

    //重新计算子控件frame
    [self setNeedsLayout];
}

- (void)setText:(NSString*)text
{
    [super setText:text];

    // 这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    [self textDidChange];
}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
    
}

- (void)setAttributedText:(NSAttributedString*)attributedText
{
    [super setAttributedText:attributedText];
    // 这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    [self textDidChange];
}

@end
