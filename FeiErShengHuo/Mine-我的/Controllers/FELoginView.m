//
//  FELoginView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/5/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FELoginView.h"

@implementation FELoginView


-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self creatUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   
}
-(void)creatUI
{
    //
    _phoneLab=[MYUI createLableFrame:CGRectMake(10, 30, MainW-20, 98/2) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor colorWithHexString:@"#333333"] font:FontAndStyle14 numberOfLines:0 adjustsFontSizeToFitWidth:YES insert:UIEdgeInsetsMake(0, 15, 0, 0)];
    
    [self addSubview:self.phoneLab];
    //
    _phoneTF=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor whiteColor] placeholder:@"请输入手机号" clearsOnBeginEditing:NO];
    _phoneTF.keyboardType=UIKeyboardTypeNumberPad;
    [self addSubview:self.phoneTF];
    
    _securitycodeLab=[MYUI createLableFrame:CGRectMake(10, CGRectGetMaxY(_phoneLab.frame)-1, MainW-20, 98/2) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor clearColor] font: FontAndStyle14 numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.securitycodeLab];
    //
    _securitycodeTF=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor whiteColor] placeholder:@"请输入验证码" clearsOnBeginEditing:NO];
    _securitycodeTF.keyboardType=UIKeyboardTypeNumberPad;
    _securitycodeTF.layer.cornerRadius=0;
    _securitycodeTF.layer.masksToBounds=NO;
    [self addSubview:self.securitycodeTF];
    
    
    
    //
    self.xcodeLab=[MYUI createLableFrame:CGRectMake(10, CGRectGetMaxY(_securitycodeLab.frame)-1, MainW-20, 98/2) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor clearColor] font: FontAndStyle14 numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.xcodeLab];
    //
    _xcodeTF=[MYUI createTextFieldFrame:CGRectZero backgroundColor:[UIColor whiteColor] placeholder:@"请输入邀请码（可选项）" clearsOnBeginEditing:NO];
    _xcodeTF.keyboardType=UIKeyboardTypeNumberPad;
    _xcodeTF.layer.cornerRadius=0;
    _xcodeTF.layer.masksToBounds=NO;
    [self addSubview:self.xcodeTF];
    
    
    //
    _getsecuritycodeBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:[UIColor whiteColor] setTitle:@"获取验证码" setTitleColor:Green_Color ];
    _getsecuritycodeBtn.layer.cornerRadius=5;
    _getsecuritycodeBtn.layer.masksToBounds=YES;
    [_getsecuritycodeBtn setBackgroundColor:[UIColor clearColor]];
    _getsecuritycodeBtn.layer.borderWidth=1;
    _getsecuritycodeBtn.layer.borderColor=Green_Color.CGColor;
    [self addSubview:self.getsecuritycodeBtn];
    //
    _nextBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:Green_Color setTitle:@"登录" setTitleColor:[UIColor whiteColor]];
    _nextBtn.layer.cornerRadius=5;
    _nextBtn.layer.masksToBounds=YES;
    _nextBtn.titleLabel.font=FontAndStyle15;
    [self addSubview:self.nextBtn];
    
    //WithFrame:CGRectMake(10, 726/2, MainW-20, 0.5)];
    
    _lineLab=[[UILabel alloc]init];
    _lineLab.backgroundColor=RGB(153, 153, 153);
    [self addSubview:self.lineLab];
    
    //WithFrame:CGRectMake(MainW/2-112/2, 726/2-7.5, 112, 15)];
    _LogonlineLab=[[UILabel alloc]init];
    _LogonlineLab.backgroundColor=[UIColor whiteColor];
    _LogonlineLab.text=@"或者您可以使用以下方式登陆";
    
    _LogonlineLab.font=[UIFont fontWithName:@"PingFangSC-Regular" size:10];
    _LogonlineLab.textColor=RGB(102, 102, 102);
    _LogonlineLab.textAlignment=YES;
    [self addSubview:self.LogonlineLab];
    
    //CGRectMake(MainW/2-55, 726/2+20, 46, 46)
    _weiChatBtn=[MYUI creatButtonFrame:CGRectZero setZJBackgroundImage:[UIImage imageNamed:@"icon_Login_WeChat"]  setTitle:@"微信"  setTitleColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1] ];
    [_weiChatBtn addTarget:self action:@selector(weixingClick) forControlEvents:UIControlEventTouchUpInside];
    

    _weiChatBtn.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self addSubview:_weiChatBtn];
    //CGRectMake(MainW/2+10, 726/2+20, 46, 46)
    
