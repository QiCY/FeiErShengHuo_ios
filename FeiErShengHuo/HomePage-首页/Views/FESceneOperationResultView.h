//
//  FESceneOperationResultView.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLDNADevice.h"

@interface FESceneOperationResultView : UIView

@property (nonatomic,copy) void (^shouldCancelOperation) ();

+ (FESceneOperationResultView *)viewWithDevices:(NSArray <BLDNADevice *>*)devices sceneName:(NSString *)sceneName;

- (void)show;
- (void)dismiss;

- (void)refreshItem:(NSInteger)index result:(BOOL)success;



@end
