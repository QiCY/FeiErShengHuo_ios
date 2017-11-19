//
//  FECanshuTableViewCell.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/7/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FECanshuTableViewCell.h"

@implementation FECanshuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

//@property(nonatomic,strong)UILabel *pingpaiLab;
//
//@property(nonatomic,strong)UILabel *nameLab;
//@property(nonatomic,strong)UILabel *placeLab;
//@property(nonatomic,strong)UILabel *baozhuangLab;
//@property(nonatomic,strong)UILabel *baozhuangfangfaLab;

-(void)creatUI
{
    
    UILabel *canshu=[MYUI createLableFrame:CGRectMake(10, 0, MainW/2, 40) backgroundColor:[UIColor clearColor] text:@"产品参数" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:canshu];
    
    self.pingpaiLab=[MYUI createLableFrame:CGRectMake(0, CGRectGetMaxY(canshu.frame), MainW/2, 20) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [_pingpaiLab XUaddBottomBorderandWidth:1];
    
    
    [self addSubview:self.pingpaiLab];
    //
    self.nameLab=[MYUI createLableFrame:CGRectMake(MainW/2, CGRectGetMaxY(canshu.frame), MainW/2, 20) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.nameLab];
    //
    self.placeLab=[MYUI createLableFrame:CGRectMake(0, CGRectGetMaxY(self.pingpaiLab.frame)+3, MainW/2, 20) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.placeLab];
    //
    self.baozhuangLab=[MYUI createLableFrame:CGRectMake(MainW/2, CGRectGetMaxY(self.pingpaiLab.frame)+3, MainW/2, 20) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.baozhuangLab];
    //
    self.baozhuangfangfaLab=[MYUI createLableFrame:CGRectMake(0, CGRectGetMaxY(_placeLab.frame)+3, MainW/2, 20) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.baozhuangfangfaLab];

}
-(void)setModel:(FDEGoodsDetailModel *)model
{
    //@property(nonatomic,strong)UILabel *pingpaiLab;
    //
    //@property(nonatomic,strong)UILabel *nameLab;
    //@property(nonatomic,strong)UILabel *placeLab;
    //@property(nonatomic,strong)UILabel *baozhuangLab;
    //@property(nonatomic,strong)UILabel *baozhuangfangfaLab;
     NSString *str1=@"【品牌】";
    NSString *str2=@"【商品名称】";
    NSString *str3=@"【销售地区】";
    NSString *str4=@"【产品包装】";
    NSString *str5=@"【包装方法】";
    
    
    
    NSString *STR1=[NSString stringWithFormat:@"【品牌】%@",model.brand];
    NSString *STR2=[NSString stringWithFormat:@"【商品名称】%@",model.title];
    NSString *STR3=[NSString stringWithFormat:@"【销售地区】%@",model.origin];
    NSString *STR4=[NSString stringWithFormat:@"【产品包装】%@",@""];
    NSString *STR5=[NSString stringWithFormat:@"【包装方法】%@",model.packingMethod];

    
//    
//    NSMutableAttributedString *SSTR1 = [[NSMutableAttributedString alloc]initWithString:STR1];
//    NSMutableAttributedString *SSTR2 = [[NSMutableAttributedString alloc]initWithString:STR2];
//    NSMutableAttributedString *SSTR3 = [[NSMutableAttributedString alloc]initWithString:STR3];
//    NSMutableAttributedString *SSTR4 = [[NSMutableAttributedString alloc]initWithString:STR4];
//    NSMutableAttributedString *SSTR5 = [[NSMutableAttributedString alloc]initWithString:STR5];
    
    
    
    self.pingpaiLab.attributedText=[FENavTool withStr:STR1 withRangeColor:RGB(132,133,134) withRangeFont:[UIFont systemFontOfSize:15] WithRange:NSMakeRange(str1.length, model.brand.length)];
    
     self.nameLab.attributedText=[FENavTool withStr:STR2 withRangeColor:RGB(132,133,134)withRangeFont:[UIFont systemFontOfSize:15] WithRange:NSMakeRange(str2.length, model.title.length)];
     self.placeLab.attributedText=[FENavTool withStr:STR3 withRangeColor:RGB(132,133,134) withRangeFont:[UIFont systemFontOfSize:15] WithRange:NSMakeRange(str3.length, model.origin.length)];
     self.baozhuangLab.attributedText=[FENavTool withStr:STR4 withRangeColor:RGB(132,133,134) withRangeFont:[UIFont systemFontOfSize:15] WithRange:NSMakeRange(str4.length, 0)];
     self.baozhuangfangfaLab.attributedText=[FENavTool withStr:STR5 withRangeColor:RGB(132,133,134) withRangeFont:[UIFont systemFontOfSize:15] WithRange:NSMakeRange(str5.length, model.packingMethod.length)];
    


}

@end
