//
//  FEIntergralDetailFirstCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEIntergralDeatialModel.h"
@interface FEIntergralDetailFirstCell : UITableViewCell

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *intergralCountLab;
@property(nonatomic,strong)UILabel *startAndendlab;
-(void)setupFirstCellWithModel:(FEIntergralDeatialModel *)model;

+(CGFloat)intergralCountFirstCellHeight;

@end
