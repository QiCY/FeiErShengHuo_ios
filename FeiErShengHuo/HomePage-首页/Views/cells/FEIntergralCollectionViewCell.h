//
//  FEIntergralCollectionViewCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEIntegralModel.h"

@interface FEIntergralCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *intergralNameLab;
@property(nonatomic,strong)UILabel *intergralCountLab;
@property(nonatomic,strong)UILabel *typeLab;

@property(nonatomic,strong)UIImageView *intergralImageView;

-(void)setupCellWithModel:(FEIntegralModel *)model;
@end
