//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface MRZoomScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRZoomScrollView

@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        [self initImageView];
    }
    return self;
}

- (void)initImageView
{
    self.multipleTouchEnabled = YES;
    self.imageView = [[UIImageView alloc]init];
    // The imageView can be zoomed largest size
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
    self.backgroundColor = [UIColor clearColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                          action:@selector(tapAction:)];
//    [self addGestureRecognizer:tap];
}

-(void)addNewImageToImageView:(UIImage *)image
{
    CGImageRef imgConf = image.CGImage;
    CGFloat width = CGImageGetWidth(imgConf);
    CGFloat height = CGImageGetHeight(imgConf);
    float w = 0.f;
    float h = 0.f;
    CGRect imgRect;
    UIImageOrientation orient =image.imageOrientation;
    if (orient == UIImageOrientationLeft || orient == UIImageOrientationRight) {
        CGFloat cen = width;
        width = height;
        height = cen;
    } else {
    }
    if (width < self.frame.size.width && height < self.frame.size.height) {
        w = width;
        h = height;
        imgRect = CGRectMake(0, 0, w, h);
    } else {
        h = self.frame.size.height;
        w = width * h/height;
        if (w > self.frame.size.width) {
            w = self.frame.size.width;
            h = height * w/width;
        }
        imgRect = CGRectMake(0, 0, w, h);
    }
    CGPoint cent = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    imageView.frame = imgRect;
    imageView.center = cent;
    imageView.image = image;
    
    [self setMinimumZoomScale:.5];
    [self setZoomScale:1];
    [self setMaximumZoomScale:3];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
//    imageView.center = self.center;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (scrollView.contentSize.width < self.frame.size.width) {
        scrollView.contentSize = self.frame.size;
    }
    view.center = CGPointMake(scrollView.contentSize.width/2, scrollView.contentSize.height/2);
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.width < self.frame.size.width) {
        scrollView.contentSize = self.frame.size;
        imageView.center = CGPointMake(scrollView.contentSize.width/2, scrollView.contentSize.height/2);
    }
}

#pragma mark - View cycle
-(void)tapAction:(UITapGestureRecognizer *)gesture
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView animateWithDuration:.4
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL isFinished){
                         [self removeFromSuperview];
                     }];
}

@end
