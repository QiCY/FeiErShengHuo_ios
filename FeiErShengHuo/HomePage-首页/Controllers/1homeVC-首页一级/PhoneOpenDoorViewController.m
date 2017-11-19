//
//  PhoneOpenDoorViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "PhoneOpenDoorViewController.h"
#import "FEAddKeyViewController.h"
#import "FEOpenDoorCell.h"
#import "FEOpenDoorModel.h"
#import "MBProgressHUD+MJ.h"
#import "MDManager.h"
#import "MDPublicData.h"
#import "UIImage+GIF.h"

#define DAY @"day"
#define NIGHT @"night"
static CGFloat textFieldH = 40;

@interface PhoneOpenDoorViewController () < UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate ,JHPickerDelegate>
{
    CGFloat _totalKeybordHeight; //键盘高度
    UITextField *_textField;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger selectedIndexPath;

@end
@implementation PhoneOpenDoorViewController

- (void)initView
{
    [[MDManager sharedManager] initBlue];

    self.dataArray = [[NSMutableArray alloc] init];

    self.view.backgroundColor = RGB(237, 240, 246);
    self.title = @"手机开门";

    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(writeClick) andType:item_whrite];

    _mineTableview = [UITableView tableView];
    _mineTableview.frame = CGRectMake(54 / 3, 0, MainW - 108 / 3, MainH - 64);
    _mineTableview.sectionHeaderHeight = 40;
    _mineTableview.sectionFooterHeight = 20.0f;
    _mineTableview.delegate = self;
    _mineTableview.dataSource = self;
    //[_mineTableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    view.backgroundColor = RGB(237, 240, 246);
    _mineTableview.tableHeaderView = view;
    _mineTableview.backgroundColor = RGB(237, 240, 246);

    [self.view addSubview:self.mineTableview];
    [self setupTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_textField resignFirstResponder];
}
- (void)dealloc
{
    [_textField removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    _textField.lee_theme
        .LeeAddBackgroundColor(DAY, [UIColor whiteColor])
        .LeeAddBackgroundColor(NIGHT, [UIColor blackColor])
        .LeeAddTextColor(DAY, [UIColor blackColor])
        .LeeAddTextColor(NIGHT, [UIColor grayColor])
        .LeeAddCustomConfig(DAY, ^(UITextField *item) {
          item.keyboardAppearance = UIKeyboardAppearanceDefault;
          if ([item isFirstResponder])
          {
              [item resignFirstResponder];
              [item becomeFirstResponder];
          }
        })
        .LeeAddCustomConfig(NIGHT, ^(UITextField *item) {

          item.keyboardAppearance = UIKeyboardAppearanceDark;
          if ([item isFirstResponder])
          {
              [item resignFirstResponder];
              [item becomeFirstResponder];
          }
        });
    _textField.frame = CGRectMake(0, MainH + 64, self.view.py_width, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

- (void)xiugai:(NSInteger)index
{
    _textField.tag = index;

    [_textField becomeFirstResponder];
    //    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    _textField.placeholder = @"修改钥匙名";
    //[NSString stringWithFormat:@"修改小区名字",_curDModel.nickName];
    [self adjustTableViewToFitKeyboard];
}

- (void)adjustTableViewToFitKeyboard
{
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length)
    {
        [_textField resignFirstResponder];
        NSLog(@"输入的字符串是--%@", textField.text);
        NSInteger index = textField.tag;

        [self renameRequest:index:textField.text];

        _textField.text = @"";
        return YES;
    }
    return NO;
}

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height)
    {
        textFieldRect = rect;
    }
    [UIView animateWithDuration:0.25
                     animations:^{
                       _textField.frame = textFieldRect;

                     }];
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h)
    {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}

