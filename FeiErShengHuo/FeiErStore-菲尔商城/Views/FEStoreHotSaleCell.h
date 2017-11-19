//
//  FEStoreHotSaleCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/25.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEGoodModel.h"

typedef void(^goCarClickBlock)(UIButton *btn);

@interface FEStoreHotSaleCell : UITableViewCell
@property(nonatomic,strong)UIImageView *hotImageView;
@property(nonatomic,strong)UILabel *hotNameLab;
@property(nonatomic,strong)UILabel *describeLab;
@property(nonatomic,strong)UILabel *HotPriceLab;
@property(nonatomic,strong)UIButton *goCarimageView;
//@property(nonatomic,copy)godetalBlock block;

@property(nonatomic,copy)goCarClickBlock block;
+(CGFloat)countFirstHotSaleHeight;

-(void)setUpCellWithModel:(FEGoodModel *)model;




@end
