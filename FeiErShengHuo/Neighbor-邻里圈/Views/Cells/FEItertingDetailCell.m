//
//  FEItertingDetailCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/12.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEItertingDetailCell.h"

@implementation FEItertingDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
/*
UIImageView *_topicPicImageView;
UILabel *_authorLab;
UILabel *_topicThemeLab;
UILabel *_createTimeStrLab;
 */


-(void)creatUI
{
    
   
    
    
    
    _topicThemeLab=[MYUI createLableFrame:CGRectMake(10,0, (MainW-20)/2, 40) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:18]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _topicThemeLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_topicThemeLab];
    
    //作者
    _authorLab=[MYUI createLableFrame:CGRectMake(10+(MainW-20)/2,0,(MainW-20)/2, 40) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:18] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _authorLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:_authorLab];
    
    _topicPicImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40, MainW-20, (MainW-20)*0.5)];
    [self addSubview:_topicPicImageView];
    
    //时间细节
    _createTimeStrLab=[MYUI createLableFrame:CGRectMake(10, CGRectGetMaxY(_topicPicImageView.frame),(MainW-20)/2 , 40
                                                        ) backgroundColor:[UIColor whiteColor] text:@"2017-03-02- 05:47:26" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _createTimeStrLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_createTimeStrLab];
    
   
    
}

-(void)setupCellWithModel:(FEIntertingDetailModel *)model
{
    
    [_topicPicImageView sd_setImageWithURL:[NSURL URLWithString:model.topicPic]];
    
    _topicThemeLab.text=model.topicTheme;
    _authorLab.text=model.author;
    
    _createTimeStrLab.text=model.createTimeStr;
    
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainW, 1)];
    secView.backgroundColor = Colorgrayall239;
    [self addSubview:secView];

}


@end
