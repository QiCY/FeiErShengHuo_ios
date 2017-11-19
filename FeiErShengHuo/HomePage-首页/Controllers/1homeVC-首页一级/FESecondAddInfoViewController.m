//
//  FESecondAddInfoViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//
#import "FESecondAddInfoViewController.h"
#import "FERegionModel.h"
#import "JHPickView.h"
@interface FESecondAddInfoViewController () < UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, JHPickerDelegate, UIPickerViewDelegate, UINavigationControllerDelegate >
{
    CGFloat cellWidth;
    NSInteger currentSelectNum;
    NSNumber *_regionID;
    UIButton *sureBtn;
    FELoginInfo *_model;
}
@property (nonatomic, strong) UITableView *addInfoTabView;
@property (assign, nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSMutableArray *regionArray;
@property (nonatomic, strong) NSMutableArray *regionInfoArray;


@end
@implementation FESecondAddInfoViewController
- (void)initView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshRegion:) name:NOTI_REFRESH_REGION object:nil];
    //    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(uploadinfo) andType:item_sure];
    self.title = @"健全信息";
    self.addInfoTabView = [UITableView groupTableView];
    self.addInfoTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.addInfoTabView.delegate = self;
    self.addInfoTabView.dataSource = self;
    self.addInfoTabView.sectionHeaderHeight = 0.01;
    self.addInfoTabView.sectionFooterHeight = 0.01;
    self.addInfoTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.addInfoTabView.tableHeaderView = view;
    [self.view addSubview:self.addInfoTabView];
}
- (void)RefreshRegion:(NSNotification *)info
{
    _model = info.object;
    _regionLab.text = _model.regionTitle;
    _regionID = _model.villageId;
    //[_choseRirionBtn setTitle:model.regionTitle forState:0];
}
- (void)dissmissClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    if (section == 1)
    {
        return 1;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    secView.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
    return secView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            //            CGFloat cviewHeightNum = cellWidth*(self.photoArr.count/5+1)+8;
            return 80; //40+cviewHeightNum;
        }
    }
    else
    {
        return 48;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //title label
        UILabel *titLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 100, 16)];
        titLbl.font = [UIFont boldSystemFontOfSize:14.f];
        titLbl.textColor = GLOBAL_BIG_FONT_COLOR;
        titLbl.tag = 1001;
        [cell addSubview:titLbl];
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                //小区名
                _regionLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 17, MainW - 66, 18)];
                _regionLab.textColor = GLOBAL_LITTLE_FONT_COLOR;
                _regionLab.textAlignment = NSTextAlignmentRight;
                _regionLab.font = [UIFont systemFontOfSize:14.f];
                _regionLab.text = @"请选择小区";
                _regionLab.tag = 10086;
                [cell addSubview:_regionLab];
            }
            if (indexPath.row == 1)
            {
                //楼号
                _buildingNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW - 66, 18)];
                [_buildingNumTF FEInputTextFieldStyle];
                 _buildingNumTF.backgroundColor=[UIColor clearColor];
                _buildingNumTF.delegate = self;
                //_buildingNumTF.text = curObj.myUserInfo.contactAddress;
                _buildingNumTF.keyboardType = UIKeyboardTypeNumberPad;
                [cell addSubview:_buildingNumTF];
            }
            if (indexPath.row == 2)
            {
                //单元号
                _unitNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW - 66, 18)];
                [_unitNumTF FEInputTextFieldStyle];
                _unitNumTF.delegate = self;
                //_unitNumTF.text = curObj.myUserInfo.contactAddress;
                _unitNumTF.keyboardType = UIKeyboardTypeNumberPad;
                _unitNumTF.backgroundColor=[UIColor clearColor];
                [cell addSubview:_unitNumTF];
            }
            if (indexPath.row == 3)
            {
                //房间号
                _roomNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 16, MainW - 66, 18)];
                [_roomNumTF FEInputTextFieldStyle];
                _roomNumTF.delegate = self;
                //_roomNumTF.text = curObj.myUserInfo.contactAddress;
                _roomNumTF.keyboardType = UIKeyboardTypeNumberPad;
                _roomNumTF.backgroundColor=[UIColor clearColor];
                [cell addSubview:_roomNumTF];
            }
            if (indexPath.row == 4)
            {
                //租客 和房间
                _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 17, MainW - 66, 18)];
                _typeLab.textColor = GLOBAL_LITTLE_FONT_COLOR;
                _typeLab.textAlignment = NSTextAlignmentRight;
                _typeLab.font = [UIFont systemFontOfSize:14.f];
                _typeLab.text = @"选择类型";
                _typeLab.tag = 10010;
                [cell addSubview:_typeLab];
            }
        }
        if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                sureBtn = [MYUI creatButtonFrame:CGRectMake(10, 30, MainW - 20, 40) backgroundColor:Green_Color setTitle:@"去认证" setTitleColor:[UIColor whiteColor]];
                [sureBtn addTarget:self action:@selector(goRenZheng) forControlEvents:UIControlEventTouchUpInside];
                sureBtn.layer.masksToBounds = YES;
                sureBtn.layer.cornerRadius = 5;
                [cell addSubview:sureBtn];
            }
        }
    }
    NSArray *regionarray = @[ @"小区名", @"楼号", @"单元号", @"房间号", @"类型" ];
    UILabel *ttlbl = (UILabel *)[cell viewWithTag:1001];
    if (indexPath.section == 0)
    {
        ttlbl.text = regionarray[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            //            JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
            //            picker.delegate = self ;
            //            picker.selectLb.text = @"选择小区";//@"情感状态";
            //            picker.customArr = [NSArray arrayWithArray:_regionArray];//_regionArray;//@[@"已婚",@"未婚",@"保密"];
            //
            //            [self.view addSubview:picker];
            FEShengViewController *vc = [[FEShengViewController alloc] init];
            vc.number = [NSNumber numberWithInt:2];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 4)
        {
            JHPickView *picker = [[JHPickView alloc] initWithFrame:self.view.bounds];
            picker.delegate = self;
            picker.selectLb.text = @"选择类型"; //@"情感状态";
            picker.customArr = @[ @"业主", @"租客" ];
            // [NSArray arrayWithArray:_regionArray];//_regionArray;//@[@"已婚",@"未婚",@"保密"];
            [self.view addSubview:picker];
        }
    }
}
- (void)requestRegionArray
{
    NSString *str = @"020appd/goto/showVillagexinxi";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"获取小区列表---%@", dic);
                                                     NSArray *array = [FERegionModel mj_objectArrayWithKeyValuesArray:dic[@"regionInfos"]];
                                                     for (FERegionModel *model in array)
                                                     {
                                                         NSString *title = model.regionTitle;
                                                         [_regionArray addObject:title];
                                                         [_regionInfoArray addObject:model];
                                                     }
                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}
