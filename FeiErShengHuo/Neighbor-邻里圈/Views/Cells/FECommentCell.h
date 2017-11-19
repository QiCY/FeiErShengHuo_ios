//
//  FECommentCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/21.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEcommentModel.h"
#import "FEStoreCommentModel.h"

#import "FENeighberCommentModel.h"

@interface FECommentCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headImageView;
@property(nonatomic,strong)UILabel *commentMemNameLab;
@property(nonatomic)UILabel *commentLab;
@property(nonatomic,strong)UILabel *timeDetailLab;
//朋友圈评论
-(void)setupNeighberCellWithModel:(FENeighberCommentModel *)model;

-(void)setupInerttingCellWithModel:(FEcommentModel *)model;


-(void)setupStoreCellWithModel:(FEStoreCommentModel *)model;

@end
