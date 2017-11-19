//
//  FEIntergralDetailSecondCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/9.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEIntergralDeatialModel.h"
@class FEIntergralDetailSecondCell;
@protocol FEIntergralDetailSecondCellDelegete <NSObject>

-(void)goDetailInfoAdress;

@end

@interface FEIntergralDetailSecondCell : UITableViewCell


{
    UILabel *limitlab;
    
    UILabel *zhuyiLab;
    UIButton *exchangeBtn;
    UILabel *liuchengLab;
    
}
@property(nonatomic,strong)UILabel *integralPriceLab;//面值
@property(nonatomic,strong)UILabel *statusLab;//类型
@property(nonatomic,strong)UILabel *validPeriodLab;//有效期
@property(nonatomic,strong)UILabel *liuchengLab1;
@property(nonatomic,strong)UILabel *zhuyiLab1;


@property(nonatomic,weak)id<FEIntergralDetailSecondCellDelegete>delegete;

-(void)setupSecondCellWithModel:(FEIntergralDeatialModel *)model;

+(CGFloat)intergralCountSecondCellHeight;


@end
