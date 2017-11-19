//
//  FEDynamicStateCell.m
//  CCICPhone
//
//  Created by apple on 15/6/17.
//  Copyright (c) 2015年 Ruyun. All rights reserved.
//

#import "FEDynamicStateCell.h"
#import "RYImageTool.h"
#import "WPAttributedStyleAction.h"
#import "NSString+WPAttributedMarkup.h"
#import "FEphotoCell.h"
#import "FEPictureModel.h"

#import "UIImageView+WebCache.h"
//#import "RYLoginInfoObj.h"

#define PERSONAL_INFO_ITEM_HEIGHT 72



@implementation FEDynamicStateCell

+(CGFloat)countCellHeightByModel:(FEDynamicModel *)model
{
    CGFloat heightNum = 15+20+5+20+5+20+10;
    
   
    //图片
    if (model.pictureMap.count>0) {
        NSInteger beiNum = (MainW-32-76-16)/(DYNAMIC_PICTURE_WIDTH+8);
        NSInteger imgHangNum = model.pictureMap.count/beiNum;
        if (model.pictureMap.count%beiNum != 0) {
            imgHangNum = model.pictureMap.count/beiNum + 1;
        }
        heightNum = heightNum + (DYNAMIC_PICTURE_HEIGHT+8)*imgHangNum-8 + 16;
    }
    return heightNum;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.imageArray=[NSArray array];
        //头像
        UIImage *imgPlaceholder = [UIImage imageNamed:@"Shopping_picture2"];
        self.headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.image = imgPlaceholder;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 30;
        [_headImageView setFrame:CGRectMake(9, 19, 60, 60)];
        [self addSubview:_headImageView];
        //名字
        self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(92, 15, 150, 20)];
        _nameLab.font = [UIFont boldSystemFontOfSize:16];
        _nameLab.textColor = [UIColor colorWithHexString:@"#117c1b"];
        _nameLab.text=@"刘建明";
        [self addSubview:_nameLab];
        
        self.titleLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor whiteColor] text:@"title" textColor:RGB(254, 97, 50) font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
        [self addSubview:self.titleLab];
        
        //发布内容
        _FENeighberContantLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"大家好，新年好" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
        [self addSubview:self.FENeighberContantLab];
        //赞
        self.zanBtn = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusNormal];
        //        if (_currentModel.laudationStatus == 0) {
        //            [_zanBtn setImage:[UIImage imageNamed:@"icon_zan"] forState:UIControlStateNormal];
        //        }else{
        //            [_zanBtn setImage:[UIImage imageNamed:@"icon_zan2"] forState:UIControlStateNormal];
        //        }
        [_zanBtn setImage:[UIImage imageNamed:@"icon_heart_normal"] forState:UIControlStateNormal];
        
        //[_zanBtn setFrame:CGRectMake(_middleViewItem.frame.size.width-132, 0, 50, 48)];
        [_zanBtn setTitle:@"1"forState:UIControlStateNormal];
        _zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_zanBtn setTitleColor:GLOBAL_BIG_FONT_COLOR forState:UIControlStateNormal];
        //[_zanBtn addTarget:self action:@selector(doZanAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_zanBtn];
        
        //评论
        self.commentBtn = [[FL_Button alloc] initWithAlignmentStatus:FLAlignmentStatusNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"icon_speak"] forState:UIControlStateNormal];
        //[_commentBtn setFrame:CGRectMake(_middleViewItem.frame.size.width-66, 0, 50, 48)];
        [_commentBtn setTitle:@"1"forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_commentBtn setTitleColor:GLOBAL_BIG_FONT_COLOR forState:UIControlStateNormal];
        //[_commentBtn addTarget:self action:@selector(doCommentAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentBtn];
        
        //时间细节
        _timeDetailLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:10] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
        _timeDetailLab.textAlignment=NSTextAlignmentRight;
        [self addSubview:self.timeDetailLab];
        
        //地点图标
        _AddressImageView=[MYUI creatImageViewFrame:CGRectZero imageName:@"icon_house"];
        [self addSubview:self.AddressImageView];
        
        _addressLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"菲尔花园" textColor:[UIColor colorWithHexString:@"#8c8c8c"] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
        [self addSubview:self.addressLab];
        
        
    }
    return self;
    
}


-(void)setModel:(FEDynamicModel *)model{
    _model=model;
    
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.headImgUrl] placeholderImage:[UIImage imageNamed:@"pic"]];
    
    if ([_model.headImgUrl isEqualToString:@""]||_model.headImgUrl.length==0) {
        [_headImageView setImage:[UIImage imageNamed:@"pic"]];
    }
    
    NSString *zannumStr=[NSString stringWithFormat:@"%@",_model.good];
    
    [_zanBtn setTitle:zannumStr forState:UIControlStateNormal];
    //设置
    self.nameLab.text=_model.nickName;
    self.FENeighberContantLab.text=_model.content;
    self.titleLab.text=_model.title;
    self.timeDetailLab.text=_model.createTimeStr;
    self.addressLab.text=_model.title;
    
    
    [self.zanBtn setTitle:[NSString stringWithFormat:@"%@",model.good] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%@",model.commentCount] forState:UIControlStateNormal];
    
}

