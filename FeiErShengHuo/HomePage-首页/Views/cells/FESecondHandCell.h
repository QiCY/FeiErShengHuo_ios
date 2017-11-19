//
//  FESecondHandCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/29.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEsecondhandModel.h"
#import "FEPictureModel.h"


@class FESecondHandCell;
@protocol FESecondHandCellDelegate <NSObject>
-(void)doShowImgAction:(NSMutableArray *)tgImgArr andIndex:(NSInteger)idx;

@end

typedef void(^phoneBlock)(NSString *moblie);
@interface FESecondHandCell : UITableViewCell

{
    UIImageView *_headimageView;
    
    
    UILabel *_mobileLab;
    UILabel *_rankLab;
    UILabel *_publishdateLab;
    UIView *_nineImageView;
    UILabel *_contentLab;
    UIImageView *_regionimageView;
    UILabel *_regionLab;
   
   
    
}
@property(nonatomic,copy)phoneBlock block;

@property (nonatomic, assign) id<FESecondHandCellDelegate> delegate;
@property(nonatomic,strong)UILabel *originPriceLab;
@property(nonatomic,strong)UILabel *nowPriceLab;
@property(nonatomic,strong) UIButton *phoneBtn;
@property(nonatomic,strong) UIButton *personReciveBtn;
@property(nonatomic,strong)FEsecondhandModel *model;



+(CGFloat)countSecondHandCellHeightByModel:(FEsecondhandModel *)model;

@end
