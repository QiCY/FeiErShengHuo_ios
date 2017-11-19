//
//  UITextField+ld_Edge.m
//  TCHealth
//
//  Created by TAKUMI on 2017/2/28.
//  Copyright © 2017年 TAKUMI. All rights reserved.
//

#import "UITextField+ld_Edge.h"

@implementation UITextField (ld_Edge)

//有边框的TF  边框为1  直角  TF
+ (instancetype)creatRightangle
{
    UITextField *TF=[[UITextField alloc]init];
    TF.layer.borderWidth=1;
    TF.layer.borderColor=[UIColor grayColor].CGColor;
    
    return TF;
}


//无边框的TF





- (void)ld_setLeftEdge:(CGFloat)left
{
    [self setValue:[NSNumber numberWithDouble:left] forKey:@"paddingLeft"];
}

- (void)ld_setRightEdge:(CGFloat)right
{
    [self setValue:[NSNumber numberWithDouble:right] forKey:@"paddingRight"];
}

- (void)ld_setTopEdge:(CGFloat)top
{
    [self setValue:[NSNumber numberWithFloat:top] forKey:@"paddingTop"];
}

- (void)ld_setBottomEdge:(CGFloat)bottom
{
    [self setValue:[NSNumber numberWithDouble:bottom] forKey:@"paddingBottom"];
}

- (void)ld_setEgdeInsets:(UIEdgeInsets)edgeInsets
{
    [self setValue:[NSNumber numberWithDouble:edgeInsets.top] forKey:@"paddingTop"];
    [self setValue:[NSNumber numberWithDouble:edgeInsets.left] forKey:@"paddingLeft"];
    [self setValue:[NSNumber numberWithDouble:edgeInsets.bottom] forKey:@"paddingBottom"];
    [self setValue:[NSNumber numberWithDouble:edgeInsets.right] forKey:@"paddingRight"];
}

@end