// 定位
-(void)layoutSubviews

{[super layoutSubviews];
    
    
    //手机号码。单行 宽度
    titleW=[_model.title singleLineWidthWithFont:[UIFont systemFontOfSize:15]];
    _titleLab.frame=CGRectMake(CGRectGetMinX(self.nameLab.frame), CGRectGetMaxY(self.nameLab.frame)+5, titleW, 20);
    NSMutableArray *imageArray=_model.pictureMap;
    
     CGFloat offY = PERSONAL_INFO_ITEM_HEIGHT;
    //图片 9宫格布局 图片尺寸固定的哦
    if (imageArray.count > 0) {
        //图片 滚动视图的位置 大小事固定的
        NSInteger beiNum = (MainW-32-76-16)/(DYNAMIC_PICTURE_WIDTH+8);
        NSInteger imgHangNum = imageArray.count/beiNum;
        if (imageArray.count%beiNum != 0) {
            imgHangNum =imageArray.count/beiNum + 1;
        }
        self.nineImageView = [[UIView alloc] initWithFrame:CGRectMake(16+76, CGRectGetMaxY(_headImageView.frame)+5, MainW-48-76-16,(DYNAMIC_PICTURE_HEIGHT+8)*imgHangNum-8)];
        
        for (int i = 0; i < imageArray.count; ++i) {
            UIImageView *curImg = [[UIImageView alloc] init];
            curImg.clipsToBounds=YES;
            curImg.contentMode=UIViewContentModeScaleAspectFill;
            NSInteger curHang = i/beiNum;
            NSInteger curLie = i%beiNum;
            curImg.userInteractionEnabled = YES;
            curImg.tag = 200+i;
            UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doOpenImange:)];
            [curImg addGestureRecognizer:imgTap];
            //curImg.contentMode = UIViewContentModeScaleAspectFit;
            curImg.frame = CGRectMake(curLie*(DYNAMIC_PICTURE_WIDTH+8), (DYNAMIC_PICTURE_HEIGHT+8)*curHang, DYNAMIC_PICTURE_WIDTH, DYNAMIC_PICTURE_HEIGHT);
            FEPictureModel *curImgModel = imageArray[i];
            if (curImgModel.url.length) {
                [curImg sd_setImageWithURL:[NSURL URLWithString:curImgModel.url]];
            }
            [_nineImageView addSubview:curImg];
        }
        [self addSubview:_nineImageView];
        offY = offY + _nineImageView.frame.size.height + 16;
    }
    
    [_FENeighberContantLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.right).offset(2);
        make.top.equalTo(self.titleLab.top);
        make.right.equalTo(self.right).offset(-5);
        make.height.equalTo(20);
    }];

    _timeDetailLab.frame=CGRectMake(MainW-130, CGRectGetMinY(_nameLab.frame), 120, 10);
    
    //
    if (imageArray.count==0) {
        _AddressImageView.frame=CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_titleLab.frame)+5, 15, 15);
        _addressLab.frame=CGRectMake(CGRectGetMaxX(_AddressImageView.frame)+5, CGRectGetMaxY(_titleLab.frame)+5, MainW-200, 15);
        _zanBtn.frame=CGRectMake(MainW-100, CGRectGetMaxY(_titleLab.frame)+5, 50, 20);
        
        _commentBtn.frame=CGRectMake(MainW-60, CGRectGetMaxY(_titleLab.frame)+5, 50, 20);
    
    }else
    {
        _AddressImageView.frame=CGRectMake(CGRectGetMinX(_nameLab.frame), CGRectGetMaxY(_nineImageView.frame)+5, 15, 15);
        _addressLab.frame=CGRectMake(CGRectGetMaxX(_AddressImageView.frame)+5, CGRectGetMaxY(_nineImageView.frame)+5, MainW-200, 15);
        
        _zanBtn.frame=CGRectMake(MainW-100, CGRectGetMaxY(_nineImageView.frame)+5, 50, 20);
        
        _commentBtn.frame=CGRectMake(MainW-60, CGRectGetMaxY(_nineImageView.frame)+5, 50, 20);

        
        
    }
    
    
}

-(void)doOpenImange:(UITapGestureRecognizer *)tap
{
    NSMutableArray *imgArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (UIView *tgImgView in _nineImageView.subviews) {
        if ([tgImgView isKindOfClass:[UIImageView class]]) {
            UIImageView *curImgView = (UIImageView *)tgImgView;
            UIImage *tgimg = curImgView.image;
            if (tgimg) {
                [imgArr addObject:tgimg];
            }
        }
    }
    UIImageView *tgImgView = (UIImageView *)tap.view;
    NSInteger index = tgImgView.tag - 200;
    if (_delegate && [_delegate respondsToSelector:@selector(doShowImgAction:andIndex:)]) {
        [_delegate doShowImgAction:imgArr andIndex:index];
    }
}



@end
