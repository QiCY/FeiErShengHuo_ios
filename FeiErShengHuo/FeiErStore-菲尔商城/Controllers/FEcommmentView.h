//
//  FEcommmentView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FEcommmentView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *comntlist;
@property(nonatomic,strong)UIButton *bgbtn;

@end
