//
//  FEPayCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/14.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEPayCell.h"

@implementation FEPayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI {
    
    UIImageView *imageView=[MYUI creatImageViewFrame:CGRectMake(14, 4, 20, 20) imageName:@"icon_money"];
    [self addSubview:imageView];
    
    _TitleLab=[MYUI createLableFrame:CGRectMake(14+25+3, 7, MainW-18-100, 15) backgroundColor:[UIColor whiteColor] text:@"物业费" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_TitleLab];
    
    UILabel *moreLab=[MYUI createLableFrame:CGRectMake(MainW-60-18, 7, 50, 15) backgroundColor:[UIColor clearColor] text:@"详情 >" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:moreLab];
    
    _payrightTimeLab=[MYUI createLableFrame:CGRectMake(MainW-(14+25+3+60+18), 7+15+5, 90, 14) backgroundColor:[UIColor clearColor] text:@"2017.02.24" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_payrightTimeLab];
    
    _statusLab=[MYUI createLableFrame:CGRectMake(14,7+15+5, 60, 16) backgroundColor:[UIColor redColor] text:@"已处理" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _statusLab.layer.cornerRadius=4;
    _statusLab.layer.masksToBounds=YES;
    [self addSubview:_statusLab];
    //公告细节2
    _payTimeLab=[MYUI createLableFrame:CGRectMake(14, _statusLab.frame.origin.y+20, MainW-28-18, 44) backgroundColor:[UIColor whiteColor] text:@"缴费时间：2017-02-25" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_payTimeLab];
    
    _moneyLab=[MYUI createLableFrame:CGRectMake(MainW-244/2-18, _statusLab.frame.origin.y+20, 244/2, 44) backgroundColor:[UIColor clearColor] text:@"金额:562.00" textColor:[UIColor redColor] font:[UIFont systemFontOfSize:18] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.moneyLab];
    
    
}

@end
