//
//  FEInterstingCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEInterstingCell.h"

@implementation FEInterstingCell

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
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainW, MainW*0.5)];
    [self addSubview:_imageView];
    
    
    _themeLab=[MYUI createLableFrame:CGRectMake(0, MainW*0.5*0.5-30, MainW, 20) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _themeLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_themeLab];
    
    //时间细节
    _DescripLab=[MYUI createLableFrame:CGRectMake(0, MainW*0.5*0.5+10, MainW, 20) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _DescripLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_DescripLab];
    
}

-(void)setupCellWithModel:(FEINterstingModel *)model
{
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.fmPic]];
    _themeLab.text=model.fmTheme;
    _DescripLab.text=model.fmContent;
    
    
}


@end
