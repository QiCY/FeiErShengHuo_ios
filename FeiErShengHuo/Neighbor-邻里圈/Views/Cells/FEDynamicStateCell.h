//
//  FEDynamicStateCell.h
//  CCICPhone
//
//  Created by apple on 15/6/17.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYPersonInfoItem.h"
#import "FEDynamicModel.h"
#import "MLEmojiLabel.h"
#import "RYArticleCellView.h"
#import "FL_Button.h"

#import "FEDynamicModel.h"

@class FEDynamicStateCell;
@protocol DynamicCellDelegate <NSObject>
-(void)doShowImgAction:(NSMutableArray *)tgImgArr andIndex:(NSInteger)idx;

@end

@interface FEDynamicStateCell : UITableViewCell
{
    CGFloat titleW;
}
@property(nonatomic,strong)FEDynamicModel *model;

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLab;

@property(nonatomic,strong)UIButton *zanBtn;
@property(nonatomic,strong)UIButton *commentBtn;

@property(nonatomic,strong)UILabel *timeDetailLab;
@property(nonatomic,strong)UILabel *FENeighberContantLab;//
@property(nonatomic,strong)UIImageView *AddressImageView;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *nineImageView;
@property (nonatomic, assign) id<DynamicCellDelegate> delegate;

//复制和cell的frame
//-(void)setUpCellViewAndModel:(FEDynamicModel *)model;

//计算高度
+(CGFloat)countCellHeightByModel:(FEDynamicModel *)model;

@end
