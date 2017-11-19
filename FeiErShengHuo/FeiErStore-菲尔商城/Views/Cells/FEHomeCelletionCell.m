//
//  signCelletionCell.m
//  CCICNews
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 Ruyun. All rights reserved.
//

#import "FEHomeCelletionCell.h"

@implementation FEHomeCelletionCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
    
}
- (void)createUI{
    
    
    self.headView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height-30)];
    //self.headView.image=[UIImage imageNamed:@"pic"];
    [self addSubview:self.headView];
    
    self.btnnameLab=[MYUI createLableFrame:CGRectMake(0,0+self.headView.frame.size.height+10, self.frame.size.width,15) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.btnnameLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview: self.btnnameLab];

    
}
@end
