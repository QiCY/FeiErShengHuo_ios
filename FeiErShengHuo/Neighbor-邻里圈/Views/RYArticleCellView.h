//
//  RYArticleCellView.h
//  CCICPhone
//
//  Created by apple on 15/6/23.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEDynamicModel.h"

@interface RYArticleCellView : UIView

@property (nonatomic, strong) UILabel *titLbl;
@property (nonatomic, strong) UIImageView *articleImg;
@property (nonatomic, strong) UILabel *sumaryLbl;

-(void)setUpArticleModel:(FEDynamicModel *)dymodel;
@end
