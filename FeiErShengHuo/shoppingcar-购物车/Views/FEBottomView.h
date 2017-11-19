//
//  FEBottomView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/22.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FECarGoodsModel.h"
typedef void(^chosedBlock)(NSMutableArray *array);
@class FEBottomView;
@protocol BottomViewDelegate <NSObject>

//选中所有商品
-(void)DidSelectedAllGoods;
//取消选中所有商品
-(void)NoDidSelectedAllGoods;


@end


//typedef void(^cancelchoseAllBlock)();
@interface FEBottomView : UIView

@property(nonatomic,strong)UIButton *selectAllBtn;
@property(nonatomic,strong)UILabel *totalPriceLab;
@property(nonatomic,strong)UIButton *totalNumBtn;

// 全选按钮状态
@property (nonatomic, assign)BOOL AllSelected;

@property (nonatomic, weak)id<BottomViewDelegate> delegate;
@property(nonatomic,copy)chosedBlock block;

-(void)init:(NSDictionary *)dict GoodsData:(NSMutableArray *)goods;

@end
