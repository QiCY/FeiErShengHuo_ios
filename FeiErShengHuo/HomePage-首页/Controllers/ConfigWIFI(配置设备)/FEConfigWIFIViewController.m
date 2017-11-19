//
//  FEConfigWIFIViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEConfigWIFIViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface FEConfigWIFIViewController ()

@property (nonatomic,strong) UIImageView *bgImageView;

@property (nonatomic,strong) UITextField *ssidTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UIButton *configButton;

@end

@implementation FEConfigWIFIViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [RYLoadingView hideRequestLoadingView];
    [[BroadLinkHelper sharedBroadLinkHelper] bl_cancelConfigDevice];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.userInteractionEnabled = YES;
    self.ssidTextField.text = [self getCurrentSSIDInfo];
    
    @weakify(self);
    [[RACSignal combineLatest:@[self.ssidTextField.rac_textSignal,
                                             self.passwordTextField.rac_textSignal]
    reduce:^id(NSString *ssid, NSString *password){
        return @(ssid.length && password.length);
    }]
     subscribeNext:^(NSNumber *x) {
         @strongify(self);
         self.configButton.enabled = x.boolValue;
         self.configButton.backgroundColor = x.boolValue ? Green_Color : [UIColor grayColor];
    }];

    
    
}

- (void)initView
{
    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.ssidTextField];
    [self.bgImageView addSubview:self.passwordTextField];
    [self.bgImageView addSubview:self.configButton];
    
    @weakify(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.ssidTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.bgImageView).offset(20);
        make.right.mas_equalTo(self.bgImageView).offset(-20);
        make.top.mas_equalTo(self.bgImageView).offset(50);
        make.height.mas_equalTo(44);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.bgImageView).offset(20);
        make.right.mas_equalTo(self.bgImageView).offset(-20);
        make.top.mas_equalTo(self.ssidTextField.mas_bottom).offset(50);
        make.height.mas_equalTo(44);
    }];
    
    [self.configButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.bgImageView).offset(20);
        make.right.mas_equalTo(self.bgImageView).offset(-20);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(50);
        make.height.mas_equalTo(44);
    }];
}

- (void)configButtonClick
{
    
    NSString *ssid = self.ssidTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [RYLoadingView showRequestLoadingView];
    [[BroadLinkHelper sharedBroadLinkHelper] bl_configDevice:ssid password:password timeout:75 complete:^(BOOL success) {
        [RYLoadingView hideRequestLoadingView];
        NSString *msg = success ? @"配置成功" : @"配置失败";
        [FENavTool showAlertViewByAlertMsg:msg andType:@"提示"];
        [self delayPopBack];
        
    }];

}


- (NSString *)getCurrentSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    
    return [info objectForKey:@"SSID"];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UITextField *)ssidTextField
{
    if (!_ssidTextField) {
        _ssidTextField = [[UITextField alloc] init];
        _ssidTextField.backgroundColor = [UIColor whiteColor];
        _ssidTextField.layer.cornerRadius = 3.0f;
        _ssidTextField.layer.masksToBounds = YES;
        _ssidTextField.layer.borderWidth = 1;
        _ssidTextField.layer.borderColor = [UIColor blackColor].CGColor;
        
        _ssidTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _ssidTextField.autocorrectionType = UITextAutocorrectionTypeYes;
        
        _ssidTextField.placeholder = @"请输入SSID";
    }
    return _ssidTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.layer.cornerRadius = 3.0f;
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.layer.borderWidth = 1;
        _passwordTextField.layer.borderColor = [UIColor blackColor].CGColor;
        
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordTextField.autocorrectionType = UITextAutocorrectionTypeYes;
        
        _passwordTextField.placeholder = @"请输入Password";
    }
    return _passwordTextField;
}

- (UIButton *)configButton
{
    if (!_configButton) {
        _configButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _configButton.backgroundColor = Green_Color;
        [_configButton setTitle:@"配置" forState:UIControlStateNormal];
        
        [_configButton addTarget:self action:@selector(configButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _configButton;
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
