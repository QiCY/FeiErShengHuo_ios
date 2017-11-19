//
//  FERecordCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FERecordCell.h"

@implementation FERecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    self.leftimageView=[MYUI creatImageViewFrame:CGRectMake(10, 10, 80, 80) imageName:@"Shopping_picture1"];
    [self addSubview:self.leftimageView];
    
    self.titleLab=[MYUI createLableFrame:CGRectMake(10+80+10, 5, MainW-70, 20) backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.titleLab];
    
    self.stuseLab=[MYUI createLableFrame:CGRectMake(100, 5+20+40,MainW-70, 20) backgroundColor:[UIColor clearColor]  text:@"成功" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.stuseLab];

    
}

-(void)setupCellWithModel:(FERecordModel *)model
{
    [_leftimageView sd_setImageWithURL:[NSURL URLWithString:model.integralGoodUrl]];
    _titleLab.text=model.integralGoodTitle;
    
    
}


@end
