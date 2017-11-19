//
//  FESmallListCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/26.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FESmallNoticeModel.h"

@interface FESmallListCell : UITableViewCell
{
    UIView *_statusLab;
    UIImageView *_imageView;
    UILabel *_titleLab;
    
}

-(void)setupCellWithModel:(FESmallNoticeModel *)model;
@end
