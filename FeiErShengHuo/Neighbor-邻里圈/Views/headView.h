//
//  headView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/20.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEDynamicModel.h"

#import "RYImageTool.h"
#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"
#import "FEphotoCell.h"
#import "FEPictureModel.h"

#import "UIImageView+WebCache.h"
//#import "RYLoginInfoObj.h"

#import "RYPersonInfoItem.h"
#import "FEDynamicModel.h"
#import "MLEmojiLabel.h"
#import "RYArticleCellView.h"
#import "FL_Button.h"

#define PERSONAL_INFO_ITEM_HEIGHT 72


@interface headView : UIView
{
    CGFloat titleW;
}

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

//复制和cell的frame
-(void)setUpViewAndModel:(FEDynamicModel *)model;

//计算高度
+(CGFloat)countViewHeightByModel:(FEDynamicModel *)model;


@end