- (void)writeClick
{
    //
    FEAddKeyViewController *vc = [[FEAddKeyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)doRequest
{
    NSString *str = @"020appd/gate/info/show";
    [RYLoadingView showRequestLoadingView];

    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:nil
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@" 手机开门---dic-- %@", dic);

                                                     NSArray *array = [FEOpenDoorModel mj_objectArrayWithKeyValuesArray:dic[@"openDoorKeys"]];
                                                     self.dataArray = [NSMutableArray arrayWithArray:array];
                                                     if (array.count > 0)
                                                     {
                                                         [RYLoadingView hideNoResultView:self.view];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView showNoResultView:self.mineTableview];
                                                     }

                                                     UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MainW - 100, MainH - 150, 70, 60)];
                                                     [btn setImage:[UIImage imageNamed:@"timg.gif"] forState:0];
                                                     [btn addTarget:self action:@selector(gooffClick) forControlEvents:UIControlEventTouchUpInside];

                                                     [self.view addSubview:btn];
                                                     [self.view bringSubviewToFront:btn];

                                                     [self.mineTableview reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)gooffClick
{
    FEONOFFViewController *vc = [[FEONOFFViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
//扩展：让段头不停留（取消粘性效果）
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 20)];
    secView.backgroundColor = RGB(237, 240, 246);
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEOpenDoorCellID = @"FEOpenDoorCell";
    FEOpenDoorCell *cell = [tableView dequeueReusableCellWithIdentifier:FEOpenDoorCellID];
    if (cell == nil)
    {
        cell = [[FEOpenDoorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEOpenDoorCellID];
        cell.layer.cornerRadius = 6;
        cell.layer.masksToBounds = YES;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.section];
    //__weak typeof(self) weakSelf = self;
    WeakSelf;

    cell.doorblock = ^(FEOpenDoorCell *cell1) {

      NSIndexPath *indexPath = [weakSelf.mineTableview indexPathForCell:cell1];
      NSInteger index = indexPath.section;

      [weakSelf openDoor:index];

    };

    cell.shareblock = ^(FEOpenDoorCell *Cell0) {
      //分享

      NSIndexPath *indexPath = [weakSelf.mineTableview indexPathForCell:Cell0];
      NSInteger index = indexPath.section;

      [weakSelf shareClick:index];

    };

    cell.renameblock = ^(FEOpenDoorCell *cell2) {

      NSIndexPath *indexPath = [weakSelf.mineTableview indexPathForCell:cell2];
      NSInteger index = indexPath.section;
      //[weakSelf renameRequest:index];
      [weakSelf xiugai:index];

    };
    cell.deleteblock = ^(FEOpenDoorCell *cell3) {

      NSIndexPath *indexPath = [weakSelf.mineTableview indexPathForCell:cell3];
      NSInteger index = indexPath.section;
      [weakSelf delegetClick:index];

    };

    return cell;
}

//shanchu

- (void)delegetClick:(NSInteger)index
{
    [FENavTool showAlertRightAndCancelMsg:@"是否确认删除"
                                  andType:@"提示"
                            andRightClick:^{
                              [self deteleReqest:index];

                            }
                           andCancelClick:^{

                           }];
}

/// 开门
- (void)openDoor:(NSInteger)index
{
    FELoginInfo *info = [LoginUtil getInfoFromLocal];

    FEOpenDoorModel *model = self.dataArray[index];
    
    if ([model.validity isEqualToString:@"已过期"]) {
        //该钥匙已过期
        [FENavTool showAlertViewByAlertMsg:@"钥匙已过期" andType:@"提示"];
        return;
    }

    NSLog(@" index--%ld", index);
    NSString *keyName = model.doorName;                                //
    NSString *userId = [NSString stringWithFormat:@"%@", info.userId]; //info.userId;  //12312612
    NSString *community = model.communityMark;
    NSString *keyID = model.lockId;

    MDManager *manager = [MDManager sharedManager];

    [manager setSoundType:OpenSoundTypeCustom];
    //    [manager setOpenDoorSound:@"1.caf"];
    [manager setOpenDoorSuccessSound:@"custom1.caf"];

    [MBProgressHUD showMessage:@"正在开门中..."];
    [[MDManager sharedManager] openDoorWithUserId:userId
        UseKeyId:keyID
        KeyName:keyName
        Community:community
        Success:^{
          [MBProgressHUD hideHUD];
          [MDManager showSupriseInSuccessWithShowInfo:@{ @"key_name" : keyName }];

        }
        Failure:^(ErrorType errorCode) {
          [MBProgressHUD hideHUD];
          [MDManager showSupriseInFailureWithShowInfo:@{ @"key_name" : keyName }];
          switch (errorCode)
          {
              case ERR_KEY_STRING_PARSE_FAIL:
                  NSLog(@"ERR_KEY_STRING_PARSE_FAIL");

                  break;
              case ERR_DEVICE_SCAN_TIMEOUT:
                  NSLog(@"ERR_DEVICE_SCAN_TIMEOUT");
                  break;
          }
        }];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSUserDefaults *deflut = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [deflut objectForKey:YESNO];
    BOOL B = [num boolValue];
    NSLog(@"bbbb---- %@", num);

    if (!B)
    {
        return;
    }

    if (!(motion == UIEventSubtypeMotionShake))
        return;

    // FEOpenDoorModel *model=self.dataArray
    NSMutableArray *MkeyIdArray = [[NSMutableArray alloc] init];
    NSMutableArray *MkeyNameArray = [[NSMutableArray alloc] init];
    NSMutableArray *McommunityArray = [[NSMutableArray alloc] init];
    for (FEOpenDoorModel *model in self.dataArray)
    {
        NSString *keyID = model.lockId;
        NSString *keyName = model.doorName;
        NSString *community = model.communityMark;

        [MkeyIdArray addObject:keyID];
        [MkeyNameArray addObject:keyName];
        [McommunityArray addObject:community];
    }

    FELoginInfo *info = [LoginUtil getInfoFromLocal];
    NSString *userId = [NSString stringWithFormat:@"%@", info.userId];

    NSArray *keyIdArray = [MkeyIdArray copy];         //@[self.test1,self.test2];
    NSArray *keyNameArray = [MkeyNameArray copy];     // @[@"",@""];
    NSArray *communityArray = [McommunityArray copy]; //@[@"",@""];

    MDManager *manager = [MDManager sharedManager];
    /**
     *  设置音效策略
     */
    [manager setSoundType:OpenSoundTypeDefault2];

    [MBProgressHUD showMessage:@"正在开门中..."];
    [manager shakeOpenDoorWithUserId:userId
        UseKeyIdList:keyIdArray
        KeyNameList:keyNameArray
        CommunityList:communityArray
        isSupportShake:YES
        Success:^(NSDictionary *keyInfo) {
          [MBProgressHUD hideHUD];
          [MDManager showSupriseInSuccessWithShowInfo:keyInfo];
        }
        Failure:^(ErrorType errorCode) {
          [MBProgressHUD hideHUD];
          [MDManager showSupriseInFailureWithShowInfo:@{ @"key_name" : @"摇一摇" }];
          switch (errorCode)
          {
              default:
                  break;
          }
        }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

//rename
- (void)renameRequest:(NSInteger)index:(NSString *)txt
{
    FEOpenDoorModel *model = self.dataArray[index];
    NSString *str = @"020appd/gate/info/gengxindoor";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:txt forKey:@"alias"];
    [dic setObject:[NSNumber numberWithInt:[model.openId intValue]] forKey:@"openId"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"修改成功Dic--%@", dic);
                                                     [FENavTool showAlertViewByAlertMsg:@"修改成功" andType:@"提示"];
                                                     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
                                                     FEOpenDoorCell *cell = [_mineTableview cellForRowAtIndexPath:indexPath];
                                                     cell.doorNameLab.text = txt;

                                                     FEOpenDoorModel *model = _dataArray[indexPath.section];
                                                     //model.doorName=txt;
                                                     // [self.dataArray replaceObjectAtIndex:indexPath.section withObject:model];

                                                     //        [self.mineTableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

//delete
- (void)deteleReqest:(NSInteger)index
{
    FEOpenDoorModel *model = self.dataArray[index];

    NSString *str = @"020appd/gate/info/shanchu";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInt:[model.openId intValue]] forKey:@"openId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"删除成功Dic--%@", dic);
                                                     [FENavTool showAlertViewByAlertMsg:@"删除成功" andType:@"提示"];
                                                     [self.dataArray removeObjectAtIndex:index];
                                                     [self.mineTableview reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)shareClick:(NSInteger)index
{
    self.selectedIndexPath =index;
    
    
    JHPickView *picker = [[JHPickView alloc]initWithFrame:self.view.bounds];
    picker.delegate = self ;
    picker.selectLb.text = @"选择类型";//@"情感状态";
    picker.customArr = @[@"半小时",@"一小时",@"两小时"];
    // [NSArray arrayWithArray:_regionArray];//_regionArray;//@[@"已婚",@"未婚",@"保密"];
    
    [self.view addSubview:picker];
    
    
  }





-(void)PickerSelectorIndixString:(NSString *)str
{
    CGFloat bhour=0;
    
    if ([str isEqualToString:@"半小时"]) {
           bhour=0.5;
        
    }
    if ([str isEqualToString:@"一小时"]) {
        bhour=1.0;
        
    }
    if ([str isEqualToString:@"两小时"]) {
         bhour=2.0;
        
    }
    
    NSLog(@"选择的----str-- %@----小时%f" ,str,bhour);
    
    //[self share:self.selectedIndexPath andbhour:bhour];
    [self share:self.selectedIndexPath andbhour:bhour];

    }



-(void)share:(NSInteger)index andbhour:(CGFloat)hour
{
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@============年-月-日  时：分：秒=====================", DateTime);

    NSTimeInterval time = hour * 60 * 60;//小时的秒数
    //得到一年之前的当前时间（-：表示向前的时间间隔（即去年），如果没有，则表示向后的时间间隔（即明年））
    NSDate * lastYear = [date dateByAddingTimeInterval:+time];
    //转化为字符串
    NSString * startDate = [formatter stringFromDate:lastYear];
    
    
    NSLog(@"--++++时间%@",startDate);

    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    
    
    FEOpenDoorModel *model = self.dataArray[index];
    NSString *str=[NSString stringWithFormat:@"http://admin.feierlife.com/Home/UserKeys?doorId=%@&time=%@&phone=%@",model.doorId,startDate,info.mobile];
    
    
    
    NSMutableDictionary *shareParams = [[NSMutableDictionary alloc] init];
    NSArray *imageArray = @[ [[NSBundle mainBundle] pathForResource:@"feierlife" ofType:@"png"] ];
    //NSArray* imageArray=@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.thumb]]]];
    
    [shareParams SSDKSetupShareParamsByText:model.doorName
                                     images:imageArray
                                        url:[NSURL URLWithString:str]
    
                                      title:@"我的钥匙"
                                       type:SSDKContentTypeWebPage];
    
    //优先使用平台客户端分享
    [shareParams SSDKEnableUseClientShare];
    // 分享
    NSArray *items = @[
                       
                       @(SSDKPlatformTypeWechat),
                       
                       ];
    
    //[MOBShareSDKHelper shareInstance].platforems
    
    [ShareSDK showShareActionSheet:self.view
                             items:items
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state)
                   {
                       case SSDKResponseStateBegin:
                       {
                           //设置UI等操作
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Instagram、Line等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeInstagram)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           NSLog(@"%@", error);
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@", error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];

}

@end
