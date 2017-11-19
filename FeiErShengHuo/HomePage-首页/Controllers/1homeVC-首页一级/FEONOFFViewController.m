//
//  FEONOFFViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/17.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEONOFFViewController.h"

@interface FEONOFFViewController ()
{
    UISwitch *firstSwitch;
    BOOL B;
}

@end

@implementation FEONOFFViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)initView
{
    NSUserDefaults *deflut = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [deflut objectForKey:YESNO];
    B = [num boolValue];
    NSLog(@"bbbb---- %@", num);

    [FENavTool backOnNavigationItemWithNavItem:self.navigationItem target:self action:@selector(backClick)];

    self.title = @"摇一摇开关";
    self.view.backgroundColor = [UIColor whiteColor];

    firstSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(MainW - 100, 20, 0, 0)];
    firstSwitch.tintColor = [UIColor greenColor];
    firstSwitch.on = B;
    [firstSwitch addTarget:self action:@selector(swichClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstSwitch];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, MainW / 2, 40)];
    lab.text = @"摇一摇开关";
    [self.view addSubview:lab];

    lab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:lab];
}

- (void)swichClick:(UISwitch *)sender
{
    //sender.on=!sender.on;

    if (sender.on == YES)
    {
        NSUserDefaults *deflut = [NSUserDefaults standardUserDefaults];
        [deflut setObject:[NSNumber numberWithBool:YES] forKey:YESNO];
        [deflut synchronize];
    }
    else
    {
        NSUserDefaults *deflut = [NSUserDefaults standardUserDefaults];
        [deflut setObject:[NSNumber numberWithBool:NO] forKey:YESNO];
        [deflut synchronize];
    }
}

- (void)backClick
{
    NSLog(@"哈哈"); //[self popViewControllerAnimated:YES];
    if (firstSwitch.on == YES)
    {
        //self.view.backgroundColor=[UIColor redColor];

        NSUserDefaults *deflut = [NSUserDefaults standardUserDefaults];
        [deflut setObject:[NSNumber numberWithBool:YES] forKey:YESNO];
        [deflut synchronize];

        //
        //        if (self.block) {
        //            self.block(YES);
        //
        //        }
    }
    else
    {
        NSUserDefaults *deflut = [NSUserDefaults standardUserDefaults];
        [deflut setObject:[NSNumber numberWithBool:NO] forKey:YESNO];
        [deflut synchronize];

        //self.view.backgroundColor=[UIColor greenColor];
        //        if (self.block) {
        //            self.block(NO);
        //
        //        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
