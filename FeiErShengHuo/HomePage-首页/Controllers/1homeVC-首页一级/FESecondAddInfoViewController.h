//
//  FESecondAddInfoViewController.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEphotoCell.h"
#import "ZYQAssetPickerController.h"
#import "FEShengViewController.h"

#import "RYImagePreViewController.h"

@interface FESecondAddInfoViewController : FEBaseViewController
@property(nonatomic,strong)UILabel *typeLab;


@property(nonatomic,strong)UITextField *nameTF;
@property(nonatomic,strong)UITextField *phoneTF;

@property(nonatomic,strong)UILabel *regionLab;
@property(nonatomic,strong)UITextField *buildingNumTF;
@property(nonatomic,strong)UITextField *unitNumTF;
@property(nonatomic,strong)UITextField *roomNumTF;


@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, strong) NSMutableDictionary *imageUrlArrDic;
//@property (nonatomic, strong) RYImagePreViewController *previewController;
@end
