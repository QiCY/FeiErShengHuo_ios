
//
//  FEMineViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEMineViewController.h"
#import "FEIntergralViewController.h"
#import "FEInviteCodeViewController.h"
#import "FEMyGorpedListViewController.h"
#import "FEMyStarViewController.h"
#import "FEShowOderViewController.h"

@interface FEMineViewController () < UITableViewDelegate, UITableViewDataSource, refreshDelegete, removedeleegeet, headClickdelegete >
@end
@implementation FEMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //赋值
    FELoginInfo *curInfo = [LoginUtil getInfoFromLocal];

    if ([curInfo.isLogin isEqualToString:@"1"])
    {
        personView.nameLab.text = curInfo.nickName;
        //如果URL 为空 就搞默认
        if ([curInfo.avatar isEqual:[NSNull null]] || [curInfo.avatar isKindOfClass:[NSNull class]] || curInfo.avatar.length == 0 || [curInfo.avatar isEqualToString:@""])
        {
            [personView.personHeadView setImage:[UIImage imageNamed:@"pic"]];
        }
        else
        {
            [personView.personHeadView sd_setImageWithURL:[NSURL URLWithString:curInfo.avatar]];
        }

        personView.phoneLab.text = [NSString stringWithFormat:@"手机:%@", curInfo.mobile];
        personView.areaLab.text = [NSString stringWithFormat:@"小区:%@", curInfo.regionTitle];

        //余额
        CGFloat fbalance = [curInfo.balance integerValue] / 100.0;
        NSString *fbalanceStr = [NSString stringWithFormat:@"%.2f", fbalance];
        NSString *tol = [NSString stringWithFormat:@"余额:¥%@", fbalanceStr];
        balanceLab.text = tol;
        //积分
        integralLab.text = [NSString stringWithFormat:@"积分:%@", curInfo.integral];
        if ([curInfo.nickName isEqualToString:@""] || curInfo.nickName.length == 0)
        {
            personView.nameLab.text = curInfo.mobile;
        }
        else
        {
            personView.nameLab.text = curInfo.nickName;
        }
    }
    else
    {
        personView.nameLab.text = @"未登录";
        [personView.personHeadView setImage:[UIImage imageNamed:@"userpic_default"]];
        personView.phoneLab.text = @"手机：";
        personView.areaLab.text = @"小区:";

        balanceLab.text = @"余额:0";
        integralLab.text = @"积分:0";
    }

    //根据isgin 判断签到。

    if ([curInfo.isSignIn isEqualToString:@"1"])
    {
        [signBtn setTitle:@"已签到" forState:0];
        [signBtn setImage:Image(@"icon_signed_today") forState:0];
    }
    else
    {
        [signBtn setTitle:@"签到有礼" forState:0];
        [signBtn setImage:Image(@"icon_sign_polite") forState:0];
    }
}

- (void)initView
{
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RefreshMoney:) name:NOTI_REFRESH_MONEY object:nil];
    [self creatTableView];
}

- (void)headClick:(UITapGestureRecognizer *)tap
{
    //首先判断是否登录
    FELoginInfo *info = [LoginUtil getInfoFromLocal];

    NSLog(@"是否 登录 ---info--%@", info.isLogin);
    if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
    {
        FELoginViewController *vc = [[FELoginViewController alloc] init];
        vc.delegete = self;
        FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

        [self presentViewController:logNav animated:YES completion:nil];
        return;
    }
    FEPersonalViewController *personnalCtrl = [[FEPersonalViewController alloc] init];
    personnalCtrl.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:personnalCtrl animated:YES];
}
- (void)creatTableView
{
    mytabView = [[FEHeadTableView alloc] initWithFrame:CGRectMake(0, 0, MainW, MainH - 64) style:UITableViewStylePlain andImageName:@"bg_head" andHeight:180];
    mytabView.delegate = self;
    mytabView.dataSource = self;
    mytabView.separatorStyle = UITableViewCellSeparatorStyleNone;
//如果头部视图还有其他视图的话，比如设置按钮之类的还可以用下面的方法添加
#if 1
    // 头像部分
    personView = [[MineHeaderView alloc] init];
    personView.delegete = self;
    personView.backgroundColor = [UIColor clearColor];
    [mytabView addSubview:personView];

    //签到部分

    signBtn = [[FL_Button fl_shareButton] initWithAlignmentStatus:FLAlignmentStatusCenterImageLeft];

    signBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [signBtn setBackgroundColor:RGBA(46, 56, 59, 0.5)];
    signBtn.layer.cornerRadius = 25 / 2;
    signBtn.layer.masksToBounds = YES;
    [signBtn addTarget:self action:@selector(signClick) forControlEvents:UIControlEventTouchUpInside];

    [mytabView addSubview:signBtn];
    //信封部分
    emailBtn = [[UIButton alloc] init];
    [emailBtn setBackgroundImage:Image(@"icon_mailbox") forState:0];
    emailBtn.hidden=YES;
    
    [mytabView addSubview:emailBtn];

    //积分部分
    integralLab = [[UILabel alloc] init];
    integralLab.font = [UIFont systemFontOfSize:15];
    integralLab.textColor = [UIColor whiteColor];

    [mytabView addSubview:integralLab];
    //余额部分

    balanceLab = [[UILabel alloc] init];
    balanceLab.font = [UIFont systemFontOfSize:15];
    balanceLab.textColor = [UIColor whiteColor];
    [mytabView addSubview:balanceLab];
#endif
    [self.view addSubview:mytabView];
    //具体其它渲染cell的代码没有影响，就不写了

    [self tabViewHeaderSubView];
}

