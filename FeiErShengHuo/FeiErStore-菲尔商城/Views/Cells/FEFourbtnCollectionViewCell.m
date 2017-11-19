//
//  FEFourbtnCollectionViewCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEFourbtnCollectionViewCell.h"

@implementation FEFourbtnCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    self.backgroundColor=[UIColor whiteColor];
    //图片
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20)];
    [self addSubview:self.imageView];
    //名称
    self.btnnameLab=[MYUI createLableFrame:CGRectMake(0,0+self.imageView.frame.size.height, self.frame.size.width, 20) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    self.btnnameLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview: self.btnnameLab];
       
    
}

@end
