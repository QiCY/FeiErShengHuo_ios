//
//  FEGroupStusHeadCollectionViewCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEGroupStusHeadCollectionViewCell.h"

@implementation FEGroupStusHeadCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
    
}
- (void)createUI{

    self.headView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    self.headView.image=[UIImage imageNamed:@"pic"];
    self.headView.layer.cornerRadius=40;
    self.headView.layer.masksToBounds=YES;
    [self addSubview:self.headView];
    
}

@end
