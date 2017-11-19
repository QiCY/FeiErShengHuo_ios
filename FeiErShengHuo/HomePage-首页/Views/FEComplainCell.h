//
//  FEComplainCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEadviceModel.h"

@interface FEComplainCell : UITableViewCell
@property(nonatomic,strong)UILabel *complaintTitleLab;

@property(nonatomic,strong)UILabel *statusLab;
@property(nonatomic,strong)UILabel *complaintDetailSecondLab;
@property(nonatomic,strong)UILabel *complaintTimeLab;

-(void)setupCellWithModel:(FEadviceModel *)model;
@end
