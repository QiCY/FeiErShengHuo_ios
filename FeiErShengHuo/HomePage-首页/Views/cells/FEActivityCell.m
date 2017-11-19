//
//  FEActivityCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEActivityCell.h"

@implementation FEActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    _leftImageView=[MYUI creatImageViewFrame:CGRectMake(10, 10,80, 80) image:[UIImage imageNamed:@""]];
    [self addSubview:_leftImageView];
    
    self.titleLab=[MYUI createLableFrame:CGRectMake(10+80+10, 15, MainW-100, 20) backgroundColor:[UIColor clearColor] text:@"打网球啊啊" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.titleLab];
    
    self.stuseLab=[MYUI createLableFrame:CGRectMake(10+80+10, CGRectGetMaxY(_titleLab.frame)+5,80, 20) backgroundColor:[UIColor  redColor]  text:@"成功" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.stuseLab.textAlignment=NSTextAlignmentCenter;
    
    [self addSubview:self.stuseLab];
    
    self.timeLab=[MYUI createLableFrame:CGRectMake(10+80+10, CGRectGetMaxY(_stuseLab.frame)+5,MainW-100, 20) backgroundColor:[UIColor clearColor]  text:@"成功" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.timeLab];

    
}

-(void)setupCellWithModel:(FEAvtivityModel *)model
{
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _titleLab.text=model.activityTitle;
    _timeLab.text=model.activityCreateTimeStr;
    _stuseLab.text=model.activityMark;
    
    
}

@end
