//
//  FESmartPowerPlugViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESmartPowerPlugViewController.h"
#import "FEQueueTaskListViewController.h"

@interface FESmartPowerPlugViewController ()

@property (nonatomic,strong) BLDNADevice *device;

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIButton *switchButton;


@end

@implementation FESmartPowerPlugViewController

+ (FESmartPowerPlugViewController *)controllerWithDevice:(BLDNADevice *)device
{
    FESmartPowerPlugViewController *fvc = [[FESmartPowerPlugViewController alloc] init];
    fvc.device = device;
    return fvc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"智能插座";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(queueTaskAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    [[BroadLinkHelper sharedBroadLinkHelper] bl_initDeviceScript:self.device complete:^(BOOL success) {
        
        success ? [self getDeviceSwithStatus] : nil;
        
    }];
}

- (void)initView
{
    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.switchButton];
    
    //@weakify(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       // @strongify(self);
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //@strongify(self);
        make.size.mas_equalTo(CGSizeMake(256/2, 858/2));
        make.centerY.mas_equalTo(self.view).offset(35);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)getDeviceSwithStatus
{
    NSInteger status = [[BroadLinkHelper sharedBroadLinkHelper] bl_getSmartSocketDeviceSwitchStatus:self.device];
    if (status == -1) {
        
        
        self.switchButton.enabled = NO;
        [FENavTool showAlertViewByAlertMsg:@"设备不可用" andType:@"提示"];
    }
    else {
        self.switchButton.selected = status;
    }
}

- (void)switchButtonClick:(UIButton *)button
{
    NSInteger target = !(button.selected);
    [[BroadLinkHelper sharedBroadLinkHelper] bl_operationSmartSocketDevice:self.device status:target complete:^(BOOL success) {
        
        if (success) {
            button.selected = target;
        }
        
    }];
    
}

- (void)queueTaskAction
{
    FEQueueTaskListViewController *fvc = [FEQueueTaskListViewController controllerWithDevice:self.device];
    [self.navigationController pushViewController:fvc animated:YES];
}

#pragma mark - getter
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_socket_bg"]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UIButton *)switchButton
{
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchButton.adjustsImageWhenHighlighted = NO;
        _switchButton.adjustsImageWhenDisabled = NO;
        [_switchButton setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"icon_open1"] forState:UIControlStateSelected];
        _switchButton.adjustsImageWhenHighlighted = NO;
        
        [_switchButton addTarget:self action:@selector(switchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
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
