//
//  GoodsPriceAndNameCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "GoodsPriceAndNameCell.h"

@implementation GoodsPriceAndNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUP];
    }
    return self;
}
-(void)setUP
{
    _Selected=NO;
    self.nameLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor blackColor] font:[UIFont fontWithName:@"Helvetica-Bold" size:15] numberOfLines:0 adjustsFontSizeToFitWidth: NO];
    [self addSubview: self.nameLab];
    
    self.priceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"¥46.80" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:20] numberOfLines:0 adjustsFontSizeToFitWidth: YES];
    [self addSubview:self.priceLab];
    
    _salesPromotionLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"大促限时抢" textColor:RGB(255,158,47) font:[UIFont systemFontOfSize:12]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _salesPromotionLab.layer.cornerRadius=3;
    _salesPromotionLab.layer.masksToBounds=YES;
    _salesPromotionLab.layer.borderWidth=1;
    _salesPromotionLab.layer.borderColor=RGB(255,158,47).CGColor;
    _salesPromotionLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_salesPromotionLab];
    
    _originPriceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:RGB(132,133,134) font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_originPriceLab];
    
    _despatchMoneyLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:RGB(132,133,134) font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_despatchMoneyLab];
    
    _salesVolumeLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:RGB(132,133,134) font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _salesVolumeLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_salesVolumeLab];
    
    _heartStarBtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusTop];
    [_heartStarBtn setImage:[UIImage imageNamed:@"icon_heart_normal"] forState:UIControlStateNormal];
    [_heartStarBtn addTarget:self action:@selector(starClick) forControlEvents:UIControlEventTouchUpInside];
    [_heartStarBtn setTitle:@"收藏" forState:UIControlStateNormal];
    _heartStarBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_heartStarBtn setTitleColor:RGB(132, 133, 134) forState:UIControlStateNormal];
    [self addSubview:_heartStarBtn];
    
    
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 40)];
    UIButton *Btn1=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusCenterImageLeft];
    //UIButton *Btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [Btn1 setImage:[UIImage imageNamed:@"[Details]-Circle_hook"] forState:0];
    [Btn1 setTitle:@"卖家承诺72小时发货" forState:UIControlStateNormal];
    [Btn1 setTitleColor:RGB(132, 133, 134) forState:0];
    Btn1.titleLabel.font=[UIFont systemFontOfSize:14];
    Btn1.frame=CGRectMake(-16.5, 0, MainW/2, 40);
    
    [_bottomView addSubview:Btn1];
    
//    //UIButton *Btn2=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusNormal];
//    UIButton *Btn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    [Btn2 setImage:[UIImage imageNamed:@"[Details]-Circle_hook"] forState:0];
//    [Btn2 setTitle:@"订单险" forState:UIControlStateNormal];
//    Btn2.titleLabel.font=[UIFont systemFontOfSize:14];
//    [Btn2 setTitleColor:RGB(132, 133, 134) forState:0];
//    Btn2.frame=CGRectMake(MainW/2, 0, MainW/2, 40);
//    [_bottomView addSubview:Btn2];
    [self addSubview:self.bottomView];
    
}

-(void)starClick
{
     _Selected = !_Selected;
    if (_Selected) {
        [self.delegete startClick];
        [_heartStarBtn setImage:Image(@"[Details]-Already_collection") forState:UIControlStateNormal];
    }else{
        [self.delegete cancelStartClick];
        [_heartStarBtn setImage:Image(@"icon_heart_normal") forState:UIControlStateNormal];
    }
}
-(void)setupCellWithModel:(FDEGoodsDetailModel *)model
{
    _nameLab.text=model.title;
    // 现价
    CGFloat maketprice=model.marketPrice/100.0;
    
    //CGFloat Gmaketprice=maketprice/100;
    
    _priceLab.text=[NSString stringWithFormat:@"¥%.2f",maketprice];
    //原价
    CGFloat P=model.productPrice;
    
    CGFloat Fprice=P/100;

    NSString * priceStr=[NSString stringWithFormat:@"¥%.2f",Fprice];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:priceStr attributes:attribtDic];
    _originPriceLab.attributedText = attribtStr; //
    _despatchMoneyLab.text=[NSString stringWithFormat:@"快递:%@",model.expressDelivery];
    _salesVolumeLab.text=[NSString stringWithFormat:@"月销%@笔",model.sales];
    
}

+(CGFloat)CountHeight{
    CGFloat height=45+5+20+30+10+15+40;
    return height;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(0);
        make.width.equalTo(MainW-70);
        make.height.equalTo(45);
    }];
    
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.nameLab.bottom).offset(5);
        make.width.equalTo(70);
        make.height.equalTo(20);
    }];
    
    [_salesPromotionLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.right).offset(8);
        make.top.equalTo(self.priceLab.top).offset(3);
        make.width.equalTo(80);
        make.height.equalTo(15);
    }];
    [_originPriceLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.priceLab.bottom).offset(5);
        make.width.equalTo(MainW/2);
        make.height.equalTo(20);
    }];
    
    [_despatchMoneyLab  makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.originPriceLab.bottom).offset(5);
        make.left.equalTo(self.nameLab);
        make.height.equalTo(20);
        make.width.equalTo(MainW/2);
        
    }];
    
    [_salesVolumeLab  makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.despatchMoneyLab.top);
        make.height.equalTo(20);
        make.width.equalTo(100);
        
    }];
    
    [_heartStarBtn  makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(self.top).offset(10);
        make.height.equalTo(60);
        make.width.equalTo(60);
        
    }];
    
    [_bottomView  makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(0);
        make.top.equalTo(self.salesVolumeLab.bottom).offset(15);
        make.height.equalTo(40);
        make.width.equalTo(MainW);
        
    }];
}

@end
