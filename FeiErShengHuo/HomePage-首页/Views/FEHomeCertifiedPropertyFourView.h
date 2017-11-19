//
//  FEHomeCertifiedPropertyFourView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FEHomeCertifiedPropertyFourView;
typedef void(^dissmissBlock)();

@protocol FEHomeCertifiedPropertyFourViewdelegate <NSObject>

-(void)choseFourCollectionBtnView:(FEHomeCertifiedPropertyFourView *)CollectionBtnView didSelectedItemAtIndex:(NSInteger)index;

@end


@interface FEHomeCertifiedPropertyFourView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIButton *BackGroundBnt;
@property(nonatomic,strong)UIView *fourView;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,assign)int indexC;
@property(nonatomic,strong)dissmissBlock block;

@property(nonatomic,weak)id<FEHomeCertifiedPropertyFourViewdelegate> delegete;

@end
