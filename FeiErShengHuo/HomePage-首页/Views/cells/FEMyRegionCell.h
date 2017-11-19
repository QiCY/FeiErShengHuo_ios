//
//  FEMyRegionCell.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEMyRegionModel.h"
@interface FEMyRegionCell : UITableViewCell

@property(nonatomic,strong)FEMyRegionModel *model;
@property(nonatomic,strong)UILabel *RegionNameLab;
@property(nonatomic,strong)UILabel *BuldingLab;
@property(nonatomic,strong)UILabel *stusLab;


@end
