//
//  FEEnvironmentaLDetectorViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEEnvironmentaLDetectorViewController.h"
#import "FEEnvironmentaLDetectorView.h"

@interface FEEnvironmentaLDetectorViewController ()

@property (nonatomic,strong) NSTimer *operationTimer;

@property (nonatomic,strong) BLDNADevice *device;

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) FEEnvironmentaLDetectorView *mainOperationView;

@end

@implementation FEEnvironmentaLDetectorViewController

+ (FEEnvironmentaLDetectorViewController *)controllerWithDevice:(BLDNADevice *)device
{
    FEEnvironmentaLDetectorViewController *fvc = [[FEEnvironmentaLDetectorViewController alloc] init];
    fvc.device = device;
    return fvc;
}

- (void)dealloc
{
    [self closeTimer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //@weakify(self);
    [[BroadLinkHelper sharedBroadLinkHelper] bl_initDeviceScript:self.device complete:^(BOOL success) {
        //@strongify(self);
        success ? [self getDeviceStatus] : nil;
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self closeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"环境监测仪";
    

}

- (void)initView
{
    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.mainOperationView];
    
    //@weakify(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       // @strongify(self);
        make.edges.mas_equalTo(self.view);
    }];

    [self.mainOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
       // @strongify(self);
        make.edges.mas_equalTo(self.bgImageView);
    }];
    
}

- (void)getDeviceStatus
{
    [self closeTimer];
    
    self.operationTimer =  [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(queueGetEnvironmentalStatus) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.operationTimer forMode:NSRunLoopCommonModes];
    [self.operationTimer fire];

}

- (void)queueGetEnvironmentalStatus
{
   // @weakify(self);
    [[BroadLinkHelper sharedBroadLinkHelper] bl_getEnvironmentaLDetectorData:self.device complete:^(NSString *temperatureValue, NSString *humidityValue, NSString *lightValue, NSString *airValue, NSString *noisyValue) {
       // @strongify(self);
        [self.mainOperationView refreshViewWithTemperature:temperatureValue humidity:humidityValue light:lightValue air:airValue noisy:noisyValue];
        
    }];
}

- (void)closeTimer
{
    [self.operationTimer invalidate];
    self.operationTimer = nil;
}

#pragma mark - getter
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"env_monitor_bg"]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (FEEnvironmentaLDetectorView *)mainOperationView
{
    if (!_mainOperationView) {
        _mainOperationView = [[FEEnvironmentaLDetectorView alloc] init];
        _mainOperationView.backgroundColor = [UIColor clearColor];
    }
    return _mainOperationView;
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
