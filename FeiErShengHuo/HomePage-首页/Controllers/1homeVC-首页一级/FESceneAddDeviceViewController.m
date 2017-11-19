//
//  FESceneAddDeviceViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/24.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESceneAddDeviceViewController.h"
#import "FESceneDeviceListView.h"
#import "SceneActionListCell.h"
#import "ZLActionSheet.h"

@interface FESceneAddDeviceViewController () < UITableViewDataSource, UITableViewDelegate >

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation FESceneAddDeviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"场景编辑";
}

- (void)initView
{
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.tableView];
    self.bgImageView.frame = self.view.bounds;
    self.tableView.frame = self.view.bounds;

    [self.tableView registerClass:[SceneActionListCell class] forCellReuseIdentifier:[SceneActionListCell reuseIdentifier]];
    //    self.tableView.rowHeight = 75;
    self.tableView.rowHeight = 5 + 33 + 5;
}

- (void)addOneAction
{
    //    FESceneDeviceListView *listView = [FESceneDeviceListView viewWithDeviceList:[BroadLinkHelper sharedBroadLinkHelper].myDevices];
    //    @weakify(self);
    //    listView.didSelectOneDevice = ^(BLDNADevice *device) {
    //        @strongify(self);
    //        [self showActionSheet:device];
    //    };
    //    [listView show];
}

- (void)showActionSheet:(BLDNADevice *)device
{
    NSString *titleString = [NSString stringWithFormat:@"设置%@执行的命令", device.name];
    ZLActionSheet *sheet = [[ZLActionSheet alloc] initWithTitle:titleString message:@""];
    @weakify(self);
    [sheet addBtnTitle:@"开"
                action:^{
                  @strongify(self);
                  [self addDevice:1 device:device];
                }];
    [sheet addBtnTitle:@"关"
                action:^{
                  @strongify(self);
                  [self addDevice:0 device:device];
                }];
    [sheet showActionSheetWithSender:self];
}

- (void)addDevice:(NSInteger)status device:(BLDNADevice *)device
{
    NSString *urlString = @"020appd/scenes/addshebei";
    NSDictionary *params = @{ @"scenesId" : [NSNumber numberWithInteger:self.sceneId.integerValue],
                              @"did" : device.did,
                              @"status" : [NSNumber numberWithInteger:status] };
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
        withPath:urlString
        withDictionary:params
        withSuccessBlock:^(NSDictionary *dic) {

          NSMutableDictionary *info = @{}.mutableCopy;
          NSString *infoMessage = [NSString stringWithFormat:@"%@%@", device.name, status ? @"开" : @"关"];
          info[@"name"] = infoMessage;
          [self.dataArray addObject:info];
          [self.tableView reloadData];

        }
        withfialedBlock:^(NSString *msg) {
          NSMutableDictionary *info = @{}.mutableCopy;
          NSString *infoMessage = [NSString stringWithFormat:@"%@%@", device.name, status ? @"开" : @"关"];
          info[@"name"] = infoMessage;
          [self.dataArray addObject:info];
          [self.tableView reloadData];
        }];
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
    NSString *cellId = [SceneActionListCell reuseIdentifier];
    SceneActionListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSDictionary *info = self.dataArray[indexPath.row];
    [cell refreshCellWithInfo:info[@"name"] isLeft:!(indexPath.row % 2)];
    return cell;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_Smart_home2"]];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.bottomView;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 60)];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.userInteractionEnabled = YES;

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake((MainW - 40) / 2, 10, 40, 40);
        [button addTarget:self action:@selector(addOneAction) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
    }
    return _bottomView;
}

- (void)didReceiveMemoryWarning
{
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
