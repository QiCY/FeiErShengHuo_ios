//
//  FELimitView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FELimitView.h"


@implementation FELimitView

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
    UILabel *limitLab=[MYUI createLableFrame:CGRectMake(10, 12, 200/3, 15) backgroundColor:[UIColor clearColor] text:@"今日特价" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:limitLab];
//    UILabel *haishengLab=[MYUI createLableFrame:CGRectMake(200/3+7, 12, 30, 15) backgroundColor:[UIColor clearColor] text:@"还剩" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
//    [self addSubview: haishengLab];
//    
//    UIImageView *imageclockView=[MYUI creatImageViewFrame:CGRectMake(haishengLab.frame.origin.x+30, 12, 15, 15) imageName:@"icon_clock"];
//    [self addSubview:imageclockView];
//    
//    //倒计时
//    _countDown = [CZCountDownView countDown];
//    _countDown.frame =CGRectMake( CGRectGetMaxX(imageclockView.frame)+5, 12, 90, 15);
//    //_countDown.timestamp = 10000;
//    
//    _countDown.dayLabel.layer.cornerRadius=1;
//    _countDown.hourLabel.layer.cornerRadius=1;
//    _countDown.minuesLabel.layer.cornerRadius=1;
//    _countDown.secondsLabel.layer.cornerRadius=1;
//    
//    
//    _countDown.dayLabel.layer.masksToBounds=YES;
//    _countDown.hourLabel.layer.masksToBounds=YES;
//    _countDown.minuesLabel.layer.masksToBounds=YES;
//    _countDown.secondsLabel.layer.masksToBounds=YES;
//    
//    _countDown.dayLabel.font=[UIFont systemFontOfSize:10];
//    _countDown.hourLabel.font=[UIFont systemFontOfSize:10];
//    _countDown.minuesLabel.font=[UIFont systemFontOfSize:10];
//    _countDown.secondsLabel.font=[UIFont systemFontOfSize:10];
//
//    
//    //countDown.backgroundImageName = @"search_k";
//    _countDown.backgroundColor=[UIColor whiteColor];
//    _countDown.timerStopBlock = ^{
//        NSLog(@"时间停止");
//    };
//    [self addSubview:_countDown];
    
//    
//    UIButton *timeAndCountBtn=[MYUI creatButtonFrame:CGRectMake(MainW-256/3-10, 12, 256/3, 15) backgroundColor:[UIColor redColor] setTitle:@"小菲推荐" setTitleColor:[UIColor whiteColor]];
//    timeAndCountBtn.titleLabel.font=[UIFont systemFontOfSize:13];
//    timeAndCountBtn.layer.masksToBounds=YES;
//    timeAndCountBtn.layer.cornerRadius=5;
//    
//    [self addSubview:timeAndCountBtn];
    
    
}


@end
