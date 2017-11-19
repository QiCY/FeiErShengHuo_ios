//
//  FEActivityCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEAvtivityModel.h"

@interface FEActivityCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *stuseLab;

-(void)setupCellWithModel:(FEAvtivityModel *)model;
@end
