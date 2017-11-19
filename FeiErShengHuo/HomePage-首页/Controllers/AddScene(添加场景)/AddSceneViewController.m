//
//  AddSceneViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "AddSceneViewController.h"
#import "NSObject+Json.h"

#import "FEDeviceListViewController.h"
#import "FEDeviceListCell.h"

#import "ZLActionSheet.h"
#import "UITextField+ld_Edge.h"

@interface AddSceneViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UITableView *tableView;

//  did(deviceId)   status(0关1开)   bid(开关传0，其他暂时不管)
@property (nonatomic,strong) NSMutableArray <BLDNADevice *>*deviceList;
@property (nonatomic,strong) NSMutableArray <NSDictionary *>*deviceJsonList;
@end

@implementation AddSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加场景";
    
    @weakify(self);
    [[self.textField.rac_textSignal map:^id(NSString *value) {
        return @(value.length > 0);
    }] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.addButton.enabled = x.boolValue;
        self.addButton.backgroundColor = x.boolValue ? Green_Color : [UIColor grayColor];
       
        
    }];
}

- (void)initView
{
    
    [self.tableView registerClass:[FEDeviceListCell class] forCellReuseIdentifier:[FEDeviceListCell reuseIdentifier]];
    
    self.tableView.rowHeight = 64;
    
    self.view.backgroundColor = RGB(241, 241, 241);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.mas_equalTo(self.view).offset(18);
        make.right.mas_equalTo(self.view).offset(-18);
        make.top.mas_equalTo(self.view).offset(40);
        make.height.mas_equalTo(44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.textField.mas_bottom).offset(30);
    }];
}

- (void)saveAction
{
    if (self.deviceList.count == 0) {
        [FENavTool showAlertViewByAlertMsg:@"请先添加设备" andType:@"提示"];
        return;
    }
    
    [RYLoadingView showRequestLoadingView];
    NSString *urlString = @"020appd/scenes/addScenesInfo";
    NSDictionary *params = @{@"name":self.textField.text,
                             @"deveiceList":[self getDeviceListJsonString]};
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST withPath:urlString withDictionary:params withSuccessBlock:^(NSDictionary *dic) {
        
        //  添加成功
        [self.navigationController popViewControllerAnimated:YES];
        
    } withfialedBlock:^(NSString *msg) {
        
        //  添加失败
        
    }];

}

- (void)addAction
{
    FEDeviceListViewController *fvc = [[FEDeviceListViewController alloc] init];
    fvc.isSelectSwitch = YES;
    @weakify(self);
    fvc.didSelectDevice = ^(BLDNADevice *device) {
        @strongify(self);
        [self handleDeviceSwitch:device];
    };
    
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)handleDeviceSwitch:(BLDNADevice *)device
{
    NSString *titleString = [NSString stringWithFormat:@"设置%@执行的命令",device.name];
    ZLActionSheet *sheet = [[ZLActionSheet alloc] initWithTitle:titleString message:@""];
    @weakify(self);
    [sheet addBtnTitle:@"开" action:^{
        @strongify(self);
        [self addDevice:1 device:device];
    }];
    [sheet addBtnTitle:@"关" action:^{
        @strongify(self);
        [self addDevice:0 device:device];
    }];
    [sheet showActionSheetWithSender:self];
    
}

- (void)addDevice:(NSInteger)status device:(BLDNADevice *)device
{
 
//    did(deviceId)   status(0关1开)   bid(开关传0，其他暂时不管)
        
    NSDictionary *deviceInfo = @{@"did":device.did,
                                              @"status":@(status),
                                              @"bid":@0};
    
    [self.deviceJsonList addObject:deviceInfo];
    [self.deviceList addObject:device];
    [self.tableView reloadData];
}

- (NSString *)getDeviceListJsonString
{
    NSMutableArray *result = [NSMutableArray arrayWithArray:self.deviceJsonList];
    return [result toJSON];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [FEDeviceListCell reuseIdentifier];
    FEDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    BLDNADevice *device = self.deviceList[indexPath.row];
    [cell refreshCellWithDevice:device];
    return cell;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.cornerRadius = 3.0f;
        _textField.layer.masksToBounds = YES;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _textField.placeholder = @"请输入场景名称";
        
        [_textField ld_setEgdeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    }
    return _textField;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = Green_Color;
        _addButton.layer.cornerRadius = 3.0f;
        _addButton.layer.masksToBounds = YES;
        
        [_addButton setTitle:@"添加设备" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (NSMutableArray <BLDNADevice *>*)deviceList
{
    if (!_deviceList) {
        _deviceList = [NSMutableArray array];
    }
    return _deviceList;
}

- (NSMutableArray <NSDictionary *>*)deviceJsonList
{
    if (!_deviceJsonList) {
        _deviceJsonList = [NSMutableArray array];
    }
    return _deviceJsonList;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGB(241, 241, 241);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 64)];
        view.backgroundColor = [UIColor clearColor];
        view.userInteractionEnabled = YES;
        
        [view addSubview:self.addButton];
        self.addButton.frame = CGRectMake(18, 10, MainW-18*2, 44);
        
        _tableView.tableFooterView = view;
    }
    return _tableView;
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
