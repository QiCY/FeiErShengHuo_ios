//
//  FEMyGoupedCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEMyGoupedCell.h"

@implementation FEMyGoupedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    
    _odercodeLab=[MYUI createLableFrame:CGRectMake(0,0, MainW, 40) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _odercodeLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_odercodeLab];
    
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, MainW, 100)];
    bgView.backgroundColor=RGB(235, 234, 234);
    [self addSubview:bgView];
    
    _goodimageView=[MYUI creatImageViewFrame:CGRectMake(10, 10, 80, 80) imageName:@"Shopping_picture1"];
    [bgView addSubview:_goodimageView];
    
    _titleLab=[MYUI createLableFrame:CGRectMake(100, 10, MainW-10-100, 40) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]  numberOfLines:2 adjustsFontSizeToFitWidth:NO];
    [bgView addSubview:_titleLab];
    
    //价格
    _priceLab=[MYUI createLableFrame:CGRectMake(MainW-10-50, CGRectGetMaxY(_titleLab.frame)+5, 50, 20) backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _priceLab.textAlignment=NSTextAlignmentRight;
    [bgView addSubview:_priceLab];
    

    //数量
    _totlalAndPrioceLab=[MYUI createLableFrame:CGRectMake(0, 140, MainW, 40) backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _totlalAndPrioceLab.textAlignment=NSTextAlignmentCenter;
    
    [self addSubview:_totlalAndPrioceLab];

}

 -(void)setupCellWithModel:(FEPersontuanModel *)model
{
    _odercodeLab.text=[NSString stringWithFormat:@"订单编号：%@",model.tuanSn];//model.tuanSn;
    [_goodimageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    _titleLab.text=model.title;
    CGFloat F=model.marketPrice/100.0;
    _priceLab.text=[NSString stringWithFormat:@"¥%.2f",F];
    _totlalAndPrioceLab.text=[NSString stringWithFormat:@"共1件商品 合计¥%.2f（含配送费0.00）",F];
    
    
}

@end
