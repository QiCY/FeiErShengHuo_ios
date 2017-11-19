//
//  FEMyStarViewCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/28.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEMyStarViewCell.h"

@implementation FEMyStarViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    self.goodsImageView=[MYUI creatImageViewFrame:CGRectZero imageName:@""];
    [self addSubview:self.goodsImageView];
    
    self.titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.titleLab];
    
    self.descripLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.descripLab];
    
    self.priceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.priceLab];
    
//    self.totalLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"1" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
//    [self addSubview:self.totalLab];
    
}


-(void)setupCellWithModel:(FEStarModel *)model

{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.goodThumb]];
    self.titleLab.text=model.goodsTitle;
    self.descripLab.text=model.goodsDescription;
    
    
    
    CGFloat fprice=[model.productPrice integerValue]/100;
    self.priceLab.text=[NSString stringWithFormat:@"¥%.2f",fprice];
    
    _goodsImageView.frame=CGRectMake(30, 10, 80, 80);
    _titleLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, 10, MainW-140, 40);
    _descripLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15, MainW-110, 20);
    _priceLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15,100, 20);
    //_totalLab.frame=CGRectMake(CGRectGetMaxX(_priceLab.frame), CGRectGetMinY(_priceLab.frame), 60, 20);
    
    
}


@end
