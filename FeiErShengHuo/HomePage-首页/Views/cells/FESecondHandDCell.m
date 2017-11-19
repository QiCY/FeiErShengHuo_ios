//
//  FESecondHandDCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/30.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESecondHandDCell.h"

@implementation FESecondHandDCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    _originPriceLab=[MYUI createLableFrame:CGRectMake(10, 20, MainW/4, 20) backgroundColor:[UIColor clearColor] text:@"¥3400" textColor: TxTGray_Color1 font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _originPriceLab.textAlignment=NSTextAlignmentLeft;
    
    [self addSubview:_originPriceLab];
    
    _nowPriceLab=[MYUI createLableFrame:CGRectMake(10+MainW/4, 20, MainW/4, 20) backgroundColor:[UIColor clearColor] text:@"¥3400" textColor: [UIColor redColor] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _nowPriceLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_nowPriceLab];
    
    
    //手机
    _phoneBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:RGB(3, 207, 46) setTitle:@"手机" setTitleColor:[UIColor whiteColor]];
    
    _phoneBtn.layer.cornerRadius=5;
    _phoneBtn.layer.masksToBounds=YES;
    [self addSubview:_phoneBtn];
    
    _qulityBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:RGB(104, 202, 250) setTitle:@"" setTitleColor:[UIColor whiteColor]];
    
    _qulityBtn.layer.cornerRadius=5;
    _qulityBtn.layer.masksToBounds=YES;
    [self addSubview:_qulityBtn];
    
    
    //
    _personReciveBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:RGB(204, 8, 14) setTitle:@"自提" setTitleColor:[UIColor whiteColor]];
    _personReciveBtn.layer.cornerRadius=5;
    _personReciveBtn.layer.masksToBounds=YES;
    [self addSubview:_personReciveBtn];

}

-(void)setupCellWithModel:(FEsecondhandModel *)model
{
    //原价
    CGFloat Oprice=[model.orginPrice integerValue]/100;
    _originPriceLab.text=[NSString stringWithFormat:@"¥%.0f",Oprice];
    
    //现价
    CGFloat Nprice=[model.sellPrice integerValue]/100;
    _nowPriceLab.text=[NSString stringWithFormat:@"¥%.0f",Nprice];
    
    [_qulityBtn setTitle:model.quality forState:0];
    
    
    CGFloat w=[model.quality singleLineWidthWithFont:[UIFont systemFontOfSize:14]];
    
    _phoneBtn.frame=CGRectMake(10, CGRectGetMaxY(_nowPriceLab.frame)+10,40, 25);
    _qulityBtn.frame=CGRectMake(CGRectGetMaxX(_phoneBtn.frame)+10, CGRectGetMaxY(_nowPriceLab.frame)+10,w+10, 25);
    _personReciveBtn.frame=CGRectMake(CGRectGetMaxX(_qulityBtn.frame)+10, CGRectGetMaxY(_nowPriceLab.frame)+10, 40, 25);

    
}

@end
