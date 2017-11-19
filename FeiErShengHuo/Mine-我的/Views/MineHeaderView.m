//
//  MineHeaderView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

-(id)initWithFrame:(CGRect)frame

{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI {
    self.personHeadView=[MYUI creatImageViewFrame:CGRectMake(20, 20, 70, 70) imageName:@""];//[MYUI creatButtonFrame:CGRectMake(20, 14, 65, 65) setBackgroundImage:[UIImage imageNamed:@"Shopping_picture2"] setTitle:@"" setTitleColor:[UIColor clearColor]];
    //[MYUI creatImageViewFrame:CGRectMake(20, 14, 65, 65) imageName:@"Shopping_picture2"];
    
    self.personHeadView.layer.cornerRadius=35;
    self.personHeadView.layer.masksToBounds=YES;
    self.personHeadView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick:)];
    [self.personHeadView addGestureRecognizer:tap];
    

    [self addSubview:self.personHeadView];
    
    self.nameLab=[MYUI createLableFrame:CGRectMake(CGRectGetMaxY(self.personHeadView.frame)+10, 44, MainW, 24) backgroundColor:[UIColor clearColor] text:@"小兔" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.nameLab];
    
    
    self.areaLab=[MYUI createLableFrame:CGRectMake(20, CGRectGetMaxY(self.personHeadView.frame)+30, MainW, 15) backgroundColor:[UIColor clearColor] text:@"区域：菲尔生活" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_areaLab];
    self.phoneLab=[MYUI createLableFrame:CGRectMake(20, CGRectGetMaxY(self.areaLab.frame)+5, MainW, 15) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_phoneLab];
    
    
}

-(void)headClick:(UITapGestureRecognizer *)tap{
    if (_delegete &&[_delegete respondsToSelector:@selector(headClick:)]) {
        [_delegete headClick:tap];
        
    }
}



@end
