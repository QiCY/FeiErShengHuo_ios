//
//  FENeighberDetailController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/21.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEDynamicModel.h"
#import "RYImagePreViewController.h"
@class FENeighberDetailController;

@protocol commentCoutdelegete <NSObject>

-(void)refreshCommentCount:(NSNumber *)count AndIndex :(NSIndexPath *)path;


@end

@interface FENeighberDetailController : FEBaseViewController

{
    CGFloat titleW;
}


@property(nonatomic,strong)FEDynamicModel *curDModel;
@property (nonatomic, strong) UIButton *headBtn;
@property (nonatomic, strong) UILabel *nameLab;
@property(nonatomic,strong)UILabel *timeDetailLab;
@property(nonatomic,strong)UILabel *FENeighberContantLab;//  发布内容
@property(nonatomic,strong)UIImageView *AddressImageView;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UICollectionView *collections;
@property(nonatomic,assign)CGFloat height;

@property(nonatomic,strong)NSIndexPath *indexpath;

@property(nonatomic,strong)id<commentCoutdelegete>delegete;


//tou

@property (nonatomic, strong) UIImageView *headImageView;


@property(nonatomic,strong)UIButton *zanBtn;
@property(nonatomic,strong)UIButton *commentBtn;

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *nineImageView;

@end
