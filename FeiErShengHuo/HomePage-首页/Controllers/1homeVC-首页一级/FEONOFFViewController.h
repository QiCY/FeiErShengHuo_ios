//
//  FEONOFFViewController.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/17.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"

typedef void(^ONOFFBlock)(BOOL isON);
@interface FEONOFFViewController : FEBaseViewController
@property(nonatomic,copy)ONOFFBlock block;

@end
