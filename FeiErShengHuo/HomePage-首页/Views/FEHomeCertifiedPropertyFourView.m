//
//  FEHomeCertifiedPropertyFourView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEHomeCertifiedPropertyFourView.h"
#import "FEHomeCelletionCell.h"

@implementation FEHomeCertifiedPropertyFourView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
        
        
    }
    return self;
    
}
-(void) creatUI
{
    
    self.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    
    _BackGroundBnt=[[UIButton alloc]init];
    [_BackGroundBnt setBackgroundColor:[UIColor clearColor]];
    _BackGroundBnt.frame=CGRectMake(0, 0, MainW, MainH);
    [_BackGroundBnt addTarget:self action:@selector(dissmissClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.BackGroundBnt];
    
    _fourView=[[UIView alloc]init];
    _fourView.backgroundColor=[UIColor clearColor];
    _fourView.frame=CGRectMake(MainW/2-125, MainH/2-250, 250, 380) ;
    _fourView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.9];
    _fourView.layer.cornerRadius = 15;
    _fourView.layer.masksToBounds = YES;
    
    
    [self addSubview:_fourView];
    
    UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat width=250-40*2-60*2;
    CGFloat height=380-40*2-90*3;
    [clay setMinimumLineSpacing:height];
    [clay setMinimumInteritemSpacing:width];
    clay.itemSize=CGSizeMake(60,90);
    clay.sectionInset = UIEdgeInsetsMake(25,40,40, 40);
    UICollectionView *collections=[[UICollectionView alloc]initWithFrame:CGRectMake(MainW/2-125, MainH/2-250, 250, 400) collectionViewLayout:clay];
    collections.delegate = self;
    collections.dataSource = self;
    collections.scrollsToTop=NO;
    collections.scrollEnabled=NO;
    
    collections.backgroundColor = [UIColor clearColor];
    [collections registerClass:NSClassFromString(@"FEHomeCelletionCell") forCellWithReuseIdentifier:@"cellectionCell"];
    [self addSubview:collections];
    
    
    
    self.lab =[[UILabel alloc] initWithFrame:CGRectMake(94, 24, 20, 20)];
    
    self.lab.backgroundColor = [UIColor redColor];
    self.lab.layer.cornerRadius = 10;
    self.lab.layer.masksToBounds = YES;
   
    self.lab.textAlignment = NSTextAlignmentCenter;
    [collections addSubview:self.lab];
   
}

-(void)setIndexC:(int)indexC{
    
    if (indexC == 0)
    {
        self.lab.hidden = YES;
        self.lab.textColor=[UIColor whiteColor];
        self.lab.text=[NSString stringWithFormat:@"%d",indexC];
        
        
    }
    else
    {
        self.lab.hidden = NO;
         self.lab.textColor=[UIColor whiteColor];
        self.lab.text=[NSString stringWithFormat:@"%d",indexC];
        
    }

}

-(void)dissmissClick{
    
    
 
    
    [UIView animateWithDuration:0.2 animations:^{
        self.fourView.transform=CGAffineTransformMakeScale(0.01, 0.01);
        self.fourView.alpha=0;
        self.alpha=0;

    } completion:^(BOOL finished) {
        
        
    }];
    
    
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FEHomeCelletionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellectionCell" forIndexPath:indexPath];
    
    

    NSArray *titleArray=@[@"小区公告",@"投诉建议",@"在线报修",@"物业缴费",@"服务热线",@"调查问卷"];
    NSArray *imageArray=@[@"icon_2notice1",@"icon_advice",@"icon_repairs",@"icon_pay",@"icon_all_telephone",@"icon_all_questionnaire"];
    
    
    
    cell.headView.image=[UIImage imageNamed:imageArray[indexPath.item]];
    //NSArray *nameArray=@[@"物业服务",@"智能家居",@"智能开门",@"智慧停车",@"充值中心",@"违章服务",@"生活查询",@"全部"];
    cell.btnnameLab.text=titleArray[indexPath.item];
    return cell;
}

#pragma mark - - - UICollectionView 的 delegate 方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegete && [_delegete respondsToSelector:@selector(choseFourCollectionBtnView:didSelectedItemAtIndex:)])
    {
        [_delegete choseFourCollectionBtnView:self didSelectedItemAtIndex:indexPath.item];
    }
}


@end
