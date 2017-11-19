//
//  FEIntertingDeitalWebViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntertingDeitalWebViewController.h"
#import "FECommentCell.h"

@interface FEIntertingDeitalWebViewController () < UIWebViewDelegate, UITextFieldDelegate >
{
    UILabel *bottomLab;
    NSInteger cout;

    CGFloat _totalKeybordHeight; //键盘高度
    UITextField *_textField;
    NSString *urlStr;
}
@property (nonatomic, strong) HPGrowingTextView *inputField;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *commetTabView;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *zanBtn;

@end

@implementation FEIntertingDeitalWebViewController
- (NSMutableArray *)dataArray
{
    _dataArray = [[NSMutableArray alloc] init];
    return _dataArray;
}

- (void)initView
{
    [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(shareClick) andType:item_share];

    //[self.view addSubview:webView];

    //[_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MainW, 10)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES; //自动对页面进行缩放以适应屏幕
    //[self doRequest];
    self.title = self.title;
    _commetTabView = [UITableView groupTableView];
    _commetTabView.frame = CGRectMake(0, 0, MainW, MainH - 64);

    _commetTabView.delegate = self;
    _commetTabView.dataSource = self;
    _commetTabView.sectionFooterHeight = 0.01;
    _commetTabView.sectionHeaderHeight = 0.01;
    _commetTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    _commetTabView.tableHeaderView = _webView;

    [self.view addSubview:_commetTabView];
    [self doRequest];

    [self setupTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self performSelector:@selector(changeWebViewHeight) withObject:nil afterDelay:0.5];
}

- (void)changeWebViewHeight
{
    //方法一
    CGSize fittSize = [_webView sizeThatFits:CGSizeZero];
    NSLog(@"webView__%@", NSStringFromCGSize(fittSize));
    _webView.frame = CGRectMake(0, 0, fittSize.width, fittSize.height);

    [_commetTabView beginUpdates];

    _commetTabView.tableHeaderView = _webView;

    [_commetTabView endUpdates];
}

- (void)shareClick
{
    NSMutableDictionary *shareParams = [[NSMutableDictionary alloc] init];
    NSArray *imageArray = @[ [[NSBundle mainBundle] pathForResource:@"feierlife" ofType:@"png"] ];
    //NSArray* imageArray=@[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.thumb]]]];

    [shareParams SSDKSetupShareParamsByText:self.title
                                     images:imageArray
                                        url:[NSURL URLWithString:urlStr]
                                      title:@"菲尔生活"
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

- (void)doRequest
{
    NSString *str = @"020appd/interest/fm/showFmComment";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:_TopicId forKey:@"topicId"];

    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"评论 ---dic-----%@", dic);
                                                     urlStr = dic[@"contentUrl"];

                                                     NSURL *url = [NSURL URLWithString:dic[@"contentUrl"]];     //创建URL
                                                     NSURLRequest *request = [NSURLRequest requestWithURL:url]; //创建NSURLRequest
                                                     [_webView loadRequest:request];                            //加载

                                                     NSArray *array = [FEcommentModel mj_objectArrayWithKeyValuesArray:dic[@"fmComments"]];

                                                     self.dataArray = [NSMutableArray arrayWithArray:array];

                                                     //cout=self.dataArray.count;

                                                     [_commetTabView reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 60;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 40)];
    view.backgroundColor = [UIColor whiteColor];

    //    bottomLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainW, 40)];
    //    bottomLab.backgroundColor=[UIColor redColor];
    //   // [_webView addSubview:bottomLab];

    self.commentBtn = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"icon_speak"] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commetClick:) forControlEvents:UIControlEventTouchUpInside];

    //[_commentBtn setTitle: [NSString stringWithFormat:@"%lu",self.dataArray.count]forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_commentBtn setTitleColor:GLOBAL_BIG_FONT_COLOR forState:UIControlStateNormal];
    //[_commentBtn addTarget:self action:@selector(doCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    _commentBtn.frame = CGRectMake(MainW - 70, 30 - 24, 50, 48);

    [view addSubview:self.commentBtn];

    //赞

    _zanBtn = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusNormal];
    //        if (_currentModel.laudationStatus == 0) {
    //            [_zanBtn setImage:[UIImage imageNamed:@"icon_zan"] forState:UIControlStateNormal];
    //        }else{
    //            [_zanBtn setImage:[UIImage imageNamed:@"icon_zan2"] forState:UIControlStateNormal];
    //        }
    [_zanBtn setImage:[UIImage imageNamed:@"icon_heart_normal"] forState:UIControlStateNormal];

    //    NSString *zannumStr=[NSString stringWithFormat:@"%@",self.curDModel.good];
    //    [zanBtn setTitle:zannumStr forState:UIControlStateNormal];
    _zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_zanBtn setTitleColor:GLOBAL_BIG_FONT_COLOR forState:UIControlStateNormal];
    [_zanBtn addTarget:self action:@selector(doZanAction:) forControlEvents:UIControlEventTouchUpInside];
    _zanBtn.frame = CGRectMake(MainW - 150, 30 - 24, 50, 48);

    [view addSubview:_zanBtn];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetify = @"FECommentCell";
    FECommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetify];
    if (cell == nil)
    {
        cell = [[FECommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    FEcommentModel *model = _dataArray[indexPath.row];

    [cell setupInerttingCellWithModel:model];

    return cell;
}
#pragma-- ----评论-- ----
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

- (void)commetClick:(UIButton *)btn
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

    [_textField becomeFirstResponder];
    //    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    _textField.placeholder = @"回复";

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
        [self doCommentRequest:_textField.text];
        //评论请求  请求完了清空一下
        //_textField.text = @"";
        return YES;
    }
    return NO;
}

- (void)doCommentRequest:(NSString *)commetStr
{
    NSString *str = @"020appd/interest/fm/publishFmComment";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:commetStr forKey:@"fmComment"];
    [dic setObject:self.cuModel.topicId forKey:@"topicId"];
    [dic setObject:self.cuModel.themeId forKey:@"themeId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"回复的dic--%@", dic);
                                                     [FENavTool showAlertViewByAlertMsg:@"回复成功" andType:@"提示"];
                                                     [self doRequest];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
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

#pragma-- ----点赞-- ----
- (void)doZanAction:(UIButton *)btn
{
    NSString *str = @"020appd/interest/fm/like";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.cuModel.topicId forKey:@"topicId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"点赞Dic--%@", dic);
                                                     [FENavTool showAlertViewByAlertMsg:@"点赞成功" andType:@"提示"];
                                                     [_zanBtn setImage:Image(@"[Details]-Already_collection") forState:UIControlStateNormal];

                                                   }
                                                    withfialedBlock:^(NSString *msg){

                                                    }];
}

@end
