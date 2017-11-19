//
//  FERecordCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FERecordModel.h"

@interface FERecordCell : UITableViewCell

@property(nonatomic,strong)UIImageView *leftimageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *stuseLab;

-(void)setupCellWithModel:(FERecordModel *)model;
@end
