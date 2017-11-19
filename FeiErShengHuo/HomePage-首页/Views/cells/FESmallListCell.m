//
//  FESmallListCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/26.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FESmallListCell.h"

@implementation FESmallListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI
{
    _statusLab=[[UIView alloc]initWithFrame:CGRectMake(10, 15, 4, 10)];
    _statusLab.backgroundColor=Green_Color;
    [self addSubview:_statusLab];
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_statusLab.frame)+5, 12, 16, 16)];
    _imageView.image=[UIImage imageNamed:@"icon_horn2"];
    
    [self addSubview:_imageView];
    
    _titleLab=[MYUI createLableFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+5, 10, MainW-100, 20) backgroundColor:[UIColor whiteColor] text:@"hahaah" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_titleLab];
    
}
-(void)setupCellWithModel:(FESmallNoticeModel *)model
{
    _titleLab.text=model.annonceTitle;
    //0未读
    if ([model.weid isEqualToNumber:[NSNumber numberWithInt:0]]) {
        _statusLab.backgroundColor=[UIColor redColor];
        _imageView.image=[UIImage imageNamed:@"icon_horn1"];
    }
    else
    {
        _statusLab.backgroundColor=Green_Color;
        _imageView.image=[UIImage imageNamed:@"icon_horn2"];
        
    }
}
@end
