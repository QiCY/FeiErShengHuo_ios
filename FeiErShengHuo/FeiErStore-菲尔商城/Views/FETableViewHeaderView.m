//
//  FETableViewHeaderView.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "FETableViewHeaderView.h"

@implementation FETableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGBA(240, 240, 240, 0.8);
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 30)];
        self.name.font = [UIFont systemFontOfSize:16];
        self.name.textColor=[UIColor blackColor];
        [self addSubview:self.name];
    }
    return self;
}

@end
