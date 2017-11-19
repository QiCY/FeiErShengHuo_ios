//
//  FEGoodCarCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FECarGoodsModel.h"
@class FEGoodCarCell;

@protocol ShoppingSelectedDelegate <NSObject>

-(void)SelectedConfirmCell:(UITableViewCell *)cell;
-(void)SelectedCancelCell:(UITableViewCell *)cell;

-(void)ChangeGoodsNumberCell:(UITableViewCell *)cell Number:(NSInteger)num;
@end


@interface FEGoodCarCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descripLab;
@property(nonatomic,strong)UILabel *priceLab;
@property(nonatomic,strong)UILabel *totalLab;
@property(nonatomic,strong)UIButton *goodsImageView;


/**
 *  下单数量
 */
@property (nonatomic, retain)PPNumberButton *Goods_NBCount;

@property(nonatomic,strong)UIButton *selectBtn;
@property (nonatomic, weak)id<ShoppingSelectedDelegate> SelectedDelegate;


-(void)setupCellWithModel:(FECarGoodsModel *)model;

@end
