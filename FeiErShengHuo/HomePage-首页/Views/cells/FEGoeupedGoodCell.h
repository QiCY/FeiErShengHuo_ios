//
//  FEGoeupedGoodCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEGroupDetailModel.h"

@interface FEGoeupedGoodCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_nameLab;
    
    UILabel *_priceLab;
    
    UILabel *_numLab;
    
    
}
-(void)setupCellWithModel:(FEGroupDetailModel *)model;
@end
