//
//  FEItertingDetailCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEIntertingDetailModel.h"

@interface FEItertingDetailCell : UITableViewCell

{
    UIImageView *_topicPicImageView;
    UILabel *_authorLab;
    UILabel *_topicThemeLab;
    UILabel *_createTimeStrLab;
    
    
}
@property(nonatomic,assign)CGFloat HW2;


-(void)setupCellWithModel:(FEIntertingDetailModel *)model;

@end
