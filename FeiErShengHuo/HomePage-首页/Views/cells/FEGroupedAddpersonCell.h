//
//  FEGroupedAddpersonCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEgroupedDetailModel.h"

@interface FEGroupedAddpersonCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_nameLab;
    
    UILabel *_datelineLab;
    
  
    
    
}
-(void)setupCellWithModel:(FEgroupedDetailModel *)model;

@end
