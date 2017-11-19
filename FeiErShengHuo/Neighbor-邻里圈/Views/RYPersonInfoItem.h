//
//  RYPersonInfoItem.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/13.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FEDynamicModel.h"

@class RYPersonInfoItem;
@protocol RYPersonInfoItemDelegate <NSObject>

-(void)clickCurrentItem:(RYPersonInfoItem *)curInfoItem;
-(void)DeleteCurrentItmeMenu:(RYPersonInfoItem *)curInfoItem;

@end

@interface RYPersonInfoItem : UIView
{
}

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *companyLbl;
@property (nonatomic, strong) UILabel *jobLbl;
@property (nonatomic, strong) UIButton *delBtn;
@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic, assign) id<RYPersonInfoItemDelegate> delegate;
//TODO 添加数据源
-(id)initWithFrame:(CGRect)frame;

-(void)updatePersonInfo:(FEDynamicModel *)model;

-(void)setUpAllViews;
@end
