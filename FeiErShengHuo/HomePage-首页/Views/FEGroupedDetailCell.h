//
//  FEGroupedDetailCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/15.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEGroupDetailModel.h"
#import "FEGroupedPlayWayView.h"

typedef void(^goupedBuyBlock)(UIButton *btn);
typedef void(^buyOneBlock)(UIButton *btn);


@interface FEGroupedDetailCell : UITableViewCell
{
    UILabel *_groupPrice;
    UILabel *_personPrice;
    
    UILabel *_playWay;
    UILabel *_playWayDeatilLab;
    UILabel *_grayLineLab;
    FEGroupedPlayWayView *_palView;
    UILabel *_fiveLab;
    UIButton *btn1;
    UIButton *btn2;
    
    
}
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *descriptionLab;
@property(nonatomic,strong)UILabel *payNumLab;
@property(nonatomic,strong)UILabel *explainLab;//  说明
@property(nonatomic,copy)goupedBuyBlock block;
@property(nonatomic,copy)buyOneBlock oblock;

@property(nonatomic,strong)UIImageView *groupImageView;//
@property(nonatomic,strong)UIImageView *personBuyImageView;



@property(nonatomic,strong)FEGroupDetailModel *model;


-(void)setUpCellWithModel:(FEGroupDetailModel *)model;

+(CGFloat)countHeigthWith:(FEGroupDetailModel *)model;

@end
