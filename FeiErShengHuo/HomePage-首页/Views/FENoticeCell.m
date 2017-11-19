//
//  FENoticeCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FENoticeCell.h"
#import "MYUI.h"

@implementation FENoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI {
    
    UIImageView *imageView=[MYUI creatImageViewFrame:CGRectMake(14, 4, 20, 20) imageName:@"icon_horn"];
    [self addSubview:imageView];
    UILabel *noticeLab=[MYUI createLableFrame:CGRectMake(14+25+3, 7, 100, 15) backgroundColor:[UIColor whiteColor] text:@"社区公告" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:noticeLab];
    
    UILabel *moreLab=[MYUI createLableFrame:CGRectMake(MainW-60-18, 7, 50, 15) backgroundColor:[UIColor clearColor] text:@"更多 >" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:moreLab];
    
    _noticeTimeLab=[MYUI createLableFrame:CGRectMake(MainW/2, 7+15+5, MainW/2-10-15, 14) backgroundColor:[UIColor clearColor] text:@"2017.02.24" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _noticeTimeLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.noticeTimeLab];

    //公告细节1
    _noticeDetailFirstLab=[MYUI createLableFrame:CGRectMake(14,7+15+5, self.frame.size.width/2, 14) backgroundColor:[UIColor whiteColor] text:@"06栋停水通知" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.noticeDetailFirstLab];
    //公告细节2
    _noticeDetailSecondLab=[MYUI createLableFrame:CGRectMake(14, 7+15+14+10, MainW-28-18, 44) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:10] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.noticeDetailSecondLab];
    
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x=10;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=1;
    [super setFrame:frame];
    
}

-(void)setupCellWithModel:(FENoticeModel *)model
{
    _noticeDetailFirstLab.text=model.annonceTitle;
    _noticeDetailSecondLab.text=model.annonceText;
    _noticeTimeLab.text=model.creatimeStr;
    
    
}

@end
