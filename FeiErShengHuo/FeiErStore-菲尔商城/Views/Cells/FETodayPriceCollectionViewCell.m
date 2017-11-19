//
//  FETodayPriceCollectionViewCell.m
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "FETodayPriceCollectionViewCell.h"
//#import <Masonry/Masonry.h>
//#import "QTExploreModel.h"

@interface FETodayPriceCollectionViewCell ()

{
    UIImageView *_imageView;
    UILabel *_titleLab;
    UILabel *_nowPriceLab;
    UILabel *_originLab;
    
}

@end

@implementation FETodayPriceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.backgroundColor = RGB(244, 243, 244);
    }
    return self;
}

- (void)initViews {
//    _coverView = [UIView new];
//    [self.contentView addSubview:_coverView];
    _imageView=[[UIImageView alloc]init];
    [self addSubview:_imageView];
    
    //
    _titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"000" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
    [self addSubview:_titleLab];
    
    _nowPriceLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"000" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
    [self addSubview:_nowPriceLab];

    _originLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"000" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
    [self addSubview:_originLab];
    
}


-(void)setModel:(FESpecailGoodModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.specialThumb]];
    
    _titleLab.text=model.goodsName;
    
    CGFloat fprice=[model.nowPrice integerValue]/100.0;
    _nowPriceLab.text=[NSString stringWithFormat:@"¥%.2f",fprice];
    
    CGFloat Oprice=[model.orginPrice integerValue]/100.0;
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价¥%.2f",Oprice] attributes:attribtDic];
     //中划线
    _originLab.attributedText=attribtStr;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(100);
        make.width.equalTo(self.py_width-20);
        
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(20);
        make.width.equalTo(self.py_width-20);
        
    }];
    
    [_nowPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(20);
        make.width.equalTo(self.py_width-20);
        
    }];
    [_originLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nowPriceLab.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(20);
        make.width.equalTo(self.py_width-20);
        
    }];

}



@end
