//
//  MineHeaderView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^headClickBlock)();

@protocol headClickdelegete <NSObject>

-(void)headClick:(UITapGestureRecognizer *)tap;


@end


@interface MineHeaderView : UIView
@property(nonatomic,strong) UIImageView *personHeadView;
@property(nonatomic,strong)UILabel *nameLab;

@property(nonatomic,strong)UILabel *areaLab;
@property(nonatomic,strong)UILabel *phoneLab;

@property(nonatomic,weak)id<headClickdelegete> delegete;

@end
