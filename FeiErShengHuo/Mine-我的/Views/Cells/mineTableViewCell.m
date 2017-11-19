//
//  mineTableViewCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "mineTableViewCell.h"

@implementation mineTableViewCell

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
    UIView * bgView1=[MYUI createViewFrame:CGRectMake(0, 0, MainW, 1) backgroundColor:RGB(200, 200, 200)];
    [self addSubview:bgView1];
    
    _mineImageView=[MYUI creatImageViewFrame:CGRectMake(16, self.frame.size.height/2-12, 25, 25) imageName:@""];
    [self addSubview:self.mineImageView];
    
    _mineLab=[MYUI createLableFrame:CGRectMake(60, self.frame.size.height/2-15, 150, 30) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.mineLab];
    
    UIImageView *rightimageView=[MYUI creatImageViewFrame:CGRectMake(MainW-40, self.py_centerY-9, 25, 18) imageName:@"icon.triangle.dynamic"];
    [self addSubview:rightimageView];
    
}



@end
