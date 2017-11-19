//
//  FEGroupedAddpersonCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupedAddpersonCell.h"

@implementation FEGroupedAddpersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}
-(void)creatUI
{
    _imageView=[MYUI creatImageViewFrame:CGRectZero imageName:@"Shopping_picture1"];
    [self addSubview:_imageView];
    
    _nameLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"五斤装山楂" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_nameLab];
    
    //时间
    _datelineLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor]  text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:11] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _datelineLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:_datelineLab];
    
   
}

-(void)setupCellWithModel:(FEgroupedDetailModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    _nameLab.text=[NSString stringWithFormat:@"%@:%@",model.isTuanMember,model.nickName];
    _datelineLab.text=model.datelineStr;
    
    
    _imageView.frame=CGRectMake(10, 20, 60, 60);
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.right).offset(10);
        make.centerY.equalTo(self.centerY);
        
       // make.top.equalTo(self).offset(10);
        make.width.equalTo(MainW/2-100);
        make.height.equalTo(20);
    }];
    
    [_datelineLab makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
         make.centerY.equalTo(self.centerY);
        make.width.equalTo(MainW/2);
        make.height.equalTo(20);
    }];
    
    
}


@end
