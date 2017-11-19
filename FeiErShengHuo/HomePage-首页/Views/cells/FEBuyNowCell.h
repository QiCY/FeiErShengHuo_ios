//
//  FEBuyNowCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEGoodModel.h"
#import "FEOderModel.h"

@interface FEBuyNowCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descripLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UILabel *totalLab;
@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UIImageView *goodsImageView;


@property(nonatomic,strong)FEOderModel *model;

@property(nonatomic,strong)FEGoodModel *goodModel;




//-(void)setupCellWithModel:(FEGoodModel *)model ;
//-(void)setupOderCellWithModel:(FEOderModel *)model ;


@end
