//
//  FEIntergralDetailSecondCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntergralDetailSecondCell.h"

@implementation FEIntergralDetailSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    limitlab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"详情说明" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
    [self addSubview:limitlab];
    
    

    
    //兑换流程
    liuchengLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"兑换流程" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];

    [self addSubview:liuchengLab];
    
    self.liuchengLab1=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];

    [self addSubview:self.liuchengLab1];
    

    
    //注意事项
    
    zhuyiLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"注意事项:" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];

    [self addSubview:zhuyiLab];
    
   
    self.zhuyiLab1=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];

    [self addSubview:self.zhuyiLab1];
    

   
    exchangeBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:Green_Color setTitle:@"马上兑换" setTitleColor:[UIColor whiteColor]];
    [exchangeBtn addTarget:self action:@selector(goDetailClick:) forControlEvents:UIControlEventTouchUpInside];
    exchangeBtn.layer.masksToBounds=YES;
    exchangeBtn.layer.cornerRadius=5;
    
    [self addSubview:exchangeBtn];
    
}

-(void)goDetailClick:(UIButton *)btn
{
    if (_delegete &&[_delegete respondsToSelector:@selector(goDetailInfoAdress)]) {
        [_delegete goDetailInfoAdress];
        
    }
}

-(void)setupSecondCellWithModel:(FEIntergralDeatialModel *)model
{
    _integralPriceLab.text=[NSString stringWithFormat:@"面值:%@元",model.integralPrice];
    if ([model.status isEqual:@1]) {
        _statusLab.text=@"类型:自提";
    }
    else
    {
        _statusLab.text=@"类型:快递";

    }
    _validPeriodLab.text=[NSString stringWithFormat:@"有效期:%@",model.validPeriod];
    
    limitlab.frame=CGRectMake(10, 10, MainW/2, 20);
    liuchengLab.frame=CGRectMake(10, CGRectGetMaxY(limitlab.frame)+25, MainW/2, 20);

    
    
    self.liuchengLab1.text=model.exchangeProcess;
    self.zhuyiLab1.text=model.precautions;
    
    
    
    //
    CGFloat liuchengLabH=[model.exchangeProcess heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-20];
    self.liuchengLab1.frame=CGRectMake(10, CGRectGetMaxY(liuchengLab.frame)+10, MainW-20, liuchengLabH);
    
    zhuyiLab.frame=CGRectMake(10, CGRectGetMaxY(self.liuchengLab1.frame)+10, MainW/2, 20);
    
    
    CGFloat zhuyiLabH=[model.precautions heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-20];
    self.zhuyiLab1.frame=CGRectMake(10, CGRectGetMaxY(zhuyiLab.frame)+10, MainW-20, zhuyiLabH);
    
    
    exchangeBtn.frame=CGRectMake(10, CGRectGetMaxY(self.zhuyiLab1.frame)+25, MainW-20, 40);
    
    
    
   
}
+(CGFloat)intergralCountSecondCellHeight
{
    return 500;
    
}
@end
