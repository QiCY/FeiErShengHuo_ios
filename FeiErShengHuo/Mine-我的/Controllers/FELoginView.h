//
//  FELoginView.h
//  FeiErShengHuo
//
//  Created by zy on 2017/5/5.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^weixngBlock)();
typedef void(^qqBlock)();
@interface FELoginView : UIView

@property(nonatomic,strong)UILabel *phoneLab;
@property(nonatomic,strong)UILabel *securitycodeLab;
@property(nonatomic,strong)UILabel *xcodeLab;

@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UITextField *xcodeTF;
@property(nonatomic,strong)UITextField *securitycodeTF;
@property(nonatomic,strong)UIButton *getsecuritycodeBtn;
@property(nonatomic,strong)UIButton *nextBtn;

@property(nonatomic,strong)UIButton *weiChatBtn;
@property(nonatomic,strong)UIButton *qqBtn;
@property(nonatomic,strong)UILabel *lineLab;
@property(nonatomic,strong)UILabel *LogonlineLab;


@property(nonatomic,strong)UILabel *companyLab;
@property(nonatomic,strong)UIImageView *logView;
@property(nonatomic,copy)weixngBlock wBlock;

@property(nonatomic,copy)qqBlock qBlock;

@end
