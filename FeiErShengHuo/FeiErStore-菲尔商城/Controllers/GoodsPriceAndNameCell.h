//
//  GoodsPriceAndNameCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDEGoodsDetailModel.h"

@class GoodsPriceAndNameCell;
@protocol GoodsPriceAndNameCelldelegete  <NSObject>

-(void)startClick;
-(void)cancelStartClick;

@end

@interface GoodsPriceAndNameCell : UITableViewCell

{
    BOOL _Selected;
    
}
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UILabel *salesPromotionLab;

@property(nonatomic,strong)UILabel *originPriceLab;
@property(nonatomic,strong)UILabel *despatchMoneyLab;
@property(nonatomic,strong)UILabel *salesVolumeLab;
@property(nonatomic,strong)UIButton *heartStarBtn;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,weak)id<GoodsPriceAndNameCelldelegete>delegete;



+(CGFloat)CountHeight;

-(void)setupCellWithModel:(FDEGoodsDetailModel *)model;


@end
