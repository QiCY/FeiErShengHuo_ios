//
//  FEGoodsCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/25.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEGoodModel.h"

@interface FEGoodsCell : UITableViewCell
{
    CGFloat limitLabwidth;
    CGFloat originLwidth;
    CGFloat originLYwidth;
    
    UILabel *_originLab;
    
}

@property(nonatomic,strong)UIImageView *limitImageView;
@property(nonatomic,strong)UILabel *limitNameLab;
@property(nonatomic,strong)UILabel *limitdescribeLab;
@property(nonatomic,strong)UILabel *limitPriceLab;

@property(nonatomic,strong)UILabel *origirnPriceLab;

@property(nonatomic,strong)UIButton *goRobBtn;

+(CGFloat)countSecondHotSaleHeight;


-(void)setUpCellWithModel:(FEGoodModel *)model;

@end
