//
//  FEAdviceTypeViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/8.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"

@protocol choseDelegate <NSObject>

- (void)chosetype:(NSString *)type andID:(NSNumber *)xcommunityTypeId;

@end
@interface FEAdviceTypeViewController : FEBaseViewController

@property(nonatomic, weak)id<choseDelegate>delegate;



@end
