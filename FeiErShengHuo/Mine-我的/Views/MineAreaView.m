//
//  mineAreaView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "MineAreaView.h"

@implementation MineAreaView
-(id)initWithFrame:(CGRect)frame

{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI {
       
    self.addressLab=[MYUI createLableFrame:CGRectMake(35, 8, 35, 15) backgroundColor:[UIColor clearColor] text:@"南京" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.addressLab];
    self.shangChengLab=[MYUI createLableFrame:CGRectMake(85,8, 100, 15) backgroundColor:[UIColor clearColor] text:@"菲尔商城" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.shangChengLab];
    
    UIImageView *imageoneView=[MYUI creatImageViewFrame:CGRectMake(12, 8, 15, 15) imageName:@"icon_User_house"];
    [self addSubview:imageoneView];
    UIImageView *imagetwoView=[MYUI creatImageViewFrame:CGRectMake(135/2, 10, 10, 10) imageName:@"icon_square"];
    [self addSubview:imagetwoView];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 8+15+8, MainW, 9)];
    lineView.backgroundColor=RGB(232, 232, 232);
    [self addSubview:lineView];
    
    
}


@end
