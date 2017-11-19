//
//  FERepairDtailViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/4.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FERepirModel.h"
#import "PHCell.h"
@interface FERepairDtailViewController : FEBaseViewController
@property(nonatomic,strong)FERepirModel *RModel;
@property (nonatomic, strong) UICollectionView *photoCollectionView;

@end
