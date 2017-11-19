//
//  YXMenuHelper.m
//  ApartmentManagementProject
//
//  Created by TAKUMI on 2017/5/18.
//  Copyright © 2017年 TAKUMI. All rights reserved.
//

#import "YCXMenuHelper.h"
#import <YCXMenu/YCXMenu.h>

@implementation YCXMenuHelper

+ (void)showMenuWithItems:(NSArray<NSDictionary *> *)items frame:(CGRect)frame clickBlock:(void (^)(NSString *, NSInteger))clickBlock
{
    NSMutableArray *menuItems = [NSMutableArray array];
    
    for (NSDictionary *dict in items) {
        UIImage *image = dict[kYCXMenuImageKey];
        NSString *title = dict[kYCXMenuNameKey];
        NSInteger tag = [dict[kYCXMenuTagKey] integerValue];
        YCXMenuItem *editButton = [YCXMenuItem menuItem:title image:image tag:tag userInfo:nil];
        editButton.titleFont = [UIFont systemFontOfSize:16];
        editButton.foreColor = [UIColor whiteColor];
        [menuItems addObject:editButton];
    }
    
    [YCXMenu setTintColor:[UIColor blackColor]];
    
    [YCXMenu setSelectedColor:[UIColor blackColor]];
    
    [YCXMenu setSeparatorColor:[UIColor clearColor]];
    
    [YCXMenu showMenuInView:[[UIApplication sharedApplication] keyWindow] fromRect:frame menuItems:menuItems selected:^(NSInteger index, YCXMenuItem *item) {
        NSLog(@"%@",item);
        
        clickBlock ? clickBlock (item.title, item.tag) : nil;
    }];

}

@end
