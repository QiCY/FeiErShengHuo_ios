//
//  FESetQueueTaskViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/8/7.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESetQueueTaskViewController.h"
#import "QueueTaskSetHelper.h"

#import "QueueTaskSetItemView.h"

@interface FESetQueueTaskViewController ()

@property (nonatomic,strong) QueueTaskSetItemView *startView;
@property (nonatomic,strong) QueueTaskSetItemView *endView;
@property (nonatomic,strong) QueueTaskSetItemView *cycleView;

@property (nonatomic,strong) UIButton *saveButton;

@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endTime;
@property (nonatomic,strong) NSString *cycle;

@end

@implementation FESetQueueTaskViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.startTime = @"000000";
        self.endTime = @"000000";
        self.cycle = @"null";
    }
    return self;
}

- (void)initView
{
    
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, startTime),
                                RACObserve(self, endTime),
                                RACObserve(self, cycle)]
                       reduce:^id(NSString *s, NSString *e, NSString *c){
                           return @(s && e && c);
                       }] subscribeNext:^(NSNumber *x) {
                           @strongify(self);
                           self.saveButton.enabled = x.boolValue;
                           self.saveButton.backgroundColor = x.boolValue ? Green_Color : [UIColor grayColor];
                       }];

    

    self.view.backgroundColor = RGB(241, 241, 241);
    [self.view addSubview:self.startView];
    [self.view addSubview:self.endView];
    [self.view addSubview:self.cycleView];
    [self.view addSubview:self.saveButton];
    
    self.startView.frame = CGRectMake(0, 0, MainW, 50);
    self.endView.frame = CGRectMake(0, CGRectGetMaxY(self.startView.frame), MainW, 50);
    self.cycleView.frame = CGRectMake(0, CGRectGetMaxY(self.endView.frame), MainW, 50);
    self.saveButton.frame = CGRectMake(12, CGRectGetMaxY(self.cycleView.frame)+20, MainW-12*2, 50);
    
}
//开始
- (void)selectStartDate
{
    [QueueTaskSetHelper selectDate:self.startTime inController:self complete:^(NSString *dateString) {
        self.startTime = dateString;
        self.startView.value = dateString;
    }];
}
//结束
- (void)selectEndDate
{
    [QueueTaskSetHelper selectDate:self.endTime inController:self complete:^(NSString *dateString) {
        self.endTime = dateString;
        self.endView.value = dateString;
    }];
}

- (void)selectCycle
{
    [QueueTaskSetHelper selectCycle:self.cycle inController:self complete:^(NSString *cycleString) {
        self.cycle= cycleString;
        self.cycleView.value = [QueueTaskSetHelper showCycle:cycleString];
    }];
}

- (void)saveAction
{
    NSDictionary *task = @{QueueTaskCycleKey:self.cycle,
                                     QueueTaskStartTimeKey:[self.startTime stringByReplacingOccurrencesOfString:@":" withString:@""],
                                     QueueTaskEndTimeKey:[self.endTime stringByReplacingOccurrencesOfString:@":" withString:@""],
                                     QueueTaskEnableKey:@"1"};
    
    NSLog(@"-----task %@",task);
    
    
    
    self.shouldAddTask ? self.shouldAddTask (task) : nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (QueueTaskSetItemView *)startView
{
    if (!_startView) {
        _startView = [QueueTaskSetItemView viewWithTitle:@"开"];
        
        @weakify(self);
        _startView.didClickSelf = ^{
            @strongify(self);
            [self selectStartDate];
        };
    }
    return _startView;
}

- (QueueTaskSetItemView *)endView
{
    if (!_endView) {
        _endView = [QueueTaskSetItemView viewWithTitle:@"关"];
        
        @weakify(self);
        _endView.didClickSelf = ^{
            @strongify(self);
            [self selectEndDate];
        };
    }
    return _endView;
}

- (QueueTaskSetItemView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [QueueTaskSetItemView viewWithTitle:@"重复"];
        _cycleView.value = [QueueTaskSetHelper showCycle:@"null"];
        
        @weakify(self);
        _cycleView.didClickSelf = ^{
            @strongify(self);
            [self selectCycle];
        };
    }
    return _cycleView;
}

- (UIButton *)saveButton
{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.backgroundColor = Green_Color;
        _saveButton.layer.cornerRadius = 5.0f;
        _saveButton.layer.masksToBounds = YES;
        
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
