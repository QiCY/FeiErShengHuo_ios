//
//  FENineBtnView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/13.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FENineBtnView;
@protocol FEHomeFENineBtnViewdelegate <NSObject>

-(void)choseNineCollectionBtnView:(FENineBtnView *)CollectionBtnView didSelectedItemAtIndex:(NSInteger)index;

@end


@interface FENineBtnView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIButton * BackGroundBtn;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIView *fourView;
@property(nonatomic,strong)UILabel *lab;

@property(nonatomic,strong)id<FEHomeFENineBtnViewdelegate> delegete;


@end
