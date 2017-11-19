//
//  PHCell.m
//  CCICNews
//
//  Created by apple on 2016/11/3.
//  Copyright © 2016年 Ruyun. All rights reserved.
//

#import "PHCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PHCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
    
}

- (void)createUI{
    
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)]
    ;
    
    //self.iv.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.imgView];
    
    
}

@end
