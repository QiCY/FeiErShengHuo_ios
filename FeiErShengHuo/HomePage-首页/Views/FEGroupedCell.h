//
//  FEGroupedCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEgroupBuyModel.h"
typedef void(^goparticipationBtnBlock)(UIButton *);

@interface FEGroupedCell : UITableViewCell
@property(nonatomic,strong)UIImageView *goodImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descriptionLab;

@property(nonatomic,strong)UIView *whiteView;
@property(nonatomic,strong)UILabel *endLab;
@property(nonatomic,strong)UILabel *numLab;
@property(nonatomic,strong)UILabel *priceLab;

@property(nonatomic,strong)UIButton *participationBtn;
@property(nonatomic,strong)UIImageView  *circleImageView;

@property(nonatomic,copy)goparticipationBtnBlock block;


-(void) setUpCellWithModel:(FEgroupBuyModel *)model;

+(CGFloat)countHeightWithModel:(FEgroupBuyModel *)model;

@end
