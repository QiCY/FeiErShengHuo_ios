//
//  FEAddinfoViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEphotoCell.h"
#import "ZYQAssetPickerController.h"
#import "FEShengViewController.h"

#import "RYImagePreViewController.h"

@interface FEAddinfoViewController : FEBaseViewController
//
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
@property (nonatomic, strong) RYImagePreViewController *previewController;

@end
