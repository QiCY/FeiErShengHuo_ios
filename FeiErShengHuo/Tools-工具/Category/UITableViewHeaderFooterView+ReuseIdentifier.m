//
//  UITableViewHeaderFooterView+ReuseIdentifier.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "UITableViewHeaderFooterView+ReuseIdentifier.h"

@implementation UITableViewHeaderFooterView (ReuseIdentifier)

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
