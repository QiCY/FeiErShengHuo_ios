//
//  FENeighberDetailController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/21.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FENeighberDetailController.h"
#import "ASMessageView.h"
#import "FECommentCell.h"
#import "FEDynamicStateCell.h"
#import "FEDynamicStateCell.h"
#import "FENeighberCommentModel.h"
#import "FEPictureModel.h"
#import "FEphotoCell.h"
#import "FL_Button.h"
#import "headView.h"

#define DAY @"day"
#define NIGHT @"night"
static CGFloat textFieldH = 40;

@interface FENeighberDetailController () < UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ASMessageViewDelegate, UITextFieldDelegate >
{
    CGFloat _totalKeybordHeight; //键盘高度
    UITextField *_textField;
    CGFloat contheight;
    BOOL isZan;
    
    
}

@property (strong, nonatomic) ASMessageView *messageView;

@property (nonatomic, strong) UILabel *timeLbl;

@property (nonatomic, strong) UITableView *FEghouberTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *bottomCommentView;
@property (nonatomic, strong) HPGrowingTextView *inputField;
@property (nonatomic, strong) UIButton *emojiBtn;
@property (nonatomic, strong) UIButton *comBtn;

@end

@implementation FENeighberDetailController

- (void)initView
{
    
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    
    if (info.userId ==_curDModel.userId) {
         [FENavTool rightItemOnNavigationItem:self.navigationItem target:self action:@selector(rightClick) andType:item_shanchu];
    }
    
    isZan=NO;
    
    self.dataArray = [NSMutableArray arrayWithCapacity:1];

    [self doRequesthhhh];
    self.title = @"动态详情";
    self.FEghouberTableView = [UITableView groupTableView];
    self.FEghouberTableView.frame = CGRectMake(0, 0, MainW, MainH - 64);
    self.FEghouberTableView.delegate = self;
    self.FEghouberTableView.dataSource = self;
    self.FEghouberTableView.sectionHeaderHeight = 0.1;
    self.FEghouberTableView.sectionFooterHeight = 1;
    //self.FEghouberTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [[UIView alloc] init];
    
    
    contheight=[self.curDModel.content heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:MainW-92-10];
    view.frame = CGRectMake(0, 0, MainW, self.height-20+contheight);

    // //头像
    UIImage *imgPlaceholder = [UIImage imageNamed:@"Shopping_picture2"];
    self.headImageView = [[UIImageView alloc] init];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.image = imgPlaceholder;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 30;
    [_headImageView setFrame:CGRectMake(9, 19, 60, 60)];
    [view addSubview:_headImageView];
    //名字
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(92, 15, 150, 20)];
    _nameLab.font = [UIFont boldSystemFontOfSize:16];
    _nameLab.textColor = [UIColor colorWithHexString:@"#117c1b"];

    [view addSubview:_nameLab];

    //发布内容
    _FENeighberContantLab = [MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:self.curDModel.content textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [view addSubview:self.FENeighberContantLab];
    //赞
    self.zanBtn = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusNormal];
    [_zanBtn setImage:[UIImage imageNamed:@"icon_heart_normal"] forState:UIControlStateNormal];

    NSString *zannumStr = [NSString stringWithFormat:@"%@", self.curDModel.good];
    [_zanBtn setTitle:zannumStr forState:UIControlStateNormal];
    _zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_zanBtn setTitleColor:GLOBAL_BIG_FONT_COLOR forState:UIControlStateNormal];
    [_zanBtn addTarget:self action:@selector(doZanAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_zanBtn];

    //评论
    self.commentBtn = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"icon_speak"] forState:UIControlStateNormal];

    [_commentBtn setTitle:[NSString stringWithFormat:@"%@", self.curDModel.commentCount] forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_commentBtn setTitleColor:GLOBAL_BIG_FONT_COLOR forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(dobeginCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_commentBtn];

    //时间细节
    _timeDetailLab = [MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:self.curDModel.createTimeStr textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:10] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _timeDetailLab.textAlignment = NSTextAlignmentRight;
    [view addSubview:self.timeDetailLab];

    //地点图标
    _AddressImageView = [MYUI creatImageViewFrame:CGRectZero imageName:@"icon_house"];
    [view addSubview:self.AddressImageView];

    _addressLab = [MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:self.curDModel.title textColor:[UIColor colorWithHexString:@"#8c8c8c"] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [view addSubview:self.addressLab];

    //

    //设置头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.curDModel.headImgUrl]];

    //设置
    self.nameLab.text = self.curDModel.nickName;
    self.FENeighberContantLab.text = self.curDModel.content;
    //self.titleLab.text = self.curDModel.title;
    self.timeDetailLab.text = self.curDModel.createTimeStr;

    self.titleLab.text = self.curDModel.title;
    self.timeDetailLab.text = self.curDModel.createTimeStr;

    NSMutableArray *imageArray = self.curDModel.pictureMap;

    CGFloat offY = PERSONAL_INFO_ITEM_HEIGHT;
    //图片 9宫格布局 图片尺寸固定的哦
    if (imageArray.count > 0)
    {
        //图片 滚动视图的位置 大小事固定的
        NSInteger beiNum = (MainW - 32 - 76 - 16) / (DYNAMIC_PICTURE_WIDTH + 8);
        NSInteger imgHangNum = imageArray.count / beiNum;
        if (imageArray.count % beiNum != 0)
        {
            imgHangNum = imageArray.count / beiNum + 1;
        }
        self.nineImageView = [[UIView alloc] initWithFrame:CGRectMake(16 + 76, CGRectGetMaxY(_headImageView.frame) + 5, MainW - 48 - 76 - 16, (DYNAMIC_PICTURE_HEIGHT + 8) * imgHangNum - 8)];

        for (int i = 0; i < imageArray.count; ++i)
        {
            UIImageView *curImg = [[UIImageView alloc] init];
            NSInteger curHang = i / beiNum;
            NSInteger curLie = i % beiNum;
            curImg.userInteractionEnabled = YES;
            curImg.clipsToBounds = YES;
            curImg.contentMode = UIViewContentModeScaleAspectFill;
            curImg.tag = 200 + i;
            UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doOpenImange:)];
            [curImg addGestureRecognizer:imgTap];

            curImg.frame = CGRectMake(curLie * (DYNAMIC_PICTURE_WIDTH + 8), (DYNAMIC_PICTURE_HEIGHT + 8) * curHang, DYNAMIC_PICTURE_WIDTH, DYNAMIC_PICTURE_HEIGHT);
            FEPictureModel *curImgModel = imageArray[i];
            if (curImgModel.url.length)
            {
                [curImg sd_setImageWithURL:[NSURL URLWithString:curImgModel.url]];
            }
            [_nineImageView addSubview:curImg];
        }
        [view addSubview:_nineImageView];
        offY = offY + _nineImageView.frame.size.height + 16;
    }

    _FENeighberContantLab.frame=CGRectMake(92, CGRectGetMaxY(_nameLab.frame)+5, MainW-92-10,contheight);
    
    
    
    [_timeDetailLab makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.right).offset(-10);
        make.top.equalTo(self.nameLab);
        make.width.equalTo(MainW/2);
        make.height.equalTo(10);
    }];

    //_timeDetailLab.frame = CGRectMake(MainW/2, CGRectGetMinY(_nameLab.frame), MainW / 2 - 50, 10);

    if (imageArray.count == 0)
    {
        _AddressImageView.frame = CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_FENeighberContantLab.frame) + 5, 15, 15);
        _addressLab.frame = CGRectMake(CGRectGetMaxX(_AddressImageView.frame) + 5, CGRectGetMaxY(_FENeighberContantLab.frame) + 5, MainW - 200, 15);
        _zanBtn.frame = CGRectMake(MainW - 100, CGRectGetMaxY(_FENeighberContantLab.frame) + 5, 50, 20);

        _commentBtn.frame = CGRectMake(MainW - 60, CGRectGetMaxY(_FENeighberContantLab.frame) + 5, 50, 20);
    }
    else
    {
        _AddressImageView.frame = CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_nineImageView.frame) + 5, 15, 15);
        _addressLab.frame = CGRectMake(CGRectGetMaxX(_AddressImageView.frame) + 5, CGRectGetMaxY(_nineImageView.frame) + 5, MainW - 200, 15);

        _zanBtn.frame = CGRectMake(MainW - 100, CGRectGetMaxY(_nineImageView.frame) + 5, 50, 20);

        _commentBtn.frame = CGRectMake(MainW - 60, CGRectGetMaxY(_nineImageView.frame) + 5, 50, 20);
    }
    self.FEghouberTableView.tableHeaderView = view;
    [self.view addSubview:self.FEghouberTableView];
    [self setupTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)doOpenImange:(UITapGestureRecognizer *)tap
{
    NSMutableArray *imgArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (UIView *tgImgView in _nineImageView.subviews)
    {
        if ([tgImgView isKindOfClass:[UIImageView class]])
        {
            UIImageView *curImgView = (UIImageView *)tgImgView;
            UIImage *tgimg = curImgView.image;
            if (tgimg)
            {
                [imgArr addObject:tgimg];
            }
        }
    }
    UIImageView *tgImgView = (UIImageView *)tap.view;
    NSInteger index = tgImgView.tag - 200;
    //    if (_delegate && [_delegate respondsToSelector:@selector(doShowImgAction:andIndex:)]) {
    //        [_delegate doShowImgAction:imgArr andIndex:index];
    //    }

    RYImagePreViewController *previewController = [[RYImagePreViewController alloc] initWithImg:imgArr andIsPush:NO andIndex:index];
    FEBaseNavControllerViewController *navCtl = [[FEBaseNavControllerViewController alloc] initWithRootViewController:previewController];
    [self presentViewController:navCtl animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_textField resignFirstResponder];
    if (_delegete && [_delegete respondsToSelector:@selector(refreshCommentCount:AndIndex:)])
    {
        NSNumber *count = [NSNumber numberWithInteger:_dataArray.count];
        [_delegete refreshCommentCount:count AndIndex:self.indexpath];
    }
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
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height + 80, self.view.py_width, textFieldH);

    [self.view addSubview:_textField];

    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

