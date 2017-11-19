//
//  FEFeedBackViewController.m
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEFeedBackViewController.h"
#import <IQTextView.h>

@interface FEFeedBackViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UITextField *nameTextField;

@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *phoneTextField;

@property (nonatomic,strong) UILabel *emailLabel;
@property (nonatomic,strong) UITextField *emailTextField;

@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) IQTextView *infoTextView;

@property (nonatomic,strong) UIButton *sendButton;

@end

@implementation FEFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"反馈";
}

#pragma mark - private
- (void)initView
{
    self.view.backgroundColor = RGB(240, 252, 237);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.nameTextField];
    [self.scrollView addSubview:self.phoneLabel];
    [self.scrollView addSubview:self.phoneTextField];
    [self.scrollView addSubview:self.emailLabel];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.infoLabel];
    [self.scrollView addSubview:self.infoTextView];
    [self.scrollView addSubview:self.sendButton];
    
    //@weakify(self);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       // @strongify(self);
        make.edges.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
    }];
    
    [self makeTitleLabel:self.nameLabel TextView:self.nameTextField textViewHeight:39 topView:self.scrollView topMargin:12];
    [self makeTitleLabel:self.phoneLabel TextView:self.phoneTextField textViewHeight:39 topView:self.self.nameTextField topMargin:12];
    [self makeTitleLabel:self.emailLabel TextView:self.emailTextField textViewHeight:39 topView:self.phoneTextField topMargin:12];
    [self makeTitleLabel:self.infoLabel TextView:self.infoTextView textViewHeight:167 topView:self.emailTextField topMargin:12];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
       // @strongify(self);
        make.left.mas_equalTo(self.scrollView).offset(18);
        make.right.mas_equalTo(self.scrollView).offset(-18);
        make.top.mas_equalTo(self.infoTextView.mas_bottom).offset(32);
        make.height.mas_equalTo(39);
        make.bottom.mas_equalTo(self.scrollView).offset(-32);
    }];
}

#pragma mark - method
- (void)sendAction
{
    
}

#pragma mark - Layout
- (void)makeTitleLabel:(UILabel *)titleLabel TextView:(UIView *)TextView textViewHeight:(CGFloat)textViewHeight topView:(UIView *)topView topMargin:(CGFloat)topMargin
{
   // @weakify(self);
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       // @strongify(self);
        
        if (topView == self.scrollView) {
            make.top.mas_equalTo(self.scrollView).offset(12);
        }
        else {
            make.top.mas_equalTo(topView.mas_bottom).offset(12);
        }
        
        make.left.mas_equalTo(self.scrollView).offset(18);
    }];
    
    [TextView mas_makeConstraints:^(MASConstraintMaker *make) {
       // @strongify(self);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(self.scrollView).offset(18);
        make.right.mas_equalTo(self.scrollView).offset(-18);
        make.width.mas_equalTo(MainW - 18*2);
        make.height.mas_equalTo(textViewHeight);
    }];
}

#pragma mark - UIMaker

- (UILabel *)normalLabelWithText:(NSString *)text isNecessary:(BOOL)isNecessary
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    if (isNecessary) {
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",text]];
        [mstr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [mstr setAttributes:@{NSForegroundColorAttributeName:Green_Color} range:NSMakeRange(1, text.length)];
        label.attributedText = mstr;
    }
    else {
        label.text = text;
        label.textColor = Green_Color;
    }
    
    return label;
}

- (UITextField *)normalTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.layer.cornerRadius = 3.0f;
    textField.layer.borderWidth = 1.0f;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.clipsToBounds = YES;
    
    textField.font = [UIFont systemFontOfSize:14];
    
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    return textField;
}

- (IQTextView *)normalTextView
{
    IQTextView *textView = [[IQTextView alloc] init];
    
    textView.backgroundColor = [UIColor whiteColor];
    
    textView.layer.cornerRadius = 3.0f;
    textView.layer.borderWidth = 1.0f;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    textView.clipsToBounds = YES;
    
    textView.font = [UIFont systemFontOfSize:14];
    
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textView.placeholder = @"您有什么问题或建议对我说？";
    
    return textView;
}

#pragma mark - getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = RGB(240, 252, 237);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [self normalLabelWithText:@"姓名：" isNecessary:NO];
    }
    return _nameLabel;
}

- (UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [self normalTextField];
    }
    return _nameTextField;
}

- (UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [self normalLabelWithText:@"电话：" isNecessary:NO];
    }
    return _phoneLabel;
}

- (UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = [self normalTextField];
    }
    return _phoneTextField;
}

- (UILabel *)emailLabel
{
    if (!_emailLabel) {
        _emailLabel = [self normalLabelWithText:@"邮箱：" isNecessary:YES];
    }
    return _emailLabel;
}

- (UITextField *)emailTextField
{
    if (!_emailTextField) {
        _emailTextField = [self normalTextField];
    }
    return _emailTextField;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [self normalLabelWithText:@"反馈信息：" isNecessary:YES];
    }
    return _infoLabel;
}

- (IQTextView *)infoTextView
{
    if (!_infoTextView) {
        _infoTextView = [self normalTextView];
    }
    return _infoTextView;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = Green_Color;
        [_sendButton setTitle:@"提交反馈 " forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _sendButton;
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