#pragma mark - ScrollView delegate
- (void)tabViewHeaderSubView
{
    // 布局
    personView.frame = CGRectMake(0, 10, MainW / 2, 295 / 2);

    [integralLab makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(personView.bottom);

      make.left.equalTo(personView.right);
      make.height.equalTo(20);
      make.width.equalTo(MainW / 4);
    }];
    [balanceLab makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(integralLab.centerY);
      make.left.equalTo(integralLab.right);

      make.height.equalTo(20);
      make.width.equalTo(MainW / 4);
    }];

    signBtn.frame = CGRectMake(MainW - 10 - 80, 10, 80, 25);

    [emailBtn makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(signBtn.centerX);
      make.top.equalTo(signBtn.bottom).offset(10);
      make.height.equalTo(20);
      make.width.equalTo(30);
    }];
}
//签到
- (void)signClick
{
    FELoginInfo *info = [LoginUtil getInfoFromLocal];
    WeakSelf;

    [FELoginHelper loginMoel:info
                       andVC:self
             andLoginedBlock:^{
               [weakSelf sign];

             }];
}

- (void)sign
{
    NSString *str = @"020appd/integral/checked";
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
        withPath:str
        withDictionary:nil
        withSuccessBlock:^(NSDictionary *dic) {

          [FENavTool showAlertViewByAlertMsg:@"签到成功" andType:@"提示"];
          //更按钮图标
          [signBtn setImage:Image(@"icon_signed_today") forState:0];
          [signBtn setTitle:@"已签到" forState:0];
          signBtn.titleLabel.font = [UIFont systemFontOfSize:12];

          FELoginInfo *info = [FELoginInfo mj_objectWithKeyValues:dic[@"user1"]];

          //记录签到

          FELoginInfo *info2 = [LoginUtil getInfoFromLocal];
          info2.integral = info.integral;

          info2.isSignIn = @"1";
          [LoginUtil saveing:info2];

          //积分
          integralLab.text = [NSString stringWithFormat:@"积分:%@", info.integral];

          NSLog(@"dic-签到---%@", dic);

        }
        withfialedBlock:^(NSString *msg) {

          //走明天再来吧
          [signBtn setImage:Image(@"icon_signed_today") forState:0];
          [signBtn setTitle:@"已签到" forState:0];

        }];
}

