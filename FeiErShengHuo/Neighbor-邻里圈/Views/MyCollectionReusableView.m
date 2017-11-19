//
//  MyCollectionReusableView.m
//  DemoOfUICollectionView
//
//  Created by 蔡成汉 on 16/8/9.
//  Copyright © 2016年 蔡成汉. All rights reserved.
//

#import "MyCollectionReusableView.h"



@interface MyCollectionReusableView ()<SDCycleScrollViewDelegate>

@end

@implementation MyCollectionReusableView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialView];
    }
    return self;
}

-(void)initialView
{
     _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
   
    
    _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _cycleScrollView2.autoScrollTimeInterval=5;
    [self addSubview:_cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView2.imageURLStringsGroup = self.imagesURLStrings;
        ;
    });
    
    //双按钮
    
//    _imageView=[[UIImageView alloc]init];
//    _imageView.image=[UIImage imageNamed:@"integral_big-1"];
//    [self addSubview:_imageView];
    _btnBgView=[[UIView alloc]init];
    _btnBgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_btnBgView];
    
    
    _intergralCoutBtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusTop];
    [_intergralCoutBtn setImage:[UIImage imageNamed:@"icon_integral1"] forState:0];
    // 从本地得到积分值
    
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    NSNumber *intergral=info.integral;
    
    [_intergralCoutBtn setTitle:[NSString stringWithFormat:@"积分值:%@",intergral] forState:UIControlStateNormal];
    _intergralCoutBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_intergralCoutBtn setTitleColor:[UIColor blackColor] forState:0];
    [self addSubview:_intergralCoutBtn];
    
    _recordBtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusTop];
    [_recordBtn setImage:[UIImage imageNamed:@"icon_record1"] forState:0];
    [_recordBtn setTitle:@"兑换记录" forState:0];
    [_recordBtn addTarget:self action:@selector(recodClick:) forControlEvents:UIControlEventTouchUpInside];
    _recordBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_recordBtn setTitleColor:[UIColor blackColor] forState:0];
    [self addSubview:_recordBtn];
    
    _ruleBtn=[[FL_Button fl_shareButton]initWithAlignmentStatus:FLAlignmentStatusTop];
    [_ruleBtn setImage:[UIImage imageNamed:@"icon_rules1"] forState:0];
    [_ruleBtn setTitle:@"积分规则" forState:0];
    [_ruleBtn addTarget:self action:@selector(ruleClick) forControlEvents:UIControlEventTouchUpInside];
    _ruleBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_ruleBtn setTitleColor:[UIColor blackColor] forState:0];
    [self addSubview:_ruleBtn];

    
    
    _view=[[UIView alloc]init];
    _view.backgroundColor=[UIColor whiteColor];
        [self addSubview:_view];
    // 标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_view addSubview:_titleLabel];
    
}

- (void)recodClick:(UIButton *)button{
    // 判断下这个block在控制其中有没有被实现
    if (self.buttonAction) {
        // 调用block传入参数
        self.buttonAction(button);
    }
}

-(void)ruleClick
{
    if (self.ruleblock) {
        self.ruleblock();
        
    }
}
/**
 *  set方法 -- 数据分发
 *
 *  @param title 标题
 */
-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

/**
 *  layoutSubviews
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    //CGRectMake(0, 0, MainW, MainW*_HH);
    _cycleScrollView2.frame=CGRectMake(0, 0, MainW, MainW*0.5);
    
    _btnBgView.frame=CGRectMake(0, CGRectGetMaxY(self.cycleScrollView2.frame), MainW, 80);
    
    _view.frame=CGRectMake(0, CGRectGetMaxY(_btnBgView.frame)+8, MainW, 40);
    _titleLabel.frame = CGRectMake(10,5, self.bounds.size.width - 40.0,35);
    
    _intergralCoutBtn.frame=CGRectMake(0, CGRectGetMaxY(self.cycleScrollView2.frame), MainW/3-1, _btnBgView.frame.size.height);
    _recordBtn.frame=CGRectMake(MainW/3,CGRectGetMaxY(self.cycleScrollView2.frame), MainW/3, _btnBgView.frame.size.height);
    _ruleBtn.frame=CGRectMake(MainW/3*2+1,CGRectGetMaxY(self.cycleScrollView2.frame), MainW/3, _btnBgView.frame.size.height);
}

@end
