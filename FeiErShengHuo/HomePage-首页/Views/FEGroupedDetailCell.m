//
//  FEGroupedDetailCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupedDetailCell.h"
#import "FEGroupedPlayWayView.h"

@implementation FEGroupedDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    //标题
    self.titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] numberOfLines:2 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.titleLab];
    // 描述
    self.descriptionLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:RGB(68, 69, 70) font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.descriptionLab];
    // 已售
    self.payNumLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:RGB(68, 69, 70) font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.payNumLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.payNumLab];
    //说明
   
    self.explainLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:RGB(162, 9, 13) font:[UIFont systemFontOfSize:14] numberOfLines:2 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.explainLab];
    
    //团购image
    self.groupImageView=[MYUI creatImageViewFrame:CGRectZero imageName: @"bg_buy1"];
    
    [self addSubview:self.groupImageView];
    // 右边
    self.personBuyImageView=[MYUI creatImageViewFrame:CGRectZero imageName: @"bg_buy2"];
    [self addSubview:self.personBuyImageView];
    
    //团购lab
   
    _groupPrice=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"¥12/件" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goupedBuy:)];
//    _groupPrice.userInteractionEnabled=YES;
//    [_groupPrice addGestureRecognizer:tap];
    [_groupImageView addSubview:_groupPrice];
    
    _fiveLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"5人团" textColor:[UIColor whiteColor]font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    //UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goupedBuy:)];
    _fiveLab.userInteractionEnabled=YES;
    //[_fiveLab addGestureRecognizer:tap];
    [self addSubview:_fiveLab];

    
    _personPrice=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"¥12/件" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [_personBuyImageView addSubview:_personPrice];
    
    
    UILabel *personLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"单独购买" textColor:[UIColor whiteColor]font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:personLab];
    
    
    //玩法
    _playWay=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text: @"拼团玩法" textColor:RGB(85, 85, 85) font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_playWay];
    
    _playWayDeatilLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text: @"" textColor:RGB(85, 85, 85) font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _playWayDeatilLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_playWayDeatilLab];
    
    _palView=[[FEGroupedPlayWayView alloc]init];
    [self addSubview:_palView];
    
    _grayLineLab=[[UILabel alloc]init];
    _grayLineLab.backgroundColor=Colorgrayall239;
    [self addSubview:_grayLineLab];
    
    btn1=[[UIButton alloc]initWithFrame:CGRectZero];
    btn1.backgroundColor=[UIColor clearColor];
    
    [btn1 addTarget:self action:@selector(goupedBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
    
    
    btn2=[[UIButton alloc]initWithFrame:CGRectZero];
    btn2.backgroundColor=[UIColor clearColor];
    
    [btn2 addTarget:self action:@selector(oneBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn2];
  
    //团购和单人布局
    
    [_groupPrice makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(_groupImageView);
        make.centerY.equalTo(_groupImageView).offset(-70/4);
        
    }];
    [_personPrice makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(_personBuyImageView);
        make.centerY.equalTo(_personBuyImageView).offset(-70/4);
        
    }];
    [_fiveLab makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(_groupImageView);
        make.centerY.equalTo(_groupImageView).offset(70/4);
        
    }];
    [personLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_personBuyImageView);
         make.centerY.equalTo(_personBuyImageView).offset(70/4);
        
    }];
}

-(void)goupedBuy:(UIButton *)btn
{
    if (self.block) {
        self.block(btn);
        
    }
}

-(void)oneBuy:(UIButton *)btn
{
    if (self.oblock) {
        self.oblock(btn);
        
    }
}


-(void)setUpCellWithModel:(FEGroupDetailModel *)model
{
    _titleLab.text=model.title;
    _descriptionLab.text=model.descrip;
    _payNumLab.text=[NSString stringWithFormat:@"已售%@份",model.payNum];
    _fiveLab.text=[NSString stringWithFormat:@"%@人团",model.num];
    
    
    self.explainLab.text=[NSString stringWithFormat:@"支付开团并邀请%ld人开团，人数不够自动退款详情下方拼团玩法",[model.num integerValue]-1];
    
    
    CGFloat goupF=model.marketPrice/100.0;
    _groupPrice.text=[NSString stringWithFormat:@"¥%.2f/件",goupF];
    
    
    CGFloat personF=model.productPrice/100.0;
    _personPrice.text=[NSString stringWithFormat:@"¥%.2f/件",personF];

    //计算title 的 高度
    CGFloat titleHeight=[model.title heightWithFont:[UIFont systemFontOfSize:16] constrainedToWidth:MainW-10];
    CGFloat descripHeight=[model.descrip heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-10];
    _titleLab.frame=CGRectMake(5,5,MainW-10, titleHeight);
    _descriptionLab.frame=CGRectMake(5, CGRectGetMaxY(self.titleLab.frame)+5, MainW-10, descripHeight);
    _payNumLab.frame=CGRectMake(5, CGRectGetMaxY(self.descriptionLab.frame)+5,MainW-10, 12);
    _explainLab.frame=CGRectMake(5, CGRectGetMaxY(_payNumLab.frame)+5, MainW-10, 40);
    _groupImageView.frame=CGRectMake(5, CGRectGetMaxY(_explainLab.frame)+5, MainW/2-5-2.5, 70);
    btn1.frame=CGRectMake(5, CGRectGetMaxY(_explainLab.frame)+5, MainW/2-5-2.5, 70);
     btn2.frame=CGRectMake(MainW/2, CGRectGetMaxY(_explainLab.frame)+5, MainW/2-5-2.5, 70);
    
    
    _personBuyImageView.frame=CGRectMake(MainW/2+2.5, CGRectGetMaxY(_explainLab.frame)+5, MainW/2-5-2.5, 70);
    
    _playWay.frame=CGRectMake(10, CGRectGetMaxY(_groupImageView.frame)+45, MainW/2, 20);
    [_playWayDeatilLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_playWay);
        make.width.equalTo(MainW/3);
        make.right.equalTo(self.right);

    }];
    _palView.frame=CGRectMake(0, CGRectGetMaxY(_playWay.frame)+10, MainW, 60);
    
    //线条
     _grayLineLab.frame=CGRectMake(0, CGRectGetMaxY(_groupImageView.frame)+13, MainW, 15);
    
}

+(CGFloat)countHeigthWith:(FEGroupDetailModel *)model
{
    //计算title 的 高度
    CGFloat titleHeight=[model.title heightWithFont:[UIFont systemFontOfSize:16] constrainedToWidth:MainW-10];
    CGFloat descripHeight=[model.descrip heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-10];
    return titleHeight+descripHeight+30+15+40+70+200;
}

@end
