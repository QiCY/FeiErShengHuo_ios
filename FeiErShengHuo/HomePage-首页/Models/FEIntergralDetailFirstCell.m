//
//  FEIntergralDetailFirstCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntergralDetailFirstCell.h"

@implementation FEIntergralDetailFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    self.titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"端午节礼盒" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.titleLab];
    
    self.intergralCountLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"农场自产特级金星山楂" textColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.intergralCountLab];
    
    self.startAndendlab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:10] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.startAndendlab];
    
    _titleLab.frame=CGRectMake(10, 10, MainW, 20);
    _intergralCountLab.frame=CGRectMake(10, CGRectGetMaxY(_titleLab.frame)+15, MainW, 20);
    _startAndendlab.frame=CGRectMake(10, CGRectGetMaxY(_intergralCountLab.frame)+15, MainW, 20);
    
}

-(void)setupFirstCellWithModel:(FEIntergralDeatialModel *)model
{
    self.titleLab.text=model.integralGoodTitle;
    //积分
    NSString *integralCreditStr=[NSString stringWithFormat:@"%@",model.integralCredit];
    NSString *coutStr=[NSString stringWithFormat:@"%@积分",integralCreditStr];
    
    
    NSMutableAttributedString *attributed=[FENavTool withStr:coutStr withRangeColor:[UIColor orangeColor] withRangeFont:[UIFont systemFontOfSize:20] WithRange:NSMakeRange(0, integralCreditStr.length)];
       self.intergralCountLab.attributedText=attributed;
    
    NSString  *starAndEndTime=[NSString stringWithFormat:@"有效期:%@至%@",model.startTimeStr,model.endTimeStr];
    self.startAndendlab.text=starAndEndTime;
    
}

+(CGFloat)intergralCountFirstCellHeight
{
    CGFloat height=20*3+20+15*2;
    return height;
    
}
@end
