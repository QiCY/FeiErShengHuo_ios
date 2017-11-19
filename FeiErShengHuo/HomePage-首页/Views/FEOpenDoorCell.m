//
//  FEOpenDoorCell.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEOpenDoorCell.h"

@implementation FEOpenDoorCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    return self;
    
}


-(void)creatUI{
    
    UIView * brownViewBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainW, 77/3+15)];
    brownViewBG.backgroundColor=Colorgrayall239;
    [self addSubview:brownViewBG];
    //
    UIView * brownView=[[UIView alloc]initWithFrame:CGRectMake(11, 10, 64/3, 77/3)];
    brownView.backgroundColor=RGB(109, 78, 66);
    [self addSubview:brownView];
    
    self.doorNameLab=[MYUI createLableFrame:CGRectMake(129/3, 10, MainW-129/3-10, 16) backgroundColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor]  font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    
    [self addSubview:self.doorNameLab];
    
    
    
    _limitTimeLab=[MYUI createLableFrame:CGRectMake(54/3, CGRectGetMaxY(brownViewBG.frame)+8, MainW-100, 20) backgroundColor:[UIColor whiteColor] text:@"过期时间:永不过期" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] numberOfLines:0 adjustsFontSizeToFitWidth:NO];
    [self addSubview:self.limitTimeLab];
    
    _openBtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusNormal];
    
    
    [_openBtn addTarget:self action:@selector(openClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *image=[UIImage imageNamed:@"Button_open_door"];
    //_openBtn.frame=CGRectMake(10, CGRectGetMaxY(brownView.frame)+45, image.size.width, image.size.height);
    [_openBtn setBackgroundImage:image forState:0];
    [self addSubview:self.openBtn];
    
       
    _sharedBtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusNormal];
     [_sharedBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image2=[UIImage imageNamed:@"Button_share"];
    //_sharedBtn.frame=CGRectMake(MainW/2, CGRectGetMaxY(brownView.frame)+45, image2.size.width, image2.size.height);
       [_sharedBtn setBackgroundImage:image2 forState:0];
    [self addSubview:self.sharedBtn];
    
    
    //两个 按钮
    UIButton *resetNameBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [resetNameBtn setImage:[UIImage imageNamed:@"icon_modify"] forState:0];
    resetNameBtn.frame=CGRectMake(MainW-20-80, CGRectGetMinY(brownViewBG.frame)+5, 25, 25) ;
    [resetNameBtn addTarget:self action:@selector(resetnameClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resetNameBtn];
    
    
    UIButton *deletebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [deletebtn setImage:[UIImage imageNamed:@"icon_trash"] forState:0];
    deletebtn.frame=CGRectMake(MainW-20-45, CGRectGetMinY(brownViewBG.frame)+5, 25, 25) ;
    [deletebtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:deletebtn];
    
    //
    
    
    [_openBtn makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(image.size.width);
        make.height.equalTo(image.size.height);
        make.centerX.equalTo(self.centerX).offset(-(MainW-20)/2/2);
        make.top.equalTo(_limitTimeLab.bottom).offset(8);
        
    }];
    
    [_sharedBtn makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(image2.size.width);
        make.height.equalTo(image2.size.height);
        make.centerX.equalTo(self.centerX).offset((MainW-20)/2/2);
        make.top.equalTo(_limitTimeLab.bottom).offset(8);
        
    }];

 
}

-(void)openClick:(UIButton *)btn
{
    
    
    if (self.doorblock) {
        self.doorblock(self);
        
    }
    
}

-(void)shareClick:(UIButton *)btn
{
    if (self.shareblock) {
        self.shareblock(self);
        
    }
}

-(void)resetnameClick:(UIButton *)btn
{
    
    
    if (self.renameblock) {
        self.renameblock(self);
        
    }
}

-(void)deleteClick:(UIButton *)btn
{
    btn.tag=self.tag;
    
    if (self.deleteblock) {
        self.deleteblock(self);
        
    }
}

-(void)setModel:(FEOpenDoorModel *)model
{
    _limitTimeLab.text=[NSString stringWithFormat:@"过期时间:%@",model.validity];
    
    if ([model.alias isEqualToString:@""]||model.alias.length==0) {
         _doorNameLab.text=model.doorName;
    }else{
        _doorNameLab.text=model.alias;
    }
   
    if ([model.pid containsString:@"BLZXC"]||[model.pid containsString:@"MDC"]) {
        
        _sharedBtn.hidden=NO;
    }
    else
    {
        _sharedBtn.hidden=YES;
    }
}

@end
