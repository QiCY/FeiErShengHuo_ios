//
//  FEFirstComentTableViewCell.h
//  FeiErShengHuo
//
//  Created by lzy on 2017/7/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEStoreCommentModel.h"

typedef void(^commtBlock)();
@interface FEFirstComentTableViewCell : UITableViewCell
{
    UIButton *btn;
    
}
@property (nonatomic, strong) UIImageView *headImageView;
@property(nonatomic,strong)UILabel *commentMemNameLab;
@property(nonatomic)UILabel *commentLab;
@property(nonatomic,strong)UILabel *timeDetailLab;
@property(nonatomic,copy)commtBlock block;
-(void)setupStoreCellWithModel:(FEStoreCommentModel *)model;
@end
