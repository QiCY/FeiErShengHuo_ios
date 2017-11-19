//
//  ASMessageView.h
//  评论框
//
//  Created by allenBlack on 16/3/11.
//  Copyright © 2016年 allenBlack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NotiOfTextViewContentSizeHeightChangedHeigher @"notiOfTextViewContentSizeHeightChangedHeigher"
#define NotiOfTextViewContentSizeHeightChangedLower @"notiOfTextViewContentSizeHeightChangedLower"

#define MessageViewDefaultHeight 40//
#define MessageViewLeadingMargin 10
#define MessageViewTrailingMargin 10

#define TextViewLeadingMargin 5
#define TextViewTrailingMargin 10

#define SendBtnLeadingMargin TextViewTrailingMargin
#define SendBtnTrailingMargin 5
#define SendBtnWidth 40
#define SendBtnHeight 30

@protocol ASMessageViewDelegate;

/**
 *  评论输入框
 */
@interface ASMessageView : UIView

@property (weak, nonatomic) id<ASMessageViewDelegate>delegate;

@property (strong, nonatomic) UITextView *textView;


@end



@protocol ASMessageViewDelegate <NSObject>

// textViews

- (void)asTextViewDidBeginEditing:(UITextView *)textView;

- (void)asTextViewDidEndEditing:(UITextView *)textView;

//sendBtn
- (void)asSendBtnAction:(UIButton *)sender;

@end