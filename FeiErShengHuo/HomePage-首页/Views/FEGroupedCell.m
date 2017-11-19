//
//  FEGroupedCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupedCell.h"

@implementation FEGroupedCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    // 图片
    self.goodImageView=[MYUI creatImageViewFrame:CGRectZero imageName:@""];
    [self addSubview:self.goodImageView];
    //白色BG
    self.whiteView=[MYUI createViewFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [self addSubview:self.whiteView];
     //标题
    self.titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] numberOfLines:2 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.titleLab];
    // 描述
    self.descriptionLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:RGB(68, 69, 70) font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.descriptionLab];
    //截止时间
    self.endLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.endLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.endLab];
    //参加
    self.participationBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:RGB(184, 7, 13) setTitle:@"立即参与 >" setTitleColor:[UIColor whiteColor]];
    [self.participationBtn addTarget:self action:@selector(goparticipationClick:) forControlEvents:UIControlEventTouchUpInside];
    self.participationBtn.titleEdgeInsets=UIEdgeInsetsMake(0,25,0,0);
    self.participationBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    self.participationBtn.layer.cornerRadius=18;
    self.participationBtn.layer.masksToBounds=YES;
    [self addSubview:self.participationBtn];
     // 报团人数
    self.numLab=[MYUI createLableFrame:CGRectZero backgroundColor:RGB(47, 47, 49) text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO insert:UIEdgeInsetsMake(0,12,0,0)];
    [self addSubview:self.numLab];
     //价格
    self.priceLab=[MYUI createLableFrame:CGRectZero backgroundColor:RGB(47, 47, 49) text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO insert:UIEdgeInsetsMake(0,0,0,0)];
    [self addSubview:self.priceLab];
    //
    self.circleImageView=[MYUI creatCircleImageViewFrame:CGRectZero imageName:@"icon_purchase"];
     [self addSubview:self.circleImageView];
    
}

-(void) setUpCellWithModel:(FEgroupBuyModel *)model
{
    
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    _titleLab.text=model.title;
    _descriptionLab.text=model.descrip;
    NSNumber *count=model.num;
    CGFloat price=model.marketPrice/100.0;
    NSString *endTime=model.endTimeStr;
    _numLab.text=[NSString stringWithFormat:@"%@人团",count];
    _priceLab.text=[NSString stringWithFormat:@"¥%.2f",price];
    _endLab.text=[NSString stringWithFormat:@"截止日期:%@",endTime];
    //计算title 的 高度
    CGFloat titleHeight=[model.title heightWithFont:[UIFont systemFontOfSize:16] constrainedToWidth:MainW-20];
    CGFloat descripHeight=[model.descrip heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-20];
    //布局
    _goodImageView.frame=CGRectMake(10, 0, MainW-20, MainW-20);
    _titleLab.frame=CGRectMake(10,CGRectGetMaxY(_goodImageView.frame)+5,MainW-20, titleHeight);
    _descriptionLab.frame=CGRectMake(10, CGRectGetMaxY(self.titleLab.frame)+5, MainW-20, descripHeight);
    _endLab.frame=CGRectMake(0, CGRectGetMaxY(self.descriptionLab.frame)+5,MainW-20, 12);
    _participationBtn.frame=CGRectMake(155, CGRectGetMaxY(_endLab.frame)+12, 120,36);
    _numLab.frame=CGRectMake(40, CGRectGetMaxY(self.endLab.frame)+12, 60, 36);
    _priceLab.frame=CGRectMake(CGRectGetMaxX(self.numLab.frame), CGRectGetMaxY(self.endLab.frame)+12,70, 36);
    _circleImageView.frame=CGRectMake(10,CGRectGetMaxY(self.endLab.frame)+10, 40, 40);
    _whiteView.frame=CGRectMake(10, CGRectGetMaxY(_goodImageView.frame), MainW-20,titleHeight +descripHeight+5+5+5+10+12+40+5 );
}

+(CGFloat)countHeightWithModel:(FEgroupBuyModel *)model
{
    

    
    CGFloat titleHeight=[model.title heightWithFont:[UIFont systemFontOfSize:16] constrainedToWidth:MainW-20];
    CGFloat descripHeight=[model.descrip heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-20];
    CGFloat totalHeight=titleHeight +descripHeight+MainW-20+5+5+5+10+12+40+5;
    return totalHeight;
}
-(void)goparticipationClick:(UIButton *)btn
{
    //传按钮tag数值
    if (self.block) {
        btn.tag=self.tag;
        self.block(btn);
    }
}


@end
