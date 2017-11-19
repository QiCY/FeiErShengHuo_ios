//
//  FECommentCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/21.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FECommentCell.h"

@implementation FECommentCell

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
    
   
}

-(void)setupInerttingCellWithModel:(FEcommentModel *)model
{
    //[_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"pic"]];
    
    if ([model.avatar isEqualToString:@""]||model.avatar.length==0) {
        [_headImageView setImage:[UIImage imageNamed:@"pic"]];
        
    }
    _commentMemNameLab.text=model.nickName;
    _commentLab.text=model.fmContent;
    
    _timeDetailLab.text=model.commentTimeStr;
}


-(void)setupStoreCellWithModel:(FEStoreCommentModel *)model
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _commentMemNameLab.text=model.nickName;
    _commentLab.text=model.content;
    
    _timeDetailLab.text=@"";
}


-(void)setupNeighberCellWithModel:(FENeighberCommentModel *)model
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.headImgUrl]];
     _commentMemNameLab.text=model.nickName;
    _commentLab.text=model.content;
    _timeDetailLab.text=model.createTimeStr;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(5);
        make.height.width.equalTo(50);
       
    }];
    
    [_commentMemNameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.right).offset(10);
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(self.timeDetailLab.left).offset(-5);
        make.height.equalTo(15);
    }];
    
    [_commentLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.right).offset(10);
        make.top.equalTo(self.commentMemNameLab.bottom).offset(5);
        make.width.equalTo(MainW-65);
        make.height.equalTo(15);
    }];
    
    [_timeDetailLab makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(self.commentMemNameLab);
        make.width.equalTo(MainW/2);
        make.height.equalTo(10);
    }];
    

}
@end