//    _qqBtn=[MYUI creatButtonFrame:CGRectZero setZJBackgroundImage:[UIImage imageNamed:@"icon_Login_QQ"] setTitle:@"QQ" setTitleColor:RGB(102, 102, 102)];
//    [_qqBtn addTarget:self action:@selector(qqClick) forControlEvents:UIControlEventTouchUpInside];
//
//    _qqBtn.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Regular" size:12];
//     [self addSubview:_qqBtn];
    
    
    self.logView=[[UIImageView alloc]init];
    [self.logView setImage:[UIImage imageNamed:@"icon_Login_logo"]];
    [self addSubview:self.logView];
    
    
    
    
    
    _companyLab=[[UILabel alloc]init];
    _companyLab.backgroundColor=[UIColor whiteColor];
    _companyLab.text=@"江苏捷通网络集团有限公司";
    _companyLab.font=[UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _companyLab.textColor=RGB(102, 102, 102);
    _companyLab.textAlignment=YES;
    [self addSubview:self.companyLab];
    
    
     [self layOut];
}

-(void)weixingClick
{
    if (self.wBlock) {
        self.wBlock();
        
    }
}
-(void)qqClick
{
    if (self.qBlock) {
        self.qBlock();
        
    }
}

-(void)layOut
{
   
    
    [self.phoneTF makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab.top).offset(2);
        make.right.equalTo(self.getsecuritycodeBtn.left).offset(-10);
        make.bottom.equalTo(self.phoneLab.bottom).offset(-2);
        make.left.equalTo(self.phoneLab.left).offset(2);
    }];
    [self.securitycodeTF makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.securitycodeLab.top).offset(2);
        make.right.equalTo(self.securitycodeLab.right).offset(-2);
        make.bottom.equalTo(self.securitycodeLab.bottom).offset(-2);
        make.left.equalTo(self.securitycodeLab.left).offset(2);
    }];
    
    
    
    
    [self.xcodeTF makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xcodeLab.top).offset(2);
        make.right.equalTo(self.xcodeLab.right).offset(-2);
        make.bottom.equalTo(self.xcodeLab.bottom).offset(-2);
        make.left.equalTo(self.xcodeLab.left).offset(2);
    }];
    
    
    
    [self.getsecuritycodeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab).offset(5);
        make.right.equalTo(self.phoneLab.right).offset(-5);
        make.bottom.equalTo(self.phoneLab.bottom).offset(-5);
        make.width.equalTo(120);
    }];
    [self.nextBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(MainW-20);
        make.top.equalTo(self.xcodeLab.bottom).offset(30);
        make.height.equalTo(98/2);
    }];
    
    [self.logView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(177*0.6);
        make.top.equalTo(self.weiChatBtn.bottom).offset(80);
        make.height.equalTo(27*0.6);
    }];
    
    
    [self.companyLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(177*0.6*2);
        make.top.equalTo(self.logView.bottom).offset(10);
        make.height.equalTo(27*0.6);
    }];
    
    UIView *view=(UIView *)[_phoneLab viewWithTag:0];
    //[view addTopBorderWithColor:button_gray_Color andWidth:1];
    [view addBottomBorderWithColor:button_gray_Color andWidth:1];
    
    
    UIView *_securitycodeview=(UIView *)[_securitycodeLab viewWithTag:0];
    [_securitycodeview addTopBorderWithColor:button_gray_Color andWidth:1];
    [_securitycodeview addBottomBorderWithColor:button_gray_Color andWidth:1];
    
    
    UIView *_xcodeView=(UIView *)[_xcodeLab viewWithTag:0];
    [_xcodeView addTopBorderWithColor:button_gray_Color andWidth:1];
    [_xcodeView addBottomBorderWithColor:button_gray_Color andWidth:1];
    
    
    [_lineLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nextBtn.bottom).offset(30);
        make.left.equalTo(self.left).offset(40);
        make.width.equalTo(MainW-80);
        make.height.equalTo(0.5);
    }];
    
    
    [_LogonlineLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lineLab.centerY);
        make.centerX.equalTo(_lineLab.centerX);
         make.width.equalTo(177*0.6*2);
        
    }];
    
    [_weiChatBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_LogonlineLab.bottom).offset(30);
        
        make.centerX.equalTo(self.centerX);//.offset(-MainW/4);
        make.width.equalTo(46);
        make.height.equalTo(46);

    }];
//    [_qqBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_LogonlineLab.bottom).offset(30);
//        make.centerX.equalTo(self.centerX).offset(MainW/4);
//        make.width.equalTo(46);
//        make.height.equalTo(46);
//    }];
}
@end
