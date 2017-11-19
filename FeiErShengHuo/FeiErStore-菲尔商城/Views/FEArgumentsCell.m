//
//  FEArgumentsCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/2.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEArgumentsCell.h"

@implementation FEArgumentsCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    self.leftLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, self.frame.size.height)];
    self.leftLab.font=[UIFont systemFontOfSize:14];
    self.leftLab.textColor=Colorgrayall133;
    [self addSubview:self.leftLab];

    self.rightLab=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, MainW-100, self.frame.size.height)];
        self.rightLab.font=[UIFont systemFontOfSize:14];
    self.rightLab.textColor=[UIColor blackColor];
    [self addSubview:self.rightLab];
    
}



@end
