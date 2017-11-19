//
//  FECanshuTableViewCell.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/7/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDEGoodsDetailModel.h"

@interface FECanshuTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *pingpaiLab;

@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *placeLab;
@property(nonatomic,strong)UILabel *baozhuangLab;
@property(nonatomic,strong)UILabel *baozhuangfangfaLab;

@property(nonatomic,strong)FDEGoodsDetailModel *model;

@end
