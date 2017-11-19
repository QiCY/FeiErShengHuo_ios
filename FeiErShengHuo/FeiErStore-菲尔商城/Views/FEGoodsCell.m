//
//  FEGoodsCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/25.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGoodsCell.h"

@implementation FEGoodsCell
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
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 100-1, MainW, 1)];
    lineView.backgroundColor=RGB(239, 239, 239);
    [self addSubview:lineView];
    
    
    self.limitImageView=[MYUI creatImageViewFrame:CGRectZero imageName:@"Shopping_picture1"];
    [self addSubview:self.limitImageView];
    
    self.limitNameLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.limitNameLab];
    
    self.limitdescribeLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"农场自产特级金星山楂" textColor:[UIColor colorWithHexString:@"#9c9c9c"] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.limitdescribeLab];
    
    self.limitPriceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor colorWithHexString:@"#ff0000"] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.limitPriceLab];
    
    _originLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"价格:" textColor:[UIColor colorWithHexString:@"#9c9c9c"] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_originLab];
    
    self.origirnPriceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor colorWithHexString:@"#9c9c9c"] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.origirnPriceLab];
    
    
    
    // 马上抢
    self.goRobBtn=[MYUI creatButtonFrame:CGRectZero setBackgroundImage:[UIImage imageNamed:@"icon_Shopping_Cart2"]];
    
    self.goRobBtn.titleLabel.font=[UIFont systemFontOfSize:8];
    self.goRobBtn.layer.cornerRadius=3;
    self.goRobBtn.layer.masksToBounds=YES;
    [self addSubview:self.goRobBtn];
}

+(CGFloat)countSecondHotSaleHeight{
    return 100;
    
}

-(void)setUpCellWithModel:(FEGoodModel *)model
{
    
    [self.limitImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.limitNameLab.text=model.title;
    self.limitdescribeLab.text=model.descrip;
    // 抢购价
    CGFloat Fprice=model.marketprice/100;
    NSString * priceStr=[NSString stringWithFormat:@"%.2f",Fprice];
    NSString *tol=[NSString stringWithFormat:@"限时价:¥%@",priceStr];
    //取整数
    NSInteger Zprice=(NSInteger)Fprice;
    NSString *ZStr=[NSString stringWithFormat:@"%ld",Zprice];
    NSMutableAttributedString *attributed=[FENavTool withStr:tol withRangeColor:[UIColor redColor] withRangeFont:[UIFont systemFontOfSize:20] WithRange:NSMakeRange(5, ZStr.length)];
    self.limitPriceLab.attributedText=attributed;
    
    //  原价
    CGFloat OriginPrice=model.productprice/100;
    NSString * OriginpriceStr=[NSString stringWithFormat:@"¥%.2f",OriginPrice];
    // NSString *OriginTolPrice=[NSString stringWithFormat:@"价格:%@",OriginpriceStr];
    NSInteger Oprice=(NSInteger)OriginPrice;
    NSString *OStr=[NSString stringWithFormat:@"%ld",Oprice];
    
    
    NSMutableAttributedString *Originattributed1=[FENavTool withStr:OriginpriceStr withRangeColor:[UIColor colorWithHexString:@"#9c9c9c"] withRangeFont:[UIFont systemFontOfSize:16] WithRange:NSMakeRange(1, OStr.length)];
    
    // 中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    [Originattributed1 addAttributes:attribtDic range:NSMakeRange(0,OriginpriceStr.length)];
    
    self.origirnPriceLab.attributedText=Originattributed1;
    
    // 宽度
    limitLabwidth=[tol singleLineWidthWithFont:[UIFont systemFontOfSize:15]];
    
    originLwidth=[OriginpriceStr singleLineWidthWithFont:[UIFont systemFontOfSize:15]];
    
    NSString *yuan=@"价格:";
    originLYwidth=[yuan singleLineWidthWithFont:[UIFont systemFontOfSize:12]];
    
    
    
    
}

-(void)layoutSubviews
{
    [_limitImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(10);
        make.height.equalTo(80);
        make.width.equalTo(80);
        
    }];
    
    [_limitNameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.limitImageView.right).offset(10);
        make.top.equalTo(self.top).offset(15);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(15);
    }];
    
    [_limitdescribeLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.limitImageView.right).offset(10);
        make.top.equalTo(self.limitNameLab.bottom).offset(15);
        make.width.equalTo(MainW/2);
        make.height.equalTo(12);
    }];
    
    [_limitPriceLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.limitImageView.right).offset(10);
        make.top.equalTo(self.limitdescribeLab.bottom).offset(15);
        make.width.equalTo(limitLabwidth);
        make.height.equalTo(16);
    }];
    
    
    [_originLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.limitPriceLab.right).offset(5);
        make.top.equalTo(self.limitdescribeLab.bottom).offset(15);
        make.width.equalTo(originLYwidth);
        make.height.equalTo(16);
    }];
    
    
    [_origirnPriceLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_originLab.right).offset(0);
        make.top.equalTo(self.limitdescribeLab.bottom).offset(15);
        make.width.equalTo(originLwidth);
        make.height.equalTo(16);
    }];
    
    
    [_goRobBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-20);
        make.bottom.equalTo(self.bottom).offset(-10);
        make.width.equalTo(35);
        make.height.equalTo(35);
    }];
    
    
}

@end
