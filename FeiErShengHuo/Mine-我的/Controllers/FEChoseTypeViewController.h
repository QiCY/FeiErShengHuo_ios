//
//  FEChoseTypeViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/21.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"

@protocol choseRegionDelegate <NSObject>

- (void)choseRegiontype:(NSString *)regionStr andID:(NSNumber *)regionId;

@end

@interface FEChoseTypeViewController : FEBaseViewController

@property(nonatomic,weak)id<choseRegionDelegate>delegete;


@end




