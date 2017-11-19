//
//  FEGroupedAddressInfoCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupedAddressInfoCell.h"

@implementation FEGroupedAddressInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    _imageView=[MYUI creatImageViewFrame:CGRectZero imageName:@"Shopping_picture1"];
    [self addSubview:_imageView];
    
    _nameLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_nameLab];
    
    //价格
    _priceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _priceLab.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:_priceLab];
    
   //数量
    _numLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor colorWithHexString:@"#9c9c9c"] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_numLab];

}

-(void)setupCellWithModel:(FEGroupDetailModel*)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    _nameLab.text=model.title;
    CGFloat GropedF=model.marketPrice/100.0;
    _priceLab.text=[NSString stringWithFormat:@"¥%.2f",GropedF];
    _numLab.text=@"数量:1";

    _imageView.frame=CGRectMake(10, 10, 80, 80);
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.right).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(MainW-110);
        make.height.equalTo(20);
    }];
    
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-20);
        make.top.equalTo(_nameLab.bottom).offset(15);
        make.width.equalTo(MainW/2);
        make.height.equalTo(20);
    }];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab);
        make.top.equalTo(_priceLab.bottom).offset(15);
        make.width.equalTo(MainW/2);
        make.height.equalTo(20);
    }];

    
}


@end