//*实现视图拖动时候的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    contentOffSet = scrollView.contentOffset.y;
    CGRect oldFream = mytabView.imgView.frame;
    if (contentOffSet <= mytabView.height)
    {
        oldFream.size.height = mytabView.height - contentOffSet;
        mytabView.imgView.frame = oldFream;
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 6;
    }
    else
    {
        return 4;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 9)];
    secView.backgroundColor = RGB(219, 219, 219);
    return secView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    FEDynamicModel *curModel = _dataArray[indexPath.section];
    //    CGFloat hgnum = [FEDynamicStateCell countCellHeightByModel:curModel isContainComment:YES];
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mineCellIndetify = @"mineCell";
    mineTableViewCell *cell = (mineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:mineCellIndetify];
    if (cell == nil)
    {
        cell = [[mineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *imagedataArray = @[ @[ @"icon_barecharge", @"icon_invite_code", @"icon_quarters", @"icon_My_complaint", @"icon_My_repair", @"icon_My_idle" ], @[ @"icon_My_order", @"icon_Group_buy", @"icon_My_collection", @"icon_my_integral" ] ];
    NSArray *mineLabArray = @[ @[ @"余额充值", @"我的邀请码", @"小区公告", @"我的投诉", @"我的报修", @"我的闲置" ], @[ @"我的订单", @"我的团购", @"我的收藏", @"积分商城" ] ];

    cell.imageView.image = [UIImage imageNamed:imagedataArray[indexPath.section][indexPath.row]];
    cell.mineLab.text = mineLabArray[indexPath.section][indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        FELoginInfo *info = [LoginUtil getInfoFromLocal];
        if (indexPath.row == 0)
        {
            FELoginInfo *info = [LoginUtil getInfoFromLocal];

            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }
            //余额充值
            FEBalanceRechargeViewController *vc = [[FEBalanceRechargeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1)
        {
            FELoginInfo *info = [LoginUtil getInfoFromLocal];

            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }

            FEInviteCodeViewController *vc = [[FEInviteCodeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 2)
        {
            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }
            //判断小区
            if ([info.villageId intValue] <= 0)
            {
                //跳转健全信息页面
                // 没有的情况  去健全小区和上传信息
                FEAddinfoViewController *addinfoVC = [[FEAddinfoViewController alloc] init];
                FEBaseNavControllerViewController *addNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:addinfoVC];

                [self presentViewController:addNav animated:YES completion:nil];

                return;
            }

            if ([info.isValidate intValue] == 0)
            {
                [FENavTool showAlertViewByAlertMsg:@"当前的小区未认证" andType:@"提示"];
                return;
            }
            //小区公告
            FENoticeViewController *noticeVC = [[FENoticeViewController alloc] init];
            [self.navigationController pushViewController:noticeVC animated:YES];
        }
        if (indexPath.row == 3)
        {
            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }
            //判断小区
            if ([info.villageId intValue] <= 0)
            {
                //跳转健全信息页面
                // 没有的情况  去健全小区和上传信息
                FEAddinfoViewController *addinfoVC = [[FEAddinfoViewController alloc] init];
                FEBaseNavControllerViewController *addNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:addinfoVC];

                [self presentViewController:addNav animated:YES completion:nil];

                return;
            }

            if ([info.isValidate intValue] == 0)
            {
                [FENavTool showAlertViewByAlertMsg:@"当前的小区未认证" andType:@"提示"];
                return;
            }
            //投诉
            FEComplainViewController *complainVC = [[FEComplainViewController alloc] init];
            [self.navigationController pushViewController:complainVC animated:YES];
        }
        if (indexPath.row == 4)
        {
            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }
            //判断小区
            if ([info.villageId intValue] <= 0)
            {
                //跳转健全信息页面
                // 没有的情况  去健全小区和上传信息
                FEAddinfoViewController *addinfoVC = [[FEAddinfoViewController alloc] init];
                FEBaseNavControllerViewController *addNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:addinfoVC];

                [self presentViewController:addNav animated:YES completion:nil];

                return;
            }

            if ([info.isValidate intValue] == 0)
            {
                [FENavTool showAlertViewByAlertMsg:@"当前的小区未认证" andType:@"提示"];
                return;
            }

            FERepairViewController *repairVC = [[FERepairViewController alloc] init];
            [self.navigationController pushViewController:repairVC animated:YES];
        }
        if (indexPath.row == 5)
        {
            FELoginInfo *info = [LoginUtil getInfoFromLocal];

            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }

            FESecondHandViewController *VC = [[FESecondHandViewController alloc] init];
            VC.personalFlag = [NSNumber numberWithInt:1];
            VC.shaChu = [NSNumber numberWithInt:1];

            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            FELoginInfo *info = [LoginUtil getInfoFromLocal];

            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }

            //去我的订单
            FEShowOderViewController *VC = [[FEShowOderViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }

        if (indexPath.row == 1)
        {
            FELoginInfo *info = [LoginUtil getInfoFromLocal];

            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }

            FEMyGorpedListViewController *VC = [[FEMyGorpedListViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }

        if (indexPath.row == 2)
        {
            FELoginInfo *info = [LoginUtil getInfoFromLocal];

            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }

            //去我的收藏
            FEMyStarViewController *VC = [[FEMyStarViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }

        if (indexPath.row == 3)
        {
            FELoginInfo *info = [LoginUtil getInfoFromLocal];

            NSLog(@"是否 登录 ---info--%@", info.isLogin);
            if ([info.isLogin isEqualToString:@"0"] || [info.isLogin isEqual:nil] || [info.isLogin isKindOfClass:[NSNull class]] || [info.isLogin isEqual:[NSNull null]] || info.isLogin.length == 0)
            {
                FELoginViewController *vc = [[FELoginViewController alloc] init];
                //vc.delegete=self;
                FEBaseNavControllerViewController *logNav = [[FEBaseNavControllerViewController alloc] initWithRootViewController:vc];

                [self presentViewController:logNav animated:YES completion:nil];
                return;
            }

            //积分
            FEIntergralViewController *VC = [[FEIntergralViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

@end
