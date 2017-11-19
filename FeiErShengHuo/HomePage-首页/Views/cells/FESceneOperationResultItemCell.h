//
//  FESceneOperationResultItemCell.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/25.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLDNADevice.h"

@interface FESceneOperationResultItemCell : UITableViewCell

/// 0.未执行   1.成功    2.失败
- (void)refreshCellWithDevice:(BLDNADevice *)device index:(NSInteger)index result:(NSInteger)result;

@end
