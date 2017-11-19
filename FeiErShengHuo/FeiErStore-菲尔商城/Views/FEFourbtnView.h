//
//  FEFourbtnView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEFourbtnCollectionViewCell.h"
@class FEFourbtnView;
@protocol FEFourbtnViewdelegate <NSObject>

-(void)choseCollectionBtnView:(FEFourbtnView *)FEFourbtnView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface FEFourbtnView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UICollectionView *collections;

@property(nonatomic,strong)NSArray *fourbtnimageArray;
@property(nonatomic,strong)NSArray *fourbtnnameArray;

@property(nonatomic,weak)id <FEFourbtnViewdelegate>delegete;

@end
