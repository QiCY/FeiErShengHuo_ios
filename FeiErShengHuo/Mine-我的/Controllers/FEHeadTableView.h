//
//  FEHeadTableView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/26.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FEHeadTableView : UITableView<UIScrollViewDelegate>

/**
 头部可缩放的图片
 */
@property (nonatomic,strong) UIImageView * imgView;


/**
 头部视图初始高度
 */
@property (nonatomic,assign)CGFloat height;


/**
 通过图片和高度
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andImage:(UIImage *)img andHeight:(CGFloat)height;

/**
 通过图片路径和高度
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andImageUrl:(NSString *)imgUrl andHeight:(CGFloat)height;

/**
 通过图片名称
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andImageName:(NSString *)imgName andHeight:(CGFloat)height;

@end
