//
//  FENoticeViewController.h
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEBaseViewController.h"
#import "PullTableView.h"

typedef void(^dissIndexBlock)();

@interface FENoticeViewController : FEBaseViewController
@property(nonatomic,strong)UITableView *noticeListTableView;

@property(nonatomic,copy)dissIndexBlock block;


@end
