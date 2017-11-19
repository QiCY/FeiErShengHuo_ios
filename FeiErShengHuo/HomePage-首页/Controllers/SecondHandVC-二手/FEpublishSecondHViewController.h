//
//  FEpublishSecondHViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/29.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "YHJTextView.h"
#import "RYImagePreViewController.h"
#import "ZYQAssetPickerController.h"


#import "FEphotoCell.h"


@interface FEpublishSecondHViewController : FEBaseViewController

{
    YHJTextView *_textView;
    UITextField *_originPriceTF;
    UITextField *_nowPriceTF;
    UITextField *_qulityTF;
     UITextField *_conectPeopleTF;
     UITextField *_conectMoblieTF;
    
    
}


@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSMutableDictionary *imageUrlArrDic;
@property (nonatomic, strong) RYImagePreViewController *previewController;

@end
