//
//  FEGroupedPlayWayView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupedPlayWayView.h"

@implementation FEGroupedPlayWayView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];

    }
    return self;
    
}


-(void)creatUI {
    //玩法详情
    for (int i=0; i<4; i++) {
        self.Lab=[[UILabel alloc]init];
        CGFloat between=5;
        CGFloat width=(MainW-20-3*5)/4;
        CGFloat height=60;
        _Lab.frame=CGRectMake(10+i*(width+between),0, width, height);
        _Lab.numberOfLines=2;
        
        _Lab.textColor=RGB(85, 85, 85);
        _Lab.tag=10086+i;
        
        //添加虚线边框
        
        [_Lab addImaginaryLineBorderwithWidth:width withHeight:height];
        switch (_Lab.tag) {
            case 10086:
                _Lab.text=@"1.选择心仪商品";
                _Lab.backgroundColor=RGB(162, 9, 13);
                _Lab.textColor=[UIColor whiteColor];
                
                break;
            case 10086+1:
                _Lab.text=@"2.支付开团或者参团";
                break;
            case 10086+2:
                _Lab.text=@"3.等待好友参团支付";
                break;
            case 10086+3:
                _Lab.text=@"4.达到人数团购成功";
                break;
                
            default:
                break;
        }
        [self addSubview:_Lab];
        
    }
    
}


@end
