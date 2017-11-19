//
//  RYImageTool.m
//  CCICPhone
//
//  Created by louis on 15-5-29.
//
//

#import "RYImageTool.h"

@implementation RYImageTool

+(UIImage *)getImageByView:(UIView *)mView
{
    if(UIGraphicsBeginImageContextWithOptions!= NULL)
    {
        UIGraphicsBeginImageContextWithOptions(mView.frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(mView.frame.size);
    }
    [mView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)getNormalImageByView:(UIScrollView *)mView andStart_Y:(float )y
{
    CGRect rect = CGRectMake(mView.contentOffset.x, mView.contentOffset.y, 1024, 768);
    UIGraphicsBeginImageContext(mView.contentSize);
    [mView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *parentImage = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef imageRef = parentImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect); 
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    UIImage* image = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();  
    return image;
}

+(UIImage *)getNormalImageByScrollView:(UIScrollView *)mView
{
    mView.contentOffset = CGPointMake(0, 0);
    NSArray *subViews = mView.subviews;
    UIView *browserView = nil;
    if (subViews && [subViews count]) {
        for(UIView *view in subViews)
        {
            if (![view isKindOfClass:[UIImageView class]]) {
                browserView = view;
                break;
            }
        }
        CGSize size = mView.contentSize;
        UIGraphicsBeginImageContext(size);
        [browserView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    return nil;
}

+(UIImage *)getNormalImageByView:(UIView *)mView
{
    UIGraphicsBeginImageContext(mView.frame.size);
    [mView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *parentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return parentImage;
}

+(id) addPoint:(CGPoint)point
{
    NSValue *value = [NSValue valueWithBytes:&point objCType:@encode(CGPoint)];
    return value;
}

+(CGPoint)getCGPointByValue:(id)value
{
    CGPoint point;
    [value getValue:&point];
    return point;
}


+(CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize
{
    CGFloat scale;
    CGSize newSize = thisSize;
    if (newSize.height && (newSize.height > aSize.height)) {
        scale = aSize.height/newSize.height;
        newSize.width *= scale;
        newSize.height *= scale;
    }
    
    if (newSize.width && (newSize.width >= aSize.width)) {
        scale = aSize.width / newSize.width;
        newSize.height *= scale;
        newSize.width *= scale;
    }
    return  newSize;
}

+(UIImage *)createSmallPic:(UIImage *)img
{
    CGSize newSz = CGSizeMake(84, 84);
    CGSize size = [RYImageTool fitSize:img.size inSize:newSz];
    
    UIGraphicsBeginImageContext(newSz);
    
    float dwidth = (newSz.width - size.width)/2.0f;
    float dheight = (newSz.height - size.height)/2.0f;
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
    [img drawInRect:rect];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImg;
}

+(UIImage *)getImageByImage:(UIImage *)image forSize:(CGSize)size
{
    CGImageRef imgRef =image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    UIImage *newImage = [RYImageTool scaleAndRotateImage:image
                                                  width:size.width*2
                                                 height:height * (size.width*2/width)];
    return newImage;
}

+(UIImage*) scaleAndRotateImage:(UIImage*)photoimage width:(CGFloat)bounds_width height:(CGFloat)bounds_height
{
    //int kMaxResolution = 300;
    
    CGImageRef imgRef =photoimage.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    bounds.size.width = bounds_width;
    bounds.size.height = bounds_height;
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGFloat scaleRatioheight = bounds.size.height / height;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient =photoimage.imageOrientation;
    switch(orient)
    {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            
            break;
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatioheight);
        CGContextTranslateCTM(context, -height, 0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatioheight);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

+(void)setViewAutoFrame:(UIView *)view
{
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
}

+(CGRect)getImageFrameByOrientation:(UIImage *)img andViewFrame:(CGRect) viewFrame
{
    CGImageRef imgConf = img.CGImage;
    CGFloat width = CGImageGetWidth(imgConf);
    CGFloat height = CGImageGetHeight(imgConf);
    CGRect retRect = CGRectMake(0, 0, 0, 0);
    float w = 0.f;
    float h = 0.f;
    //需要判断图片的横竖
    UIImageOrientation orient =img.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //横屏 摄像头左
        case UIImageOrientationDown: //横屏 摄像头右
        {
            w = viewFrame.size.width;
            h = height * w/width;
            if (h > viewFrame.size.height) {
                h = viewFrame.size.height;
                w = width * h/height;
            }
        }
            break;
        case UIImageOrientationLeft: //竖屏 摄像头下
        case UIImageOrientationRight: //竖屏 摄像头上
        {
//            h = viewFrame.size.height;
//            w = height * h/width;
//            if (w > viewFrame.size.width) {
//                w = viewFrame.size.width;
//                h = height * w/height;
//            }
            h = viewFrame.size.height;
            w = height * h/width;
            if (w > viewFrame.size.width) {
                w = viewFrame.size.width;
                h = width * w/height;
            }
        }
            break;
        default:
            break;
    }
    retRect.size.width = w;
    retRect.size.height = h;
    return retRect;
}

+(UIImage *)getLittleImageByImage:(UIImage *)photoimage withWidth:(float)bounds_width andHeight:(float)bounds_height
{
    UIImage *image = [RYImageTool fixOrientation:photoimage];
    UIGraphicsBeginImageContext(CGSizeMake(bounds_width, bounds_height));
    CGRect rect = CGRectMake(0, 0, bounds_width, bounds_height);
    [image drawInRect:rect];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}

+ (UIImage *)fixOrientation:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
