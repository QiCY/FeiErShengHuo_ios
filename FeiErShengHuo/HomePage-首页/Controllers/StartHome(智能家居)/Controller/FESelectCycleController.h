//
//  FESelectCycleController.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "SDBaseTableViewController.h"

@interface FESelectCycleController : SDBaseTableViewController

@property (nonatomic,copy) void (^didSelectCycle) (NSString *cycle);

+ (FESelectCycleController *)controllerWithCycle:(NSString *)cycle;

@end
