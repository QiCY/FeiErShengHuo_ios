//
//  FEDeviceStoreView.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEDeviceStoreView.h"

@interface FEDeviceStoreView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *catagoryTableview;
@property (nonatomic,strong) UITableView *deviceTableView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation FEDeviceStoreView

- (instancetype)init
{
    if (self = [super init]) {
        self.currentIndex = -1;
        [self addSubview:self.catagoryTableview];
        [self addSubview:self.deviceTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.catagoryTableview.frame = CGRectMake(0, 0, 50, CGRectGetHeight(self.frame));
    self.deviceTableView.frame = CGRectMake(CGRectGetWidth(self.catagoryTableview.frame), 0, CGRectGetWidth(self.frame)-CGRectGetWidth(self.catagoryTableview.frame), CGRectGetHeight(self.frame));
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.catagoryTableview) {
        return self.dataArray.count;
    }
    return self.currentIndex == -1 ? 0 : [self.dataArray[self.currentIndex] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.catagoryTableview) {
        
    }
    
    else if (tableView == self.deviceTableView) {
        
    }
}

- (UITableView *)catagoryTableview
{
    if (!_catagoryTableview) {
        _catagoryTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _catagoryTableview.delegate = self;
        _catagoryTableview.dataSource = self;
        _catagoryTableview.rowHeight = 45;
        _catagoryTableview.tableFooterView = [[UIView alloc] init];
    }
    return _catagoryTableview;
}

- (UITableView *)deviceTableView
{
    if (!_deviceTableView) {
        _deviceTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _deviceTableView.delegate = self;
        _deviceTableView.dataSource = self;
        _deviceTableView.rowHeight = 90;
        _deviceTableView.tableFooterView = [[UIView alloc] init];
    }
    return _deviceTableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
