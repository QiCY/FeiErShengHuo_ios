//
//  FEHotthirdView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/10.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEHotthirdView.h"
#import "Masonry.h"

@implementation FEHotthirdView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)creatUI
{
    
    // 左边
    self.lefttopView=[MYUI createViewFrame:CGRectMake(0, 0, MainW/2, 79) backgroundColor:[UIColor whiteColor]];
    [self addSubview:self.lefttopView];
    self.leftbottomView=[MYUI createViewFrame:CGRectMake(0, 80, MainW/2, 80) backgroundColor:[UIColor whiteColor]];
    [self addSubview:self.leftbottomView];
    self.lefttopimageView=[MYUI creatImageViewFrame:CGRectMake(MainW/4+30, 10, 50, 50) imageName:@"flea_market"];
    [self.lefttopView addSubview:self.lefttopimageView];
    self.leftbottomimageView=[MYUI creatImageViewFrame:CGRectMake(MainW/4+30, 10, 50, 50) imageName:@"Community_activities"];
    [self.leftbottomView addSubview:self.leftbottomimageView];
    self.leftfirstLab=[MYUI createLableFrame:CGRectMake(20, 20, MainW/4+10,20) backgroundColor:[UIColor whiteColor] text:@"邻里闲置" textColor:RGB(234, 73, 45) font:[UIFont fontWithName:@"PingFangSC-Regular" size:20] numberOfLines:0 adjustsFontSizeToFitWidth:YES];
    
    
    self.leftsecondLab=[MYUI createLableFrame:CGRectMake(20,43 , MainW/4, 18) backgroundColor:[UIColor whiteColor] text:@"寻找志同道合的人" textColor:RGB(116, 116, 126) font:[UIFont fontWithName:@"PingFangSC-Regular" size:12] numberOfLines:0 adjustsFontSizeToFitWidth:YES];
    self.leftthirdLab=[MYUI createLableFrame:CGRectMake(20, 20, MainW/4+10, 20) backgroundColor:[UIColor whiteColor] text:@"社区活动" textColor:RGB(71, 170, 166) font:[UIFont fontWithName:@"PingFangSC-Regular" size:20] numberOfLines:0 adjustsFontSizeToFitWidth:YES];
    self.leftforthLab=[MYUI createLableFrame:CGRectMake(20, 43, MainW/4, 18) backgroundColor:[UIColor whiteColor] text:@"汇集精彩活动" textColor:RGB(116, 116, 126) font:[UIFont fontWithName:@"PingFangSC-Regular" size:12] numberOfLines:0 adjustsFontSizeToFitWidth:YES];
    
    //社区活动手势
    _leftbottomView.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActivityClick:)];
    PrivateLetterTap2.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap2.numberOfTapsRequired = 1; //tap次数
    PrivateLetterTap2.delegate= self;
    [self.leftbottomView addGestureRecognizer:PrivateLetterTap2];
    
    
    //闲置手势
    
    _lefttopView.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTapTop=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secondhandClick:)];
    PrivateLetterTapTop.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTapTop.numberOfTapsRequired = 1; //tap次数
    PrivateLetterTapTop.delegate= self;
    [_lefttopView addGestureRecognizer:PrivateLetterTapTop];
    
    
    
    [self.lefttopView addSubview:self.leftfirstLab];
    [self.lefttopView addSubview:self.leftsecondLab];
    [self.leftbottomView addSubview:self.leftthirdLab];
    [self.leftbottomView addSubview:self.leftforthLab];
    //右边
    self.rightView=[MYUI createViewFrame:CGRectMake(MainW/2+1,0, MainW/2, 160) backgroundColor:[UIColor whiteColor]];
    [self addSubview:self.rightView];
    
    //团购 手势
   
 
    _rightView.userInteractionEnabled = YES;
    UITapGestureRecognizer * PrivateLetterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goGroupeBuy:)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    PrivateLetterTap.delegate= self;
    [self.rightView addGestureRecognizer:PrivateLetterTap];
    
    self.rightimageView=[MYUI creatImageViewFrame:CGRectMake(MainW/4-30,80-60, 60, 60) imageName:@"Group_purchase"];
     [self.rightView addSubview:self.rightimageView];
    
    self.rightfirstLab=[MYUI createLableFrame:CGRectMake(MainW/4-(MainW/4+10)/2, 80+10, MainW/4+10,20) backgroundColor:[UIColor whiteColor] text:@"邻里团购" textColor:RGB(241, 175, 56) font:[UIFont fontWithName:@"PingFangSC-Regular" size:18] numberOfLines:0 adjustsFontSizeToFitWidth:YES];
    self.rightfirstLab.textAlignment=NSTextAlignmentCenter;
    
    [self.rightView addSubview:self.rightfirstLab];
    
    self.rightsecondLab=[MYUI createLableFrame:CGRectMake(MainW/4-(MainW/4+10)/2, self.rightfirstLab.frame.origin.y+20+3, MainW/4, 18) backgroundColor:[UIColor whiteColor] text:@"更多好礼等着你" textColor:RGB(116, 116, 126) font:[UIFont fontWithName:@"PingFangSC-Regular" size:12] numberOfLines:0 adjustsFontSizeToFitWidth:YES];
     self.rightsecondLab.textAlignment=NSTextAlignmentCenter;
    [self.rightView addSubview:self.rightsecondLab];

}

-(void)goGroupeBuy:(UITapGestureRecognizer *)tap
{
    if (self.block) {
        self.block();
        
    }
}


-(void)ActivityClick:(UITapGestureRecognizer *)tap
{
    if (self.ABlock) {
        self.ABlock();
        
    }
}

-(void)secondhandClick:(UITapGestureRecognizer *)tap
{
    if (self.Cblock) {
        self.Cblock();
        
    }
}

@end
