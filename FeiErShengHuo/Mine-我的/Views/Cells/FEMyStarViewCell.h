//
//  FEMyStarViewCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/28.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FEStarModel.h"

@interface FEMyStarViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descripLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UILabel *totalLab;
@property(nonatomic,strong)UIImageView *goodsImageView;


-(void)setupCellWithModel:(FEStarModel *)model ;

@end
