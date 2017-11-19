//
//  FESecondHandDetialViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/30.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "FEsecondhandModel.h"


typedef void(^dissBlock)();

@interface FESecondHandDetialViewController : FEBaseViewController
@property(nonatomic,strong) FEsecondhandModel *Dmodel;
@property(nonatomic,strong) NSString *iamgeName;
@property(nonatomic,strong)NSNumber *shaChu;
@property(nonatomic,strong)NSNumber *secondHandId;

@property(nonatomic,copy)dissBlock block;
@end
