//
//  RYImageTool.h
//  CCICPhone
//
//  Created by louis on 15-5-29.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface RYImageTool : NSObject

//指定
+(UIImage*) scaleAndRotateImage:(UIImage*)photoimage width:(CGFloat)bounds_width height:(CGFloat)bounds_height;

+(UIImage *)getImageByView:(UIView *)mView;

+(UIImage *)getNormalImageByScrollView:(UIScrollView *)mView;
+(UIImage *)getNormalImageByView:(UIScrollView *)mView andStart_Y:(float )y;
+(UIImage *)getNormalImageByView:(UIView *)mView;
+(id) addPoint:(CGPoint)point;

+(CGPoint)getCGPointByValue:(id)value;

//生成文件缩略图 175*180
+(CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize;
+(UIImage *)createSmallPic:(UIImage *)img;
+(UIImage *)getImageByImage:(UIImage *)image forSize:(CGSize)size;

//设置view自动适应屏幕
+(void)setViewAutoFrame:(UIView *)view;

//根据图片的真实位置 得到frame
+(CGRect)getImageFrameByOrientation:(UIImage *)img andViewFrame:(CGRect) viewFrame;

+(UIImage *)getLittleImageByImage:(UIImage *)photoimage withWidth:(float)bounds_width andHeight:(float)bounds_height;
+ (UIImage *)fixOrientation:(UIImage *)srcImg;
@end
