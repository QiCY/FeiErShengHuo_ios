//
//  YHJTextView.h
//  TextView~Placeholder
//
//  Created by lzy on 16/6/23.
//  Copyright © 2016年 Ruyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHJTextView : UITextView

//文字
@property(nonatomic,copy)NSString *myPlaceholder;

//文字颜色
@property(nonatomic,strong)UIColor *myPlaceholderColor;

@end
