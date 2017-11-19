//
//  FETuiHuoViewController.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/3.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FETuiHuoViewController.h"
#import "FEBuyNowCell.h"
#import "YHJTextView.h"

@interface FETuiHuoViewController () < UITableViewDelegate, UITableViewDataSource, UITextViewDelegate >
{
    YHJTextView *_textView;
    UIButton *sureBtn;
    UITextField *dingDanTF;
}
@property (nonatomic, strong) UITableView *tuiHuoTab;

@end

@implementation FETuiHuoViewController

- (void)initView
{
    //退货
    self.title = @"退货";

    self.tuiHuoTab = [UITableView groupTableView];
    self.tuiHuoTab.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.tuiHuoTab.delegate = self;
    self.tuiHuoTab.dataSource = self;
    self.tuiHuoTab.sectionFooterHeight = 0.01;
    self.tuiHuoTab.sectionHeaderHeight = 0.01;
    //self.oderTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.tuiHuoTab.tableHeaderView = view;
    [self.view addSubview:self.tuiHuoTab];
}

- (void)doRequest
{
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    if (indexPath.section == 1)
    {
        return 40;
    }
    if (indexPath.section == 2)
    {
        return 120;
    }
    if (indexPath.section == 3)
    {
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 30;
    }
    else
    {
        return 20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 30)];
        view.backgroundColor = [UIColor clearColor];

        return view;
    }
    else
    {
        return nil;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 30)];
        view.backgroundColor = [UIColor clearColor];

        ///
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, MainW - 20, 30)];
        lab.backgroundColor = [UIColor whiteColor];

        lab.text = [NSString stringWithFormat:@"  订单号%@", self.curmodel.orderNum];
        [view addSubview:lab];
        lab.font = [UIFont systemFontOfSize:14];

        //
        CGFloat price = [self.curmodel.marketPrice integerValue] / 100.0;

        CGFloat total = [self.curmodel.goodNum integerValue] * price;

        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(MainW - 100, 0, 80, 30)];
        lab2.backgroundColor = [UIColor whiteColor];
        lab2.textAlignment = NSTextAlignmentRight;
        lab2.font = [UIFont systemFontOfSize:14];
        lab2.textColor = [UIColor redColor];
        lab2.text = [NSString stringWithFormat:@"¥%.2f元", total];
        [view addSubview:lab2];

        return view;
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 20)];
        view.backgroundColor = [UIColor clearColor];

        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *FEBuyNowCellID = @"FEBuyNowCell";
        FEBuyNowCell *cell = [tableView dequeueReusableCellWithIdentifier:FEBuyNowCellID];
        if (cell == nil)
        {
            cell = [[FEBuyNowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEBuyNowCellID];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.layer.cornerRadius = 5;
            cell.layer.masksToBounds = YES;
        }

        cell.model = self.curmodel;

        return cell;
    }
    else
    {
        static NSString *cellID2 = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];

            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            if (indexPath.section == 1)
            {
                //
                dingDanTF = [MYUI createTextFieldFrame:CGRectMake(10, 0, MainW - 20, 40) backgroundColor:[UIColor whiteColor] placeholder:@"请输入退货运单号" clearsOnBeginEditing:NO];

                //dingDanTF.keyboardType=UIKeyboardTypeNumberPad;
                [cell addSubview:dingDanTF];
            }
            if (indexPath.section == 2)
            {
                _textView = [[YHJTextView alloc] initWithFrame:CGRectMake(10, 0, MainW * 20, 120)];
                _textView.backgroundColor = [UIColor whiteColor];
                _textView.delegate = self;
                _textView.tag = 10087;

                _textView.myPlaceholder = @"填写您的退货理由";
                _textView.font = [UIFont systemFontOfSize:14];
                _textView.myPlaceholderColor = [UIColor lightGrayColor];
                _textView.returnKeyType = UIReturnKeyDone;
                _textView.keyboardType = UIKeyboardTypeDefault;
                [cell addSubview:_textView];
            }

            if (indexPath.section == 3)
            {
                sureBtn = [MYUI creatButtonFrame:CGRectMake(10, 25, MainW - 20, 40) backgroundColor:Green_Color setTitle:@"确认退货" setTitleColor:[UIColor whiteColor]];
                [sureBtn addTarget:self action:@selector(sureTuiHuo) forControlEvents:UIControlEventTouchUpInside];
                sureBtn.layer.masksToBounds = YES;
                sureBtn.layer.cornerRadius = 5;
                [cell addSubview:sureBtn];
            }
        }
        return cell;
    }
}

- (void)sureTuiHuo
{
    if (dingDanTF.text.length == 0)
    {
        return;
    }
    if (_textView.text.length == 0)
    {
        return;
    }

    NSString *str = @"020appd/shop/back";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.curmodel.storeId forKey:@"goodsId"];
    [dic setObject:_textView.text forKey:@"backReason"];
    [dic setObject:self.curmodel.orderNum forKey:@"orderSn"];
    [dic setObject:dingDanTF.text forKey:@"deliveryNum"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"退货的返回的Dic--%@", dic);
                                                     [FENavTool showAlertViewByAlertMsg:@"退货成功" andType:@"提示"];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];

        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

    return YES;
}

@end
