//
//  FESecondHandCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/29.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESecondHandCell.h"
#define PERSONAL_INFO_ITEM_HEIGHT 70

@implementation FESecondHandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    //头像
    UIImage *imgPlaceholder = [UIImage imageNamed:@"Shopping_picture2"];
    _headimageView = [[UIImageView alloc] init];
    _headimageView.contentMode = UIViewContentModeScaleAspectFill;
    _headimageView.image = imgPlaceholder;
    _headimageView.layer.masksToBounds = YES;

    _headimageView.layer.cornerRadius = 25;
    [_headimageView setFrame:CGRectMake(10, 10, 50, 50)];
    [self addSubview:_headimageView];
    //手机
    
    _mobileLab=[MYUI createLableFrame:CGRectMake(70, 20, MainW/2-70, 20) backgroundColor:[UIColor clearColor] text:@"15240543995" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_mobileLab];
    
    _rankLab=[MYUI createLableFrame:CGRectMake(70,45, MainW/2-70, 20) backgroundColor: [UIColor clearColor] text:@"等级：1" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_rankLab];
    
    
    _originPriceLab=[MYUI createLableFrame:CGRectMake(MainW/2, 20, MainW/4, 20) backgroundColor:[UIColor clearColor] text:@"¥3400" textColor: TxTGray_Color1 font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _originPriceLab.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:_originPriceLab];
    
    _nowPriceLab=[MYUI createLableFrame:CGRectMake(MainW/2+MainW/4, 20, MainW/4-10, 20) backgroundColor:[UIColor clearColor] text:@"¥3400" textColor: [UIColor redColor] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _nowPriceLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:_nowPriceLab];
    
    _publishdateLab=[MYUI createLableFrame:CGRectMake(MainW/2, 45, MainW/2-10, 20) backgroundColor:[UIColor clearColor] text:@"2016-10-31-08:39:39" textColor:TxTGray_Color1 font:[UIFont systemFontOfSize:12] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _publishdateLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:_publishdateLab];
    
    
    //内容的lab
    _contentLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"hahhahah" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_contentLab];
    

    //地点图标
    _regionimageView=[MYUI creatImageViewFrame:CGRectZero imageName:@"icon_house"];
    [self addSubview:_regionimageView];
    
    _regionLab=[MYUI createLableFrame:CGRectZero backgroundColor:[UIColor clearColor] text:@"菲尔花园" textColor:[UIColor colorWithHexString:@"#8c8c8c"] font:[UIFont systemFontOfSize:13] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_regionLab];
    
    //手机
    _phoneBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:RGB(3, 207, 46) setTitle:@"手机" setTitleColor:[UIColor whiteColor]];
    [_phoneBtn addTarget:self action:@selector(phone ) forControlEvents:UIControlEventTouchUpInside];
    
    
    _phoneBtn.layer.cornerRadius=5;
    _phoneBtn.layer.masksToBounds=YES;
    [self addSubview:_phoneBtn];
    
    //
    _personReciveBtn=[MYUI creatButtonFrame:CGRectZero backgroundColor:RGB(204, 8, 14) setTitle:@"自提" setTitleColor:[UIColor whiteColor]];
    _personReciveBtn.layer.cornerRadius=5;
    _personReciveBtn.layer.masksToBounds=YES;
    //[self addSubview:_personReciveBtn];
}

-(void)setBlock:(phoneBlock)block{
    _block=block;
    
}
-(void)phone
{
    _block?_block(_model.mobile):nil;
    
}


-(void)setModel:(FEsecondhandModel *)model{
    _model=model;
    
    
    [_headimageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _mobileLab.text=model.mobile;
    _rankLab.text=[NSString stringWithFormat:@"等级:%@",model.rankId];
    
    //原价
    CGFloat Oprice=[model.orginPrice integerValue]/100;
    _originPriceLab.text=[NSString stringWithFormat:@"¥%.0f",Oprice];
    
    //现价
    CGFloat Nprice=[model.sellPrice integerValue]/100;
    _nowPriceLab.text=[NSString stringWithFormat:@"¥%.0f",Nprice];
    
    
    _contentLab.text=model.goodsContent;
    
    
    _publishdateLab.text=model.publishDateLineStr;
    
    NSMutableArray *imageArray=model.pictureMap;
    
    CGFloat offY = PERSONAL_INFO_ITEM_HEIGHT;
    //图片 9宫格布局 图片尺寸固定的哦
    if (imageArray.count > 0) {
        //图片 滚动视图的位置 大小事固定的
        NSInteger beiNum = (MainW-32-80)/(DYNAMIC_PICTURE_WIDTH+8);
        NSInteger imgHangNum = imageArray.count/beiNum;
        if (imageArray.count%beiNum != 0) {
            imgHangNum =imageArray.count/beiNum + 1;
        }
        _nineImageView = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_headimageView.frame)+10, MainW-48-80,(DYNAMIC_PICTURE_HEIGHT+8)*imgHangNum-8)];
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
            
            
            // curImg.contentMode = UIViewContentModeScaleAspectFit;
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
    
    
    CGFloat  contentheight=[model.goodsContent heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-20];
    
    
    if (imageArray.count>0) {
        
        _contentLab.frame=CGRectMake(10, CGRectGetMaxY(_nineImageView.frame)+10, MainW-20, contentheight);
        _regionimageView.frame=CGRectMake(10, CGRectGetMaxY(_contentLab.frame)+15 , 15, 15);
        _regionLab.frame=CGRectMake(CGRectGetMaxX(_regionimageView.frame)+5, CGRectGetMaxY(_contentLab.frame)+15, MainW/2-30, 15);
        _phoneBtn.frame=CGRectMake(MainW-60, CGRectGetMaxY(_contentLab.frame)+10,40, 25);
        _personReciveBtn.frame=CGRectMake(CGRectGetMaxX(_phoneBtn.frame)+10, CGRectGetMaxY(_contentLab.frame)+10, 40, 25);
        
    }
    else{
        _contentLab.frame=CGRectMake(10, CGRectGetMaxY(_headimageView.frame)+10, MainW-20, contentheight);
        _regionimageView.frame=CGRectMake(10, CGRectGetMaxY(_contentLab.frame)+15 , 15, 15);
        _regionLab.frame=CGRectMake(CGRectGetMaxX(_regionimageView.frame)+5, CGRectGetMaxY(_contentLab.frame)+15, MainW/2-30, 15);
        _phoneBtn.frame=CGRectMake(MainW-60, CGRectGetMaxY(_contentLab.frame)+10,40, 25);
        _personReciveBtn.frame=CGRectMake(CGRectGetMaxX(_phoneBtn.frame)+10, CGRectGetMaxY(_contentLab.frame)+10, 40, 25);
        
    }
    
}



+(CGFloat)countSecondHandCellHeightByModel:(FEsecondhandModel *)model
{
     CGFloat  contentheight=[model.goodsContent heightWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:MainW-20];
    //CGFloat heightNum = 72+contentheight+50;

    
    if (model.pictureMap.count>0) {
        NSInteger beiNum = (MainW-32-80)/(DYNAMIC_PICTURE_WIDTH+8);
        NSInteger imgHangNum = model.pictureMap.count/beiNum;
        if (model.pictureMap.count%beiNum != 0) {
            imgHangNum = model.pictureMap.count/beiNum + 1;
        }
        return  PERSONAL_INFO_ITEM_HEIGHT+ (DYNAMIC_PICTURE_HEIGHT+8)*imgHangNum-8+contentheight+60;
        

    }else
    {
        
        return PERSONAL_INFO_ITEM_HEIGHT+contentheight+60;
        
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
