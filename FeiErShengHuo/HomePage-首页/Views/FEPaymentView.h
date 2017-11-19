//
//  FEPaymentView.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/7/26.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FEPaymentView;
@protocol FEPaymentViewdelegate <NSObject>

-(void)choseFEPaymentView:(FEPaymentView *)paymentView didSelectedItemAtIndex:(NSInteger)index;

@end
@interface FEPaymentView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIButton *BackGroundBnt;
@property(nonatomic,strong)UIView *fourView;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,weak)id<FEPaymentViewdelegate> delegete;
@end
