//
//  FEFourPositionSocketViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEFourPositionSocketViewController.h"
#import "FEFourPositionSocketView.h"

@interface FEFourPositionSocketViewController ()

@property (nonatomic,strong) BLDNADevice *device;

@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UIImageView *titleView;
@property (nonatomic,strong) UIButton *centerControlButton;

@property (nonatomic,strong) FEFourPositionSocketView *mainOperationView;

@end

@implementation FEFourPositionSocketViewController

+ (FEFourPositionSocketViewController *)controllerWithDevice:(BLDNADevice *)device
{
    FEFourPositionSocketViewController *fvc = [[FEFourPositionSocketViewController alloc] init];
    fvc.device = device;
    return fvc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"四位插座";
        
    [[BroadLinkHelper sharedBroadLinkHelper] bl_initDeviceScript:self.device complete:^(BOOL success) {
        
        success ? [self getDeviceSwithStatus] : nil;
        
    }];
    
}

- (void)initView
{
    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.titleView];
    [self.bgImageView addSubview:self.centerControlButton];
    [self.bgImageView addSubview:self.mainOperationView];
    
    @weakify(self);
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.bgImageView);
        make.right.mas_equalTo(self.centerControlButton.mas_left);
        make.height.mas_equalTo(118/2);
        make.centerY.mas_equalTo(self.centerControlButton);
    }];
    
    [self.centerControlButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(182/2, 148/2));
        make.right.mas_equalTo(self.bgImageView).offset(-18);
        make.top.mas_equalTo(self.bgImageView).offset(18);
    }];
    
    [self.mainOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.centerControlButton.mas_bottom).offset(12);
        make.left.right.bottom.mas_equalTo(self.bgImageView);
    }];
}

- (void)getDeviceSwithStatus
{
    [[BroadLinkHelper sharedBroadLinkHelper] bl_getFourSmartSocketDeviceSwitchStatus:self.device comlete:^(NSInteger totalPwr, NSInteger pwr1, NSInteger pwr2, NSInteger pwr3, NSInteger pwr4) {
        
        if (totalPwr == -1) {
            self.centerControlButton.enabled = NO;
            
        }
        else {
            self.centerControlButton.selected = totalPwr;
        }
        
        if (pwr1 == -1) {
            self.mainOperationView.socket1Enable = NO;
        }
        else {
            self.mainOperationView.socket1Selected = pwr1;
        }
        
        if (pwr2 == -1) {
            self.mainOperationView.socket2Enable = NO;
        }
        else {
            self.mainOperationView.socket2Selected = pwr2;
        }
        
        if (pwr3 == -1) {
            self.mainOperationView.socket3Enable = NO;
        }
        else {
            self.mainOperationView.socket3Selected = pwr3;
        }

        if (pwr4 == -1) {
            self.mainOperationView.socket4Enable = NO;
        }
        else {
            self.mainOperationView.socket4Selected = pwr4;
        }
        
    }];
}

- (void)centerControlButtonClick:(UIButton *)button
{
    NSInteger target = !(button.selected);
    [[BroadLinkHelper sharedBroadLinkHelper] bl_operationFourSmartSocketDevice:self.device index:0 status:target complete:^(BOOL success) {
        
        if (success) {
            
            button.selected = target;
            
            self.mainOperationView.socket1Selected = target;
            self.mainOperationView.socket2Selected = target;
            self.mainOperationView.socket3Selected = target;
            self.mainOperationView.socket4Selected = target;
        }
        
    }];
}

- (void)handleMainOperationButtonClick:(NSInteger)index targetOn:(BOOL)targetOn
{
    NSInteger target = targetOn;
    [[BroadLinkHelper sharedBroadLinkHelper] bl_operationFourSmartSocketDevice:self.device index:index status:target complete:^(BOOL success) {
        
        if (success) {
            
            [self.mainOperationView refreshStatusWithIndex:index targetOn:targetOn];
            
            self.centerControlButton.selected = (self.mainOperationView.socket1Selected &&
                                                               self.mainOperationView.socket2Selected &&
                                                               self.mainOperationView.socket3Selected &&
                                                               self.mainOperationView.socket4Selected);
            
        }
        
    }];

}

#pragma mark - getter
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fSocket_bg"]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UIImageView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_four1_title"]];
        _titleView.contentMode = UIViewContentModeCenter;
    }
    return _titleView;
}

- (UIButton *)centerControlButton
{
    if (!_centerControlButton) {
        _centerControlButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerControlButton setImage:[UIImage imageNamed:@"icon_four1_2button"] forState:UIControlStateNormal];
        [_centerControlButton setImage:[UIImage imageNamed:@"icon_four1_1button"] forState:UIControlStateSelected];
        _centerControlButton.adjustsImageWhenHighlighted = NO;
        
        [_centerControlButton addTarget:self action:@selector(centerControlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerControlButton;
}

- (FEFourPositionSocketView *)mainOperationView
{
    if (!_mainOperationView) {
        _mainOperationView = [[FEFourPositionSocketView alloc] init];
        _mainOperationView.backgroundColor = [UIColor clearColor];
        
        @weakify(self);
        _mainOperationView.didClickSocketButton = ^(NSInteger index, BOOL targetOn) {
            @strongify(self);
            [self handleMainOperationButtonClick:index targetOn:targetOn];
        };
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
