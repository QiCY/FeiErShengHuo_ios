//
//  FEphotoCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEphotoCell.h"

@implementation FEphotoCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
    
}
- (void)createUI{
    
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    [self addSubview:self.imageView];
    
}

-(void)setUpCellWithModel:(FEPictureModel *)picModel
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:picModel.url]];
    
}

@end
