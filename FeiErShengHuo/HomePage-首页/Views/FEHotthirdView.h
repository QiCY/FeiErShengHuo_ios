//
//  FEHotthirdView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/10.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^activityBlock)();

typedef void(^goupBuyBlock)();
typedef void(^secondhandBlock)();

@interface FEHotthirdView : UIView <UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *rightView;
@property(nonatomic,strong)UIImageView *rightimageView;
@property(nonatomic,strong)UILabel *rightfirstLab;
@property(nonatomic,strong)UILabel *rightsecondLab;
@property(copy,nonatomic)activityBlock  ABlock;

@property(copy,nonatomic)goupBuyBlock  block;
@property(copy,nonatomic)secondhandBlock  Cblock;

//left
@property(nonatomic,strong)UIView *lefttopView;
@property(nonatomic,strong)UIView *leftbottomView;
@property(nonatomic,strong)UIImageView *lefttopimageView;
@property(nonatomic,strong)UIImageView *leftbottomimageView;
@property(nonatomic,strong)UILabel *leftfirstLab;
@property(nonatomic,strong)UILabel *leftsecondLab;
@property(nonatomic,strong)UILabel *leftthirdLab;
@property(nonatomic,strong)UILabel *leftforthLab;


@end
