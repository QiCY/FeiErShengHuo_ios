//
//  FEInviteCodeViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/3.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEInviteCodeViewController.h"

@interface FEInviteCodeViewController ()

@end

@implementation FEInviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的邀请码";
    
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    // Do any additional setup after loading the view.
    UILabel *lab=[MYUI createLableFrame:CGRectMake(10, 40, MainW-20, 40) backgroundColor:[UIColor whiteColor] text:[NSString stringWithFormat:@"我的邀请码：%@",info.xCode] textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:20] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    lab.layer.cornerRadius=5;
    lab.layer.masksToBounds=YES;
    lab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lab];
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
