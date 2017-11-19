//
//  FESceneOperationResultView.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESceneOperationResultView.h"
#import "FESceneOperationResultItemCell.h"

@interface FESceneOperationResultView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *resultArray;
@property (nonatomic,strong) NSString *sceneName;

@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *cancelButton;

@end

@interface FESceneOperationResultView ()

@end

@implementation FESceneOperationResultView

+ (FESceneOperationResultView *)viewWithDevices:(NSArray<BLDNADevice *> *)devices sceneName:(NSString *)sceneName
{
    FESceneOperationResultView *view = [[FESceneOperationResultView alloc] init];
    [view.dataArray addObjectsFromArray:devices];
    
    for (NSInteger i = 0; i<devices.count; i++) {
        [view.resultArray addObject:@0];
    }
    
    view.sceneName = sceneName;
    [view setupView];
    return view;
}

- (void)setupView
{
    [self.tableView registerClass:[FESceneOperationResultItemCell class] forCellReuseIdentifier:[FESceneOperationResultItemCell reuseIdentifier]];
    self.tableView.rowHeight = 40;
    
    [self addSubview:self.mainView];
    [self.mainView addSubview:self.infoLabel];
    [self.mainView addSubview:self.tableView];
    [self.mainView addSubview:self.cancelButton];
    
    
    self.infoLabel.text = [NSString stringWithFormat:@"%@场景执行中...",self.sceneName];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    self.mainView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-260, CGRectGetWidth(self.frame), 260);
    self.infoLabel.frame = CGRectMake(10, 0, CGRectGetWidth(self.mainView.frame)-10*2, 50);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.infoLabel.frame), CGRectGetWidth(self.mainView.frame), 40*4);
    self.cancelButton.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), CGRectGetWidth(self.mainView.frame), 50);
    
    
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)refreshItem:(NSInteger)index result:(BOOL)success
{
    NSLog(@"index = %ld",index);
    NSNumber *result = success ? @1 : @2;
    [self.resultArray replaceObjectAtIndex:index withObject:result];
    [self.tableView reloadData];
    
    if (index == self.dataArray.count - 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismiss];
        });
    }
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
    NSString *cellId = [FESceneOperationResultItemCell reuseIdentifier];
    FESceneOperationResultItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    BLDNADevice *device = self.dataArray[indexPath.row];
    NSNumber *result = self.resultArray[indexPath.row];
    [cell refreshCellWithDevice:device index:indexPath.row+1 result:result.integerValue];
    return cell;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)resultArray
{
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.backgroundColor = [UIColor whiteColor];
        _infoLabel.font = [UIFont boldSystemFontOfSize:15];
        _infoLabel.textColor = [UIColor blackColor];
    }
    return _infoLabel;
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
        [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            self.shouldCancelOperation ? self.shouldCancelOperation () : nil;
            [self dismiss];
        }];
    }
    return _cancelButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
