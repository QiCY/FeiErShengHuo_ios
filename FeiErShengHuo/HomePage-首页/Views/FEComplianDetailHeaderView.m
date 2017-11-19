//
//  FEComplianDetailHeaderView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/7/3.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEComplianDetailHeaderView.h"

@implementation FEComplianDetailHeaderView

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
               self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 4, MainW/2, 40)];
               [self addSubview:self.titleLab];
      
    }
    return self;
    
}


@end
