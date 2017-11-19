//
//  FESecondHandDCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/30.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEsecondhandModel.h"

@interface FESecondHandDCell : UITableViewCell
{
       UILabel *_originPriceLab;
    UILabel *_nowPriceLab;
    
    UIButton *_phoneBtn;
     UIButton *_qulityBtn;
    UIButton *_personReciveBtn;
    
       
}
-(void)setupCellWithModel:(FEsecondhandModel *)model;
@end
