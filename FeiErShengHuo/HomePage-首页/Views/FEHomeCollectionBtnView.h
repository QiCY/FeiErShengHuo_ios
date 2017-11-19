//
//  FEHomeCollectionBtnView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEHomeCelletionCell.h"
@class FEHomeCollectionBtnView;
@protocol FEHomeCollectionBtnViewdelegate <NSObject>

-(void)choseCollectionBtnView:(FEHomeCollectionBtnView *)CollectionBtnView didSelectedItemAtIndex:(NSInteger)index;

@end
@interface FEHomeCollectionBtnView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) id<FEHomeCollectionBtnViewdelegate> delegate;
@property(nonatomic,strong)NSArray *dataarray;
@property(nonatomic,strong)NSArray *tempArray;
@end
