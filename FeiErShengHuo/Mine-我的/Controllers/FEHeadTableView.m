//
//  FEHeadTableView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/26.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEHeadTableView.h"

@interface FEHeadTableView ()
/**
 头部可缩放的图片
 */
@property (nonatomic,strong)UIImage * img;


/*
 图片的url链接
 */
@property (nonatomic,strong)NSString * imgUrl;


/*
 图片的名称
 */
@property (nonatomic,strong)NSString * imgName;
@end


@implementation FEHeadTableView

{
    
    CGFloat contentOffSet;
}



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andImage:(UIImage *)img andHeight:(CGFloat)height
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.height = height;
        self.img = img;
        
        [self createHeaderView];
    }
    return self;
}

/**
 通过图片路径和高度
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andImageUrl:(NSString *)imgUrl andHeight:(CGFloat)height
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.height = height;
        self.imgUrl = imgUrl;
        
        [self createHeaderView];
    }
    return self;
    
}


/**
 通过图片名称
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andImageName:(NSString *)imgName andHeight:(CGFloat)height
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.height = height;
        self.imgName = imgName;
        
        [self createHeaderView];
    }
    return self;
}


-(void)createHeaderView
{
    self.backgroundView = [[UIView alloc] init];
    if (_img && _height) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _height)];
        //图片的contentModel 一定要设置成UIViewContentModeScaleAspectFill
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.image = _img;
        [self.backgroundView addSubview:_imgView];
        
        //给相同高度的tableHeaderView  ，避免不显示头部视图，如果不添加tableHeaderView ，下拉的时候才能看见头部的图片
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _height)];
        headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        self.tableHeaderView = headerView;
        
    }
    
}


-(void)setHeight:(CGFloat)height
{
    if (height) {
        _height = height;
    }
}

-(void)setImgUrl:(NSString *)imgUrl
{
    if (imgUrl) {
        
        UIImage *  img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        _img = img;
        
    }
}

-(void)setImgName:(NSString *)imgName
{
    if (imgName) {
        UIImage *img = [UIImage imageNamed:imgName];
        _img = img;
    }
}

-(void)setImg:(UIImage *)img
{
    if (img) {
        _img = img;
    }
}

@end
