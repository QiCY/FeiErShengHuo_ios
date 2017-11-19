//
//  FESetQueueTaskViewController.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"

@interface FESetQueueTaskViewController : FEBaseViewController

@property (nonatomic,copy) void (^shouldAddTask) (NSDictionary *task);

@end
