//
//  RYImagePreViewController.h
//  CCICPhone
//
//  Created by apple on 15/6/1.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"
#import "FEBaseViewController.h"

@class RYImagePreViewController;
@protocol RYImagePreViewControllerDelegate <NSObject>

-(void)delPhotoByPreView:(RYImagePreViewController *)owner;

@end

@interface RYImagePreViewController : FEBaseViewController
<UIScrollViewDelegate>
{
    BOOL isPush;
}

@property (nonatomic, strong) UIScrollView *nineImageView;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, assign) id<RYImagePreViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger currentIndex;

-(id)initWithImg:(NSArray *)imgArr andIsPush:(BOOL) isP andIndex:(NSInteger)idx;

@end
