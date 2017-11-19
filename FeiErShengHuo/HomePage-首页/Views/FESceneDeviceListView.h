//
//  FESceneDeviceListView.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLDNADevice.h"

@interface FESceneDeviceListView : UIView

@property (nonatomic,copy) void (^didSelectOneDevice) (BLDNADevice *device);

+ (FESceneDeviceListView *)viewWithDeviceList:(NSArray <BLDNADevice *>*)deviceList;
- (void)show;
- (void)dismiss;
@end
