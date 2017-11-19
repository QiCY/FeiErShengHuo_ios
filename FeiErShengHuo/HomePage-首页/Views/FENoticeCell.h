//
//  FENoticeCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FENoticeModel.h"

@interface FENoticeCell : UITableViewCell
@property(nonatomic,strong)UILabel *noticeDetailFirstLab;
@property(nonatomic,strong)UILabel *noticeDetailSecondLab;
@property(nonatomic,strong)UILabel *noticeTimeLab;

-(void)setupCellWithModel:(FENoticeModel *)model;
@end
