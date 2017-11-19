//
//  FEComplainCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEComplainCell.h"

@implementation FEComplainCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI {
    
    UIImageView *imageView=[MYUI creatImageViewFrame:CGRectMake(14, 4, 20, 20) imageName:@"icon_Report"];
    [self addSubview:imageView];
    
    _complaintTitleLab=[MYUI createLableFrame:CGRectMake(14+25+3, 7, MainW-18-100, 15) backgroundColor:[UIColor whiteColor] text:@"投诉建议—硬件设施" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_complaintTitleLab];
    
    UILabel *moreLab=[MYUI createLableFrame:CGRectMake(MainW-60-18, 7, 50, 15) backgroundColor:[UIColor clearColor] text:@"更多 >" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:moreLab];
    
    _complaintTimeLab=[MYUI createLableFrame:CGRectMake(MainW/2, 7+15+5, MainW/2-30, 14) backgroundColor:[UIColor clearColor] text:@"2017.02.24" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _complaintTimeLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:_complaintTimeLab];
    
    //状态
    _statusLab=[MYUI createLableFrame:CGRectMake(14,7+15+5, 60, 20) backgroundColor: [UIColor redColor] text:@"已处理" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _statusLab.textAlignment=NSTextAlignmentCenter;
    
    _statusLab.layer.cornerRadius=4;
    _statusLab.layer.masksToBounds=YES;
    [self addSubview:_statusLab];
    //细节2
    _complaintDetailSecondLab=[MYUI createLableFrame:CGRectMake(14, _statusLab.frame.origin.y+20, MainW-28-18, 44) backgroundColor:[UIColor whiteColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:10] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
    [self addSubview:self.complaintDetailSecondLab];
    
}



-(void)setFrame:(CGRect)frame
{
    frame.origin.x=10;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=1;
    [super setFrame:frame];
    
}

-(void)setupCellWithModel:(FEadviceModel *)model
{
    _complaintTitleLab.text=model.categoryName;
    _statusLab.text=model.adviceResolve;
    _complaintTimeLab.text=model.adviceCreateTimeStr;
    _complaintDetailSecondLab.text=model.adviceContent;
    
}

@end
