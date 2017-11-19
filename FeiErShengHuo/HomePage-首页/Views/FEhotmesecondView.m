//
//  FEhotmesecondView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEhotmesecondView.h"

@implementation FEhotmesecondView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
        self.backgroundColor=[UIColor whiteColor];
    
    }
    return self;
}

-(void)creatUI
{
    //
    self.imageView=[MYUI creatImageViewFrame:CGRectMake(0, 0, 0, 0) imageName:@"points_mall"];
    [self addSubview:self.imageView];
    //
    self.oneLab=[MYUI createLableFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor] text:@"积分商城" textColor:RGB(255, 58, 2) font:[UIFont fontWithName:@"PingFangSC-Regular" size:18] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.oneLab];
    //
    self.secondLab=[MYUI createLableFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor] text:@"积分快乐，分享好礼" textColor:[UIColor blackColor] font:[UIFont fontWithName:@"PingFangSC-Regular" size:15]numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.secondLab];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.centerX).offset(-25);
        make.centerY.equalTo(self.centerY);
        
        make.width.equalTo(90);
        make.height.equalTo(90);
       
    }];
    
    [_oneLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerX).offset(0);
        make.top.equalTo(self.centerY).offset(-20);
        
        make.width.equalTo(MainW/2);
        make.height.equalTo(18);
        
    }];
    [_secondLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerX).offset(0);
        make.top.equalTo(self.centerY);
        make.width.equalTo(MainW/2);
        make.height.equalTo(20);
        
    }];


    
}
@end
