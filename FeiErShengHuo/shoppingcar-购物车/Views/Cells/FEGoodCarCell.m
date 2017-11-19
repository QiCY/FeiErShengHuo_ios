//
//  FEGoodCarCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGoodCarCell.h"

@interface FEGoodCarCell ()
{
    NSString *Selected;
}
@end

@implementation FEGoodCarCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    
    _selectBtn=[MYUI creatButtonFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"check_box_nor"]];
    _selectBtn.layer.masksToBounds=YES;
    _selectBtn.layer.cornerRadius=5;
    
    [_selectBtn addTarget:self action:@selector(Selected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectBtn];
                
    self.goodsImageView=[UIButton buttonWithType:UIButtonTypeCustom];
    
   [self.goodsImageView addTarget:self action:@selector(Selected) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
    [self addSubview:self.goodsImageView];
    
    self.titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.titleLab];
    
    self.descripLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.descripLab];
    _Goods_NBCount.hidden=YES;
    
    self.priceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.priceLab];
    
    self.totalLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"1" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.totalLab];
    
    
    _Goods_NBCount = [[PPNumberButton alloc]init];
    _Goods_NBCount.borderColor = [UIColor grayColor];
    _Goods_NBCount.increaseTitle = @"＋";
    _Goods_NBCount.decreaseTitle = @"－";
    WeakSelf;
    _Goods_NBCount.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        StrongSelf;
        [strongSelf.SelectedDelegate ChangeGoodsNumberCell:strongSelf Number:num];
    };
    [self addSubview:_Goods_NBCount];
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 99, MainW, 1)];
    secView.backgroundColor =[UIColor clearColor];
    [self addSubview:secView];
}
-(void)setupCellWithModel:(FECarGoodsModel *)model  
{
    //得到选中的状态
    Selected = model.isChose;
    if ([Selected isEqualToString:@"0"]) {
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"check_box_nor"] forState:UIControlStateNormal];
        
    }else
    {
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"check_box_sel"] forState:UIControlStateNormal];
    }
    NSString *ishidden=model.ishidden;
    if ([ishidden isEqualToString:@"0"]) {
        _Goods_NBCount.hidden=YES;
        _descripLab.hidden=NO;
    }
    else
    {
        _Goods_NBCount.hidden=NO;
        _descripLab.hidden=YES;
    }
    
    [self.goodsImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.thumb]]] forState:0];
    self.titleLab.text=model.title;
    self.descripLab.text=model.descrip;
     _Goods_NBCount.currentNumber = [model.total integerValue];
    self.totalLab.text=[NSString stringWithFormat:@"x%@",model.total];
    
    CGFloat Iprice=[model.marketPrice integerValue]/100.0;//model.price
   // CGFloat fprice=Iprice/100.0;
    self.priceLab.text=[NSString stringWithFormat:@"¥%.2f",Iprice];
    
    _selectBtn.frame=CGRectMake(10, 100/2-10, 20, 20);
    
    _goodsImageView.frame=CGRectMake(30, 10, 80, 80);
    _titleLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, 10, MainW-120, 40);
    _descripLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15, MainW-110, 20);
    _priceLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15,100, 20);
    _totalLab.frame=CGRectMake(CGRectGetMaxX(_priceLab.frame), CGRectGetMinY(_priceLab.frame), 60, 20);
    //_Goods_NBCount.frame=CGRectMake(CGRectGetMaxX(_totalLab.frame), self.frame.size.height/2-15, 100, 30);
    [_Goods_NBCount makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(100);
        make.height.equalTo(30);
        make.top.equalTo(_titleLab.bottom).offset(0);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    
}
-(void)Selected
{
    if ([Selected isEqualToString:@"0"]) {
        [self.SelectedDelegate SelectedConfirmCell:self];
        
    }else{
        [self.SelectedDelegate SelectedCancelCell:self];
    }
    
}

@end
