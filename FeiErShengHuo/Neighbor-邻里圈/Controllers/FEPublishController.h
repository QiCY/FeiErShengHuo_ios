//
//  FEPublishController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "ZYQAssetPickerController.h"
#import "HPGrowingTextView.h"
#import "RYImagePreViewController.h"

@interface FEPublishController : FEBaseViewController
<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,
HPGrowingTextViewDelegate,UIImagePickerControllerDelegate,RYImagePreViewControllerDelegate>
{
    CGFloat cellWidth;
    CGFloat keyboardHeight;
    NSTimeInterval animationDuration;
    NSInteger curType;
    BOOL hasShowFaceboard;
    NSInteger currentSelectNum;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HPGrowingTextView *textView;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) RYImagePreViewController *previewController;

@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSMutableDictionary *imageUrlArrDic;

@end
