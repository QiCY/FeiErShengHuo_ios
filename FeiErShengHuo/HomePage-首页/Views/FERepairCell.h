//
//  FERepairCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FERepirModel.h"

@interface FERepairCell : UITableViewCell
@property(nonatomic,strong)UILabel *repairTitleLab;

@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *repairDetailSecondLab;
@property(nonatomic,strong)UILabel *repairTimeLab;

-(void)setupCellWithModel:(FERepirModel *)model;
@end
