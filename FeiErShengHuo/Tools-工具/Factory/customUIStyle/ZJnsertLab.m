//
//  insertLab.m
//  zijinlian
//
//  Created by lzy on 2017/3/7.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "ZJInsertLab.h"

@implementation ZJInsertLab

@synthesize insets=_insets;
-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}


-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}
@end
