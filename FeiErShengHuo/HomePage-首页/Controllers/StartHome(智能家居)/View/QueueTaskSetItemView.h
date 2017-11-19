//
//  QueueTaskSetItemView.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueueTaskSetItemView : UIView

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *value;

@property (nonatomic,copy) void (^didClickSelf) ();

+ (QueueTaskSetItemView *)viewWithTitle:(NSString *)title;

@end
