//
//  FEBuyNowCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBuyNowCell.h"

@implementation FEBuyNowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x=10;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=1;
    [super setFrame:frame];

}


-(void)creatUI
{
    self.backgroundColor=[UIColor whiteColor];
    
    
    self.goodsImageView=[MYUI creatImageViewFrame:CGRectZero imageName:@""];
    [self.contentView addSubview:self.goodsImageView];
    
    self.titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self.contentView addSubview:self.titleLab];
    
    self.descripLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self.contentView addSubview:self.descripLab];
    
    self.priceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self.contentView addSubview:self.priceLab];
    
    self.totalLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"1" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self.contentView addSubview:self.totalLab];
    
    //订单状态
    self.statusLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.statusLab.textAlignment=NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.statusLab];
    
    
    
    

}

-(void)setGoodModel:(FEGoodModel *)goodModel

{
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodModel.thumb]];
    self.titleLab.text=goodModel.title;
    self.descripLab.text=goodModel.descrip;
    if (goodModel.Gtotal==0) {
        
        self.totalLab.text=@"x1";
        
    }else
    {
        self.totalLab.text=[NSString stringWithFormat:@" x%@",goodModel.Gtotal];//@"x1";
        
    }
    

    CGFloat fprice=goodModel.marketprice/100.0;
    self.priceLab.text=[NSString stringWithFormat:@"¥%.2f",fprice];
    
    _goodsImageView.frame=CGRectMake(30, 10, 80, 80);
    _titleLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, 10, MainW-150, 40);
    _descripLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15, MainW-110, 20);
    _priceLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15,100, 20);
    _totalLab.frame=CGRectMake(CGRectGetMaxX(_priceLab.frame), CGRectGetMinY(_priceLab.frame), 60, 20);
    
    
    
 
}




-(void)setModel:(FEOderModel *)model

{
    
    if ([model.status isEqual:[NSNumber numberWithInt:0]]) {
        _statusLab.text=@"未付款";
        
        
    }
    if ([model.status isEqual:[NSNumber numberWithInt:1]]) {
        _statusLab.text=@"已付款";
    }
    if ([model.status isEqual:[NSNumber numberWithInt:2]]) {
        _statusLab.text=@"退款中";
    }
    if ([model.status isEqual:[NSNumber numberWithInt:3]]) {
        _statusLab.text=@"退货成功";
    }
    if ([model.status isEqual:[NSNumber numberWithInt:4]]) {
        _statusLab.text=@"已发货";
    }
    if ([model.status isEqual:[NSNumber numberWithInt:5]]) {
        _statusLab.text=@"已完成";
    }

    model.goodNum =[NSNumber numberWithInt:1];
     
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.goodThumb]];
    self.titleLab.text=model.goodTitle;
    self.descripLab.text=model.goodDescription;
    self.totalLab.text=[NSString stringWithFormat:@" x%@",model.goodNum];
    CGFloat fprice=[model.marketPrice integerValue]/100.0;
    self.priceLab.text=[NSString stringWithFormat:@"¥%.2f",fprice];
    
    
    _goodsImageView.frame=CGRectMake(30, 10, 80, 80);
    _titleLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, 10, MainW-140, 40);
    _descripLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15, MainW-110, 20);
    _priceLab.frame=CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+15,100, 20);
    _totalLab.frame=CGRectMake(CGRectGetMaxX(_priceLab.frame), CGRectGetMinY(_priceLab.frame), 60, 20);
    
    _statusLab.frame=CGRectMake(MainW-120, CGRectGetMaxY(self.titleLab.frame), 100, 20);
    



}


@end
