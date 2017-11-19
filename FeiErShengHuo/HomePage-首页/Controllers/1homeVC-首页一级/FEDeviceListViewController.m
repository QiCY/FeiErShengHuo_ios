//
//  FEDeviceListViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEDeviceListViewController.h"
#import "DeviceSectionModel.h"
#import "FEDeviceListCell.h"
#import "FEDeviceSectionHeaderView.h"

@interface FEDeviceListViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation FEDeviceListViewController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备列表";

    [self setupView];

    [self deviceListRequest];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];

    //    self.bgImageView.frame = self.view.bounds;
    //    [self.view addSubview:self.bgImageView];
    //    [self.view insertSubview:self.bgImageView belowSubview:self.tableView];

    self.tableView.rowHeight = 64;
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;

    //    self.tableView.backgroundColor = [UIColor clearColor];

    [self.tableView registerClass:[FEDeviceListCell class] forCellReuseIdentifier:[FEDeviceListCell reuseIdentifier]];
    [self.tableView registerClass:[FEDeviceSectionHeaderView class] forHeaderFooterViewReuseIdentifier:[FEDeviceSectionHeaderView reuseIdentifier]];
}

- (void)deviceListRequest
{
    [RYLoadingView showRequestLoadingView];
    [[BroadLinkHelper sharedBroadLinkHelper] bl_getRemoteDeviceListComplete:^(NSArray< BLDNADevice * > *deviceList) {

      [self preparaDeviceDataSource:deviceList.mutableCopy];

    }
                                                                     failed:^{

                                                                     }];
}

- (void)preparaDeviceDataSource:(NSArray *)deviceList
{
    if (![deviceList isKindOfClass:[NSArray class]])
    {
        return;
    }
    if (deviceList.count == 0)
    {
        return;
    }

    /// 分别建立五种类型的Section
    /// 智能插座
    DeviceSectionModel *section1 = [DeviceSectionModel smartSocketSection];
    /// 四位排插
    DeviceSectionModel *section2 = [DeviceSectionModel fourHoldSocketSection];
    /// 环境监测仪
    DeviceSectionModel *section3 = [DeviceSectionModel yanacoSection];
    /// 智能遥控
    DeviceSectionModel *section4 = [DeviceSectionModel smartControlSection];
    /// 智能插座10A
    DeviceSectionModel *section5 = [DeviceSectionModel smartSocket10ASection];

    /**
        在此实例化DeviceModel并且装入Section的Devices里
     **/

    for (BLDNADevice *device in deviceList)
    {
        if ([section1 isInSelf:device.pid])
        {
            [section1.devices addObject:device];
        }
        if ([section2 isInSelf:device.pid])
        {
            [section2.devices addObject:device];
        }
        if ([section3 isInSelf:device.pid] && self.isSelectSwitch == NO)
        {
            [section3.devices addObject:device];
        }
        if ([section4 isInSelf:device.pid] && self.isSelectSwitch == NO)
        {
            [section4.devices addObject:device];
        }
        if ([section5 isInSelf:device.pid])
        {
            [section5.devices addObject:device];
        }
    }

    /// 添加五种Section
    [self addSection:section1];
    [self addSection:section2];
    [self addSection:section3];
    [self addSection:section4];
    [self addSection:section5];

    [self.tableView reloadData];
}

- (void)addSection:(DeviceSectionModel *)section
{
    if (section.devices.count == 0)
        return;

    [self.dataArray addObject:section];
}

- (void)scanDeviceAction
{
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DeviceSectionModel *dsection = self.dataArray[section];
    return dsection.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [FEDeviceListCell reuseIdentifier];
    FEDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    DeviceSectionModel *dsection = self.dataArray[indexPath.section];
    BLDNADevice *device = dsection.devices[indexPath.row];
    [cell refreshCellWithDevice:device];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *viewId = [FEDeviceSectionHeaderView reuseIdentifier];
    FEDeviceSectionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewId];
    DeviceSectionModel *dsection = self.dataArray[section];
    view.title = dsection.pname;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceSectionModel *dsection = self.dataArray[indexPath.section];
    BLDNADevice *device = dsection.devices[indexPath.row];
    if (self.didSelectDevice)
    {
        [self.navigationController popViewControllerAnimated:YES];
        self.didSelectDevice(device);
    }
    else
    {
        [[BroadLinkHelper sharedBroadLinkHelper] bl_showDeviceDetail:device inController:self];
    }
}

#pragma mark - getter
- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _bgImageView;
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
