//
//  FEIntergralCollectionViewCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntergralCollectionViewCell.h"


@implementation FEIntergralCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
    
}
- (void)createUI{
    
    _intergralNameLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"5元改装灯优惠券" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_intergralNameLab];

    
    self.intergralCountLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"10000积分" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_intergralCountLab];
    
    //特价   优惠  type
    self.typeLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor redColor] text:@"特价" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.typeLab.layer.cornerRadius=5;
    self.typeLab.layer.masksToBounds=YES;
    self.typeLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.typeLab];

    
    
    
    self.intergralImageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    self.intergralImageView.image=[UIImage imageNamed:@"exchange_ticket1"];//Image(@"intergralImageView");

    [self addSubview:self.intergralImageView];
    
    
    [_intergralNameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(10);
        make.width.equalTo(self.frame.size.width-12);
        make.height.equalTo(10);
        
    }];
    
    [_intergralCountLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.intergralNameLab.bottom).offset(10);
        make.width.equalTo(self.frame.size.width/2);
        make.height.equalTo(20);
        
    }];
    
    [_typeLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.intergralCountLab.right).offset(10);
        make.centerY.equalTo(self.intergralCountLab);
        make.width.equalTo(50);
        make.height.equalTo(20);
        
    }];
    
    [_intergralImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(20);
        make.top.equalTo(self.intergralCountLab.bottom).offset(5);
        make.width.equalTo(self.frame.size.width-40);
        make.height.equalTo(self.frame.size.width-40);
    }];
}

-(void)setupCellWithModel:(FEIntegralModel *)model
{
    self.intergralNameLab.text=model.integralGoodTitle;
    self.intergralCountLab.text=[NSString stringWithFormat:@"%@积分",model.integralCredit];
    self.typeLab.text=model.intgralGoodType;
    [self.intergralImageView sd_setImageWithURL:[NSURL URLWithString:model.integralGoodUrl]];
    
    
}
@end
