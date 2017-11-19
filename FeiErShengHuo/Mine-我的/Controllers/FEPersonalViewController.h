//
//  FEPersonalViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"


@protocol  removedeleegeet <NSObject>

-(void)removedelegete;

-(void)xiugaidelegete:(FELoginInfo *)info;


@end
@interface FEPersonalViewController : FEBaseViewController

@property(nonatomic,weak)id<removedeleegeet>delegete;
//
@property(nonatomic,strong)UITextField *nickNameTF;
@property(nonatomic,strong)UITextField *areaTF;
@property(nonatomic,strong)UITextField *moblieTF;

//
@property(nonatomic,strong)UILabel *regionLab;
@property(nonatomic,strong)UITextField *buildingNumTF;
@property(nonatomic,strong)UITextField *unitNumTF;
@property(nonatomic,strong)UITextField *roomNumTF;




@end
