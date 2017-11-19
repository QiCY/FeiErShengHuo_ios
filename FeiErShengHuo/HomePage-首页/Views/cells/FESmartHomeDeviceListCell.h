//
//  FESmaetHomeDeviceListCell.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLDNADevice.h"

@interface FESmartHomeDeviceListCell : UICollectionViewCell

- (void)refreshCellWithDevice:(BLDNADevice *)device;

@end
