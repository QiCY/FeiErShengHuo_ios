//
//  ASMessageView.m
//  评论框
//
//  Created by allenBlack on 16/3/11.
//  Copyright © 2016年 allenBlack. All rights reserved.
//

#import "ASMessageView.h"



@interface ASMessageView ()<UITextViewDelegate> {
    CGFloat textViewOriginContentSizeHieght;   //初始textview 的 contentSize
    CGFloat textViewCurrentContentSizeHieght;   //当前textview 的 contentSize

}

@property (strong, nonatomic) UIButton *sendBtn;

@end

@implementation ASMessageView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
        [self registerNotifications];
    }
    return self;
}

- (void)setUpViews {
    //textView
    [self addSubview:self.textView];
    self.textView.frame = CGRectMake(TextViewLeadingMargin, 0, self.bounds.size.width - TextViewLeadingMargin - TextViewTrailingMargin - SendBtnWidth - SendBtnTrailingMargin, self.bounds.size.height);
    self.textView.delegate = self;
    textViewOriginContentSizeHieght = self.textView.frame.size.height;
    textViewCurrentContentSizeHieght = textViewOriginContentSizeHieght;
    
    //sendBtn
    [self addSubview:self.sendBtn];
    _sendBtn.frame = CGRectMake(self.frame.size.width - SendBtnTrailingMargin - SendBtnWidth, (self.frame.size.height- SendBtnHeight)/2, SendBtnWidth, SendBtnHeight);
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    _sendBtn.layer.borderWidth = 0.5;
    _sendBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [_sendBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  
    //注释掉
    _textView.backgroundColor = [UIColor yellowColor];
    _sendBtn.backgroundColor = [UIColor grayColor];
  
}



#pragma mark - 发送
- (void)sendBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(asSendBtnAction:)]) {
        [self.delegate asSendBtnAction:sender];
    }
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
  
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification object:nil];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(asTextViewDidBeginEditing:)]) {
        [self.delegate asTextViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(asTextViewDidEndEditing:)]) {
        [self.delegate asTextViewDidEndEditing:textView];
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
 
    
    CGFloat textViewContentSizeHeight = textView.contentSize.height;    //实时获取conentSize height
    
    if (textViewContentSizeHeight > textViewCurrentContentSizeHieght) {
        
        NSNotification *noti = [NSNotification notificationWithName:NotiOfTextViewContentSizeHeightChangedHeigher object:[NSNumber numberWithFloat:(textViewContentSizeHeight - textViewCurrentContentSizeHieght)]];
        
        [[NSNotificationCenter defaultCenter] postNotification:noti];
        
    }
    if (textViewContentSizeHeight < textViewCurrentContentSizeHieght && textViewContentSizeHeight > textViewOriginContentSizeHieght) {
        NSNotification *noti = [NSNotification notificationWithName:NotiOfTextViewContentSizeHeightChangedLower object:[NSNumber numberWithFloat:(textViewCurrentContentSizeHieght - textViewContentSizeHeight)]];
        [[NSNotificationCenter defaultCenter] postNotification:noti];
    }
    return YES;
}

#pragma mark - 通知方法
/**
 *  变高
 */
- (void)notiOfTextViewContentSizeHeightChangedHeiger:(NSNotification *)noti {
    textViewCurrentContentSizeHieght += [noti.object floatValue];
    self.sendBtn.frame = CGRectMake(self.sendBtn.frame.origin.x, self.sendBtn.frame.origin.y + [noti.object floatValue], self.sendBtn.frame.size.width, self.sendBtn.frame.size.height);
}
/**
 *  变矮
 */
- (void)notiOfTextViewContentSizeHeightChangedLower:(NSNotification *)noti {
    textViewCurrentContentSizeHieght -= [noti.object floatValue];
    self.sendBtn.frame = CGRectMake(self.sendBtn.frame.origin.x, self.sendBtn.frame.origin.y - [noti.object floatValue], self.sendBtn.frame.size.width, self.sendBtn.frame.size.height);
}

#pragma mark - 注册通知
-(void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiOfTextViewContentSizeHeightChangedHeiger:) name:NotiOfTextViewContentSizeHeightChangedHeigher object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiOfTextViewContentSizeHeightChangedLower:) name:NotiOfTextViewContentSizeHeightChangedLower object:nil];
}

#pragma mark - 懒加载
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
    }
    return _textView;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
    }
    return _sendBtn;
}

@end








