//
//  FEShowOderViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/28.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEShowOderViewController.h"
#import "FEBuyNowCell.h"
#import "FEOderModel.h"
#import "QZTopTextView.h"

#define DAY @"day"
#define NIGHT @"night"

@interface FEShowOderViewController () < UITableViewDataSource, UITableViewDelegate, QZTopTextViewDelegate, ASMessageViewDelegate, UITextFieldDelegate >
{
    UIButton *_tuiHuoBtn;
    UIButton *_commentBtn;
    //QZTopTextView * _textView2;
    UITextField *_textField;
    CGFloat _totalKeybordHeight; //键盘高度
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) ASMessageView *messageView;

@property (nonatomic, strong) UITableView *oderTabView;

@end

@implementation FEShowOderViewController

- (void)initView
{
    _dataArray = [[NSMutableArray alloc] init];

    self.title = @"我的订单";
    self.oderTabView = [UITableView groupTableView];
    self.oderTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.oderTabView.delegate = self;
    self.oderTabView.dataSource = self;
    self.oderTabView.sectionFooterHeight = 0.01;
    self.oderTabView.sectionHeaderHeight = 0.01;
    //self.oderTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, MainW, 0.1);
    self.oderTabView.tableHeaderView = view;
    [self.view addSubview:self.oderTabView];

    [self setupTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];

    //    //评论框
    //
    //    _textView2 =[QZTopTextView topTextView];
    //    _textView2.delegate = self;
    //    [self.view addSubview:_textView2];
}

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:YES];
    [self doRequest];
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
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.py_width, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

- (void)dobeginCommentAction:(UIButton *)btn
{
    NSInteger index = btn.tag - 10000;
    NSLog(@"点击了--评价---第%ld个区", index);

    _textField.tag = btn.tag;
    [_textField becomeFirstResponder];
    //    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    _textField.placeholder = @"评论";

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
        [self doCommentRequest:textField.text];
        //评论请求  请求完了清空一下
        //_textField.text = @"";
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

- (void)doCommentRequest:(NSString *)commetStr
{
    NSLog(@"评价的内容%@", commetStr);
    NSLog(@"tag --- %ld", _textField.tag);
    NSInteger index = _textField.tag - 10000;
    FEOderModel *model = _dataArray[index];

    NSString *str = @"020appd/mall/publish";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:model.storeId forKey:@"goodsId"];
    [dic setObject:commetStr forKey:@"content"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"评价的Dic--%@", dic);
                                                     [FENavTool showAlertViewByAlertMsg:@"评价成功" andType:@"提示"];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

- (void)doRequest
{
    NSString *str = @"020appd/shop/showOrder";
    NSMutableDictionary *dic =@{}.mutableCopy;

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:GET
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"展示个人消费记录--%@", dic);
                                                     NSArray *array = [FEOderModel mj_objectArrayWithKeyValuesArray:dic[@"userOrders"]];

                                                     _dataArray = [NSMutableArray arrayWithArray:array];

                                                     if (array.count > 0)
                                                     {
                                                         [RYLoadingView hideNoResultView:self.oderTabView];
                                                     }
                                                     else
                                                     {
                                                         [RYLoadingView showNoResultView:self.oderTabView];
                                                     }

                                                     [_oderTabView reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FEOderModel *model = _dataArray[section];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 40)];
    view.backgroundColor = [UIColor clearColor];

    UILabel *_odercodeLab = [MYUI createLableFrame:CGRectMake(10, 0, MainW - 20, 40) backgroundColor:[UIColor whiteColor] text:[NSString stringWithFormat:@"  订单编号：%@", model.orderNum] textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _odercodeLab.textAlignment =NSTextAlignmentLeft;
    [view addSubview:_odercodeLab];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 80)];
    view.backgroundColor = [UIColor clearColor];

    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 0, MainW - 20, 70)];
    view2.backgroundColor = [UIColor whiteColor];
    [view addSubview:view2];
    

    // 快递  单号
    
 FEOderModel *model = _dataArray[section];
    
    UILabel *kuidiiLab=[MYUI createLableFrame:CGRectMake(20, 10, MainW/2-10,20) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [view addSubview:kuidiiLab];
    kuidiiLab.text=[NSString stringWithFormat:@"快递:%@",model.delivery];
    

    
    
      UILabel *yundanLab=[MYUI createLableFrame:CGRectMake(MainW/2-10, 10, MainW/2-20,20) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    yundanLab.textAlignment=NSTextAlignmentRight;
    
    yundanLab.text=[NSString stringWithFormat:@"运单号:%@",model.deliveryNum];
    
    [view addSubview:yundanLab];
    
    
    //手机
    _tuiHuoBtn = [MYUI creatButtonFrame:CGRectZero backgroundColor:[UIColor redColor] setTitle:@"退货" setTitleColor:[UIColor whiteColor]];
    [_tuiHuoBtn addTarget:self action:@selector(tuihuoClick:) forControlEvents:UIControlEventTouchUpInside];
    _tuiHuoBtn.tag = section + 1000;

    _tuiHuoBtn.layer.cornerRadius = 5;
    _tuiHuoBtn.layer.masksToBounds = YES;
    _tuiHuoBtn.frame = CGRectMake(MainW - 110, 40, 40, 25);
    [view addSubview:_tuiHuoBtn];

    //
    _commentBtn = [MYUI creatButtonFrame:CGRectZero backgroundColor:Green_Color setTitle:@"评价" setTitleColor:[UIColor whiteColor]];
    _commentBtn.tag = section + 10000;

    [_commentBtn addTarget:self action:@selector(dobeginCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    _commentBtn.layer.cornerRadius = 5;
    _commentBtn.layer.masksToBounds = YES;
    _commentBtn.frame = CGRectMake(CGRectGetMaxX(_tuiHuoBtn.frame) + 10, 40, 40, 25);
    [view addSubview:_commentBtn];
    return view;
}

- (void)tuihuoClick:(UIButton *)btn1
{
    NSInteger index = btn1.tag - 1000;
    NSLog(@"点击了--退货--index-%ld区", index);

    FEOderModel *model = _dataArray[index];
    FETuiHuoViewController *vc = [[FETuiHuoViewController alloc] init];
    vc.curmodel = model;

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pingjiaClick:(UIButton *)btn2
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FEBuyNowCellID = @"FEBuyNowCell";
    FEBuyNowCell *cell = [tableView dequeueReusableCellWithIdentifier:FEBuyNowCellID];
    if (cell == nil)
    {
        cell = [[FEBuyNowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FEBuyNowCellID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    FEOderModel *model=_dataArray[indexPath.row];
    //    [cell setupOderCellWithModel:model];
    cell.model = _dataArray[indexPath.section];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FEOderModel *model = _dataArray[indexPath.section];

    StoreDetialViewController *detailVC = [[StoreDetialViewController alloc] init];

    detailVC.goodsId = model.storeId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
