//
//  RYPersonInfoItem.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/13.
//  Copyright © 2017年 xjbyte. All rights reserved.
//


#import "RYPersonInfoItem.h"
#import "RYImageTool.h"
#import "UIImageView+WebCache.h"


@implementation RYPersonInfoItem

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpAllViews];
    }
    return self;
}

-(void)setUpAllViews
{
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPersonInfoItem)];
    [self addGestureRecognizer:tap];
    
    //头像
    UIImage *imgPlaceholder = [UIImage imageNamed:@"userpic_default"];
    self.headImageView = [[UIImageView alloc] init];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.image = imgPlaceholder;
    UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPersonInfoItem)];
    [_headImageView addGestureRecognizer:tapPhoto];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 20;
    [_headImageView setFrame:CGRectMake(16, 16, 40, 40)];
    [self addSubview:_headImageView];
    
    //名字
    self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(66, 16, 100, 18)];
    _nameLab.font = [UIFont boldSystemFontOfSize:17.f];
    _nameLab.textColor = GLOBAL_BIG_FONT_COLOR;
    [self addSubview:_nameLab];
    //公司职位
    self.companyLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, 180, 14)];
    _companyLbl.font = [UIFont boldSystemFontOfSize:14.f];
    _companyLbl.textColor = GLOBAL_BIG_FONT_COLOR;
    [self addSubview:_companyLbl];
    
    self.jobLbl = [[UILabel alloc] initWithFrame:CGRectMake(66, 38, MainW-82, 14)];
    _jobLbl.font = [UIFont systemFontOfSize:14.f];
    _jobLbl.textColor = GLOBAL_BIG_FONT_COLOR;
    [self addSubview:_jobLbl];
    
    //删除按钮
    self.delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_delBtn setFrame:CGRectMake(self.frame.size.width-50, 2, 48, 48)];
    [_delBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [_delBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    _delBtn.hidden = YES;
    [self addSubview:_delBtn];
}

-(void)updatePersonInfo:(FEDynamicModel *)model
{
//    RYUserInfoModel *usermodel = model.userInfo;
//    if (usermodel.portrait.length) {
//        NSString *pbImgStr = [usermodel.portrait stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [_headImageView sd_setImageWithURL:[NSURL URLWithString:pbImgStr]];
//    }
//    NSString *comStr = usermodel.enterprise?usermodel.enterprise:@"";
//    NSString *posStr = usermodel.industry?usermodel.industry:@"";
//    
//    //设置名字 公司 职位标签
//    CGFloat nameLen = [usermodel.realName singleLineWidthWithFont:_nameLab.font];
//    self.nameLab.frame = CGRectMake(66, 16, nameLen, 18);
//    self.nameLab.text = usermodel.realName;
//    
//    self.companyLbl.text = comStr;
//    CGFloat companyLen = [comStr singleLineWidthWithFont:_companyLbl.font];
//    //判断是否超过了长度
//    if ((companyLen + _nameLab.frame.origin.x+nameLen+5 + 50) > (MainW-16)) {
//        companyLen = MainW-66 - _nameLab.frame.origin.x - nameLen - 5;
//    }
//    self.companyLbl.frame = CGRectMake(_nameLab.frame.origin.x+nameLen+5, 19, companyLen, 14);
//    self.jobLbl.text = posStr;
//    
//    if (model.canDel) {
//        _delBtn.hidden = NO;
//    }else{
//        _delBtn.hidden = YES;
//    }
}

-(void)tapPersonInfoItem
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickCurrentItem:)]) {
        [_delegate clickCurrentItem:self];
    }
}

-(void)deleteAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(DeleteCurrentItmeMenu:)]) {
        [_delegate DeleteCurrentItmeMenu:self];
    }
}

@end