- (void)dobeginCommentAction:(UIButton *)btn
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
    _textField.placeholder = [NSString stringWithFormat:@"回复:%@", _curDModel.nickName];
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
   
    FELoginInfo *info = [LoginUtil getInfoFromLocal];
    NSString *str = @"020appd/community/publishComments";
    NSMutableDictionary *dic =@{}.mutableCopy;
    //其他人的参数
    [dic setObject:_curDModel.userId forKey:@"userId"];
    [dic setObject:_curDModel.snsId forKey:@"snsId"];
    [dic setObject:commetStr forKey:@"content"];
    [dic setObject:_curDModel.regionid forKey:@"regionid"];
    [dic setObject:_curDModel.mobile forKey:@"mobile"];
    //用户的
    [dic setObject:info.userId forKey:@"rUserId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     //[FENavTool showAlertViewByAlertMsg:@"回复成功" andType:@"提示"];
                                                     _textField.text = @"";

                                                     int comtcout = [self.curDModel.commentCount intValue];
                                                     [_commentBtn setTitle:[NSString stringWithFormat:@"%d", comtcout + 1] forState:UIControlStateNormal];

                                                     [self doRequesthhhh];
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
- (void)doRequesthhhh
{
    NSString *str = @"020appd/community/showComment";
    NSMutableDictionary *dic =@{}.mutableCopy;
    [dic setObject:self.curDModel.snsId forKey:@"snsId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {

                                                     NSLog(@" 展示评论列表的字典----%@", dic);

                                                     //        //NSArray *array1=@[self.curDModel];
                                                     //        [self.dataArray addObject:@[@"1"]];

                                                     NSArray *array = [FENeighberCommentModel mj_objectArrayWithKeyValuesArray:dic[@"xcommunityShows"]];

                                                     self.dataArray = [NSMutableArray arrayWithArray:array];
                                                     NSInteger inter = self.dataArray.count;
                                                     [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld", inter] forState:UIControlStateNormal];
                                                     [self.FEghouberTableView reloadData];

                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                    }];
}

- (void)doZanAction:(UIButton *)btn
{
    if (isZan==YES) {
        [FENavTool showAlertViewByAlertMsg:@"您已经点过赞" andType:@"赞"];
        
        return;
        
    }
    
    NSString *str = @"020appd/community/dianzan";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_curDModel.snsId forKey:@"snsId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                     NSLog(@"点赞Dic--%@", dic);
                                                       
                                                       isZan=!isZan;
                                                       
                                                     [FENavTool showAlertViewByAlertMsg:@"点赞成功" andType:@"提示"];
                                                     int good = [self.curDModel.good intValue];

                                                     [_zanBtn setImage:Image(@"[Details]-Already_collection") forState:UIControlStateNormal];

                                                     NSString *zannumStr = [NSString stringWithFormat:@"%d", good + 1];
                                                     [_zanBtn setTitle:zannumStr forState:UIControlStateNormal];

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60; // return [FEDynamicStateCell countCellHeightByModel:self.dataArray[indexPath.row]];
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 1)];
    view.backgroundColor=Colorgrayall239;
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetify = @"FECommentCell";
    FECommentCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIndetify];
    if (cell2 == nil)
    {
        cell2 = [[FECommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify];
        cell2.backgroundColor = [UIColor whiteColor];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    FENeighberCommentModel *model = self.dataArray[indexPath.section];
    [cell2 setupNeighberCellWithModel:model];

    return cell2;
}


-(void)rightClick{
    NSString *str = @"020appd/community/removeNews";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:_curDModel.snsId forKey:@"snsId"];
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager] doOperationRequestHttpWithMethod:POST
                                                           withPath:str
                                                     withDictionary:dic
                                                   withSuccessBlock:^(NSDictionary *dic) {
                                                       NSLog(@"--%@", dic);
                                                       [FENavTool showAlertViewByAlertMsg:@"删除成功" andType:@"提示"];
                                                       [self.navigationController popViewControllerAnimated:YES];
                                                       
                                                       
                                                   }
                                                    withfialedBlock:^(NSString *msg){
                                                        
                                                    }];

    
}

@end
