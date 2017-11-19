//
//  BLeAirStatusValueInfo+DataParaser.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/2.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "BLeAirStatusValueInfo+DataParaser.h"

@implementation BLeAirStatusValueInfo (DataParaser)

- (NSString *)getValue
{
    CGFloat floatValue = [[NSString stringWithFormat:@"%ld.%ld",self.integer, self.decimal] doubleValue];
    return [NSString stringWithFormat:@"%@",@(floatValue)];
}

- (NSString *)getAirValue
{
    NSInteger airCondition = self.integer;
    if (airCondition <= 0) {
         return @"优";
    }
    else if (airCondition == 1) {
        return @"良";
    }
    else if (airCondition > 2) {
        return @"差";
    }
    return nil;
}

- (NSString *)getLightValue
{
    NSInteger lightCondition = self.integer;
    if (lightCondition <= 1) {
        return @"暗";
    }
    else if (lightCondition == 2) {
        return @"正常";
    }
    else if (lightCondition >= 3) {
        return @"亮";
    }
    return nil;
}

- (NSString *)getNoisyValue
{
    NSInteger noisyCondition = self.integer;

    if (noisyCondition <= 1) {
        return @"正常";
    }
    else if (noisyCondition == 2) {
        return @"吵闹";
    }
    else if (noisyCondition >= 3) {
        return @"喧哗";
    }
    return nil;
}

@end
