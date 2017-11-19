//
//  FEphotoCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEPictureModel.h"

@interface FEphotoCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView  *imageView;

-(void)setUpCellWithModel:(FEPictureModel *)picModel;


@end
