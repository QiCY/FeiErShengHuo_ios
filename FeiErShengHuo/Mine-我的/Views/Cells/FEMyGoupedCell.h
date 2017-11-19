//
//  FEMyGoupedCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEPersontuanModel.h"

@interface FEMyGoupedCell : UITableViewCell
{
    UILabel *_odercodeLab;
    UIImageView *_goodimageView;
    UILabel *_titleLab;
    UILabel *_priceLab;
    
    UILabel *_totlalAndPrioceLab;
    
}

 -(void)setupCellWithModel:(FEPersontuanModel *)model;
@end
