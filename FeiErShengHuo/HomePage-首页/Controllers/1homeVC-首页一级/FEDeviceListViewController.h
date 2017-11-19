//
//  FEDeviceListViewController.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "SDBaseTableViewController.h"

@interface FEDeviceListViewController : SDBaseTableViewController

@property (nonatomic,copy) void (^didSelectDevice) (BLDNADevice *device);
@property (nonatomic,assign) BOOL isSelectSwitch;

@end