- (void)PickerSelectorIndixString:(NSString *)str
{
    //取得某个cell元素
    UITableViewCell *cell1 = [self.addInfoTabView cellForRowAtIndexPath:self.selectedIndexPath];
    UILabel *lab = (UILabel *)[cell1 viewWithTag:10086];
    lab.text = str;
    //    for (FERegionModel *model in _regionInfoArray) {
    //        if ([model.regionTitle isEqual:str]) {
    //
    //            _regionID=model.regionId;
    //
    //            NSLog(@"这个小区的编号----%@ ",model.regionId);
    //            break;
    //
    //        }
    //    }
    UILabel *lab2 = (UILabel *)[cell1 viewWithTag:10010];
    lab2.text = str;
    NSLog(@"选择的----str--%@", str);
}
#pragma mark textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)goRenZheng
{
    if (_buildingNumTF.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入楼号" andType:@"提示"];
        return;
    }
    if (_unitNumTF.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入单元号" andType:@"提示"];
        return;
    }
    if (_roomNumTF.text.length == 0)
    {
        [FENavTool showAlertViewByAlertMsg:@"请输入房间号" andType:@"提示"];
        return;
    }
    //_typeLab.text=@"选择类型";_regionLab.text=@"请选择小区";
    if ([_typeLab.text isEqualToString:@"选择类型"])
    {
        [FENavTool showAlertViewByAlertMsg:@"请选择类型" andType:@"提示"];
        return;
    }
    if ([_regionLab.text isEqualToString:@"请选择小区"])
    {
        [FENavTool showAlertViewByAlertMsg:@"请选择小区" andType:@"提示"];
        return;
    }
    NSString *str = @"020appd/goto/xiugaiCommunity";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInt:-1] forKey:@"communityCommitId"];
    [dic setObject:_regionID forKey:@"regionId"];
    [dic setObject:[NSString stringWithFormat:@"%@栋%@单元%@室", _buildingNumTF.text, _unitNumTF.text, _roomNumTF.text] forKey:@"homeAdress"];
    [dic setObject:_typeLab.text forKey:@"identity"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"更换成功222222Dic--%@", dic);
                                                     [self.navigationController popViewControllerAnimated:YES];
                                                     FELoginInfo *info = [LoginUtil getInfoFromLocal];
                                                     info.regionTitle = _regionLab.text;
                                                     // [LoginUtil saveing:info];
                                                     [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_REGION object:info];
                                                     //[self.navigationController popToRootViewControllerAnimated:YES];
                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
    //    NSString *str=@"020appd/goto/soundUser";
    //    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    //
    //    NSString * homeAdress=[NSString stringWithFormat:@"%@栋%@单元%@室",_buildingNumTF.text,_unitNumTF.text,_roomNumTF.text];
    //    [dic setObject:_regionID forKey:@"regionId"];
    //
    //    [dic setObject:homeAdress forKey:@"homeAdress"];
    //
    //    [dic setObject:_phoneTF.text forKey:@"mobile"];
    //    [dic setObject:_typeLab.text forKey:@"identity"];
    //    [dic setObject:_nameTF.text  forKey:@"strueName"];
    //
    //
    //    [RYLoadingView showRequestLoadingView];
    //    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:dic withSuccessBlock:^(NSDictionary *dic) {
    //        NSLog(@"  成功啦啦啦阿拉啦");
    //
    //
    //        FELoginInfo *info=[LoginUtil getInfoFromLocal];
    //        info.regionId=_model.regionId;
    //        info.regionTitle=_model.regionTitle;
    //        [LoginUtil saveing:info];
    //        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_REFRESH_REGION object:_model];
    //
    //
    //
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //
    //
    //
    //
    //    } withfialedBlock:^(NSString *msg) {
    //
    //    }];
    //
}
@end
