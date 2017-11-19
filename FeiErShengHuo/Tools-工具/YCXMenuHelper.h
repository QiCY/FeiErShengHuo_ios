//
//  YXMenuHelper.h
//  ApartmentManagementProject
//
//  Created by TAKUMI on 2017/5/18.
//  Copyright © 2017年 TAKUMI. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kYCXMenuImageKey = @"kYCXMenuImageKey";
static NSString * const kYCXMenuNameKey = @"kYCXMenuNameKey";
static NSString * const kYCXMenuTagKey = @"kYCXMenuTagKey";

@interface YCXMenuHelper : NSObject

+ (void)showMenuWithItems:(NSArray <NSDictionary *>*)items frame:(CGRect)frame clickBlock:(void(^)(NSString *name, NSInteger tag))clickBlock;

@end
