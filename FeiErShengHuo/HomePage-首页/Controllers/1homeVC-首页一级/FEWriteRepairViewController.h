//
//  FEWriteRepairViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "ZYQAssetPickerController.h"
#import "HPGrowingTextView.h"
#import "RYImagePreViewController.h"

@interface FEWriteRepairViewController : FEBaseViewController
{
    CGFloat cellWidth;
    NSInteger currentSelectNum;
}
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) RYImagePreViewController *previewController;
@property (nonatomic, strong) NSMutableDictionary *imageUrlArrDic;
@end
