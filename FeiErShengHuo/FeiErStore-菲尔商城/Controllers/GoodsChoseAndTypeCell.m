//
//  GoodsChoseAndTypeCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/19.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "GoodsChoseAndTypeCell.h"

@implementation GoodsChoseAndTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUP];
    }
    
    return self;
}

-(void)setUP
{
    self.choseAndTypeLab=[MYUI createLableFrame:CGRectMake(10, self.frame.size.height/2-10, MainW,20 ) backgroundColor:[UIColor whiteColor] text:@"测试" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth: YES];
    [self addSubview: self.choseAndTypeLab];
    
}

@end
