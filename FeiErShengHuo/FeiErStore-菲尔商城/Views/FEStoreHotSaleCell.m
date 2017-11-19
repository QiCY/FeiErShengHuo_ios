//
//  FEStoreHotSaleCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/25.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEStoreHotSaleCell.h"

@implementation FEStoreHotSaleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI

{
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0,0, MainW, 1)];
    lineView.backgroundColor=RGB(239, 239, 239);
    [self addSubview:lineView];
    
    
    self.hotImageView=[MYUI creatImageViewFrame:CGRectZero imageName:@"Shopping_picture2"];
    [self addSubview:self.hotImageView];
    
    self.hotNameLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.hotNameLab];
    
    self.describeLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"农场自产特级金星山楂" textColor:[UIColor colorWithHexString:@"#9c9c9c"] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.describeLab];
    
    
    self.HotPriceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"¥32.00" textColor:[UIColor colorWithHexString:@"#ff0000"] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.HotPriceLab];
    
    self.goCarimageView=[[UIButton alloc]init];
    //[MYUI creatImageViewFrame:CGRectZero imageName:@"icon_Shopping_Cart2"];
    [self.goCarimageView setBackgroundImage:[UIImage imageNamed:@"icon_Shopping_Cart2"] forState:0];
    
    [self.goCarimageView addTarget:self action:@selector(godetailClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.goCarimageView.layer.cornerRadius=35/2;
    self.goCarimageView.layer.masksToBounds=YES;
    
    [self addSubview:self.goCarimageView];
}

+(CGFloat)countFirstHotSaleHeight{
    return 100;
    
}

-(void)godetailClick:(UIButton *)sender
{
    sender.tag=self.tag;
    
    if (self.block) {
        self.block(sender);
        
    }
}

-(void)setUpCellWithModel:(FEGoodModel *)model
{
    [_hotImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    _hotNameLab.text=model.title;
    _describeLab.text=model.descrip;
    
    NSInteger Iprice=model.marketprice; //model.price
    CGFloat fprice=Iprice/100.0;
    self.HotPriceLab.text=[NSString stringWithFormat:@"¥%.2f",fprice];
    
}

-(void)layoutSubviews
{
    [_hotImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(10);
        make.height.equalTo(80);
        make.width.equalTo(80);
    }];
    
    [_hotNameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotImageView.right).offset(10);
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(40);
    }];
    
    [_describeLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotImageView.right).offset(10);
        make.top.equalTo(self.hotNameLab.bottom).offset(15);
        make.width.equalTo(MainW/2);
        make.height.equalTo(12);
    }];
    
    [_HotPriceLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hotImageView.right).offset(10);
        make.top.equalTo(self.hotNameLab.bottom).offset(15);
        make.width.equalTo(MainW/2);
        make.height.equalTo(16);
    }];
    
    [_goCarimageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-20);
        make.centerY.equalTo(self.centerY).offset(20);
        make.width.equalTo(35);
        make.height.equalTo(35);
    }];
    
    
}

@end
