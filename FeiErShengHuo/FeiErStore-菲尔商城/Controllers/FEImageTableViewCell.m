//
//  FEImageTableViewCell.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/10.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEImageTableViewCell.h"

@implementation FEImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    self.imgView=[UIImageView new];
    [self addSubview:self.imgView];
}


@end
