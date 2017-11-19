//
//  FEKefuTableViewCell.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/9/1.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEKefuTableViewCell.h"

@implementation FEKefuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    //发布内容
    self.nameLab=[MYUI createLableFrame:CGRectMake(100, 0, MainW/2-100, 30) backgroundColor:[UIColor clearColor]
 text:@"这个太给力" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:15]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.nameLab];
    
    //时间细节
    self.phonelab=[MYUI createLableFrame:CGRectMake(MainW/2, 0, MainW/2-100, 30) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
    [self addSubview:self.phonelab];
    
   
    UIImageView *imageView=[MYUI creatImageViewFrame:CGRectZero imageName:@"servicec_phone3"];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.phonelab.right).offset(10);
        make.centerY.mas_equalTo(self.centerY);
        make.height.with.mas_equalTo(20);
        
    }];
    
    
}


@end
