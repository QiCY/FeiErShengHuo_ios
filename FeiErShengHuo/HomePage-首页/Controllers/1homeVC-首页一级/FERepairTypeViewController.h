//
//  FERepairTypeViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
@protocol choseDelegate <NSObject>

- (void)chosetype:(NSString *)type andID:(NSNumber *)xcommunityTypeId;

@end
@interface FERepairTypeViewController : FEBaseViewController
@property(nonatomic, weak)id<choseDelegate>delegate;
@end
