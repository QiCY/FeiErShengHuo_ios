//
//  FEFirstComentTableViewCell.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/7/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEFirstComentTableViewCell.h"

@implementation FEFirstComentTableViewCell

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
    
    //名字
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont boldSystemFontOfSize:16];
    lab.textColor = [UIColor blackColor];
    lab.text=@"宝贝评价";
    lab.frame=CGRectMake(10, 5, MainW/2, 20);
    
    [self addSubview:lab];
    
    //头像
    UIImage *imgPlaceholder = [UIImage imageNamed:@"Shopping_picture2"];
    self.headImageView = [[UIImageView alloc] init];
    
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.image = imgPlaceholder;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 25;
    [self addSubview:_headImageView];
    
    //名字
    self.commentMemNameLab = [[UILabel alloc] init];
    _commentMemNameLab.font = [UIFont boldSystemFontOfSize:15];
    _commentMemNameLab.textColor = [UIColor blackColor];
    _commentMemNameLab.text=@"无名";
    [self addSubview:_commentMemNameLab];
    //发布内容
    _commentLab=[MYUI createLableFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"这个太给力" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:14]  numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:_commentLab];
    
    //时间细节
    _timeDetailLab=[MYUI createLableFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"2017-03-02- 05:47:26" textColor:[UIColor colorWithHexString:@"#727272"] font:[UIFont systemFontOfSize:10] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    _timeDetailLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.timeDetailLab];
    
    btn=[MYUI creatButtonFrame:CGRectZero backgroundColor:[UIColor whiteColor] setTitle:@"查看全部评论" setTitleColor:[UIColor orangeColor]];
    btn.layer.cornerRadius=5;
    btn.layer.masksToBounds=YES;
    [btn addTarget:self action:@selector(gocommitClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setBackgroundColor:[UIColor clearColor]];
    btn.layer.borderWidth=1;
    btn.layer.borderColor=[UIColor orangeColor].CGColor;
    [self addSubview:btn];
    
    
}
-(void)setupStoreCellWithModel:(FEStoreCommentModel *)model
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _commentMemNameLab.text=model.nickName;
    _commentLab.text=model.content;
    
    _timeDetailLab.text=@"";
}

-(void)gocommitClick
{
    if (self.block) {
        self.block();
        
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(25);
        make.height.width.equalTo(50);
        
    }];
    
    [_commentMemNameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.right).offset(10);
        make.top.equalTo(self.top).offset(25);
        make.right.equalTo(self.timeDetailLab.left).offset(-5);
        make.height.equalTo(15);
    }];
    
    [_commentLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.right).offset(10);
        make.top.equalTo(self.commentMemNameLab.bottom).offset(25);
        make.width.equalTo(MainW-65);
        make.height.equalTo(15);
    }];
    
    [_timeDetailLab makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-5);
        make.top.equalTo(self.commentMemNameLab);
        make.width.equalTo(MainW/2);
        make.height.equalTo(10);
    }];
    //CGRectMake(MainW/2-60, 10, 120, 30)
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.commentLab.bottom).offset(5);
        make.width.equalTo(120);
        make.height.equalTo(30);
    }];

    
    
    
}


@end
