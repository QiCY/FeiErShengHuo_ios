//
//  FEInterstingCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEINterstingModel.h"

@interface FEInterstingCell : UITableViewCell

{
    UIImageView *_imageView;
    
    UILabel *_themeLab;
    
    UILabel *_DescripLab;
    
    
}


-(void)setupCellWithModel:(FEINterstingModel *)model;
@end
