//
//  FEOpenDoorCell.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FEOpenDoorModel.h"
@class FEOpenDoorCell;

typedef void(^DoorCellBlock)(FEOpenDoorCell *);

typedef void(^renameBlock)(FEOpenDoorCell *);
typedef void(^deleteBlock)(FEOpenDoorCell *);
typedef void(^shareBlock)(FEOpenDoorCell *);

@interface FEOpenDoorCell : UITableViewCell
@property(nonatomic,strong)UILabel *limitTimeLab;

@property(nonatomic,copy)DoorCellBlock doorblock;

@property(nonatomic,copy)renameBlock renameblock;

@property(nonatomic,copy)deleteBlock deleteblock;
@property(nonatomic,copy)shareBlock shareblock;
//UILabel *doorNameLab
@property(nonatomic,strong)UILabel *doorNameLab;
@property(nonatomic,strong)FEOpenDoorModel *model;

@property(nonatomic,strong)FL_Button *openBtn;
@property(nonatomic,strong)FL_Button *sharedBtn;

@end
