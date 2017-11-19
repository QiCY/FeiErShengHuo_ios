//
//  FESceneDeviceListView.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESceneDeviceListView.h"

@interface FESceneDeviceListView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIButton *cancelButton;

@end

@implementation FESceneDeviceListView

+ (FESceneDeviceListView *)viewWithDeviceList:(NSArray<BLDNADevice *> *)deviceList
{
    FESceneDeviceListView *view = [[FESceneDeviceListView alloc] init];
    [view.dataArray addObjectsFromArray:deviceList];
    [view setupView];
    return view;
}

- (void)setupView
{
    [self addSubview:self.tableView];
    [self addSubview:self.cancelButton];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell reuseIdentifier]];
}

- (void)show
{
    self.frame = CGRectMake(50, 50, MainW - 50*2, MainH - 50*2);
    self.tableView.frame = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30 - 40);
    self.cancelButton.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.frame.size.width, 40);
    
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)dismiss
{
    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];
    [self removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [UITableViewCell reuseIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    BLDNADevice *device = self.dataArray[indexPath.row];
    cell.textLabel.text = device.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLDNADevice *device = self.dataArray[indexPath.row];
    self.didSelectOneDevice ? self.didSelectOneDevice (device) : nil;
    [self dismiss];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _tableView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self dismiss];
        }];
    }
    return _cancelButton;
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
