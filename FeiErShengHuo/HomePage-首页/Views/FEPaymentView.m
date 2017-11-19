//
//  FEPaymentView.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/7/26.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEPaymentView.h"
#import "FEHomeCelletionCell.h"

@implementation FEPaymentView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
    
    }
    return self;
    
}

/*
-(void) creatUI
{
    self.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    _BackGroundBnt=[[UIButton alloc]init];
    [_BackGroundBnt setBackgroundColor:[UIColor clearColor]];
    _BackGroundBnt.frame=CGRectMake(0, 0, MainW, MainH);
    
    [self addSubview:self.BackGroundBnt];
    
    _fourView=[[UIView alloc]init];
    _fourView.backgroundColor=[UIColor clearColor];
    _fourView.frame=CGRectMake(MainW/2-150, MainH/2-250, 300, 300);
    _fourView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.9];
    _fourView.layer.cornerRadius = 15;
    _fourView.layer.masksToBounds = YES;
    
    
    [self addSubview:_fourView];
    
    UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat width=300-40*2-60*2;
    CGFloat height=300-40*2-90*2;
    [clay setMinimumLineSpacing:height];
    [clay setMinimumInteritemSpacing:width];
    clay.itemSize=CGSizeMake(60,90);
    clay.sectionInset = UIEdgeInsetsMake(40,40,40, 40);
    UICollectionView *collections=[[UICollectionView alloc]initWithFrame:CGRectMake(MainW/2-150, MainH/2-250, 300, 300) collectionViewLayout:clay];
    collections.delegate = self;
    collections.dataSource = self;
    collections.scrollsToTop=NO;
    collections.scrollEnabled=NO;
    
    collections.backgroundColor = [UIColor clearColor];
    [collections registerClass:NSClassFromString(@"FEHomeCelletionCell") forCellWithReuseIdentifier:@"cellectionCell"];
    [self addSubview:collections];
}

*/

-(void) creatUI
{
    self.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    _BackGroundBnt=[[UIButton alloc]init];
    [_BackGroundBnt setBackgroundColor:[UIColor clearColor]];
    _BackGroundBnt.frame=CGRectMake(0, 0, MainW, MainH);
    
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
    
    
    
    NSArray *titleArray=@[@"水费",@"电费",@"天燃气",@"话费充值",@"流量充值",@"油卡充值"];
    NSArray *imageArray=@[@"icon_all_wrate",@"icon_all_prate",@"icon_all_Gasfee",@"icon_all_recharge",@"icon_all_florecharge",@"icon_all_oilrecharge"];
    
    
    
    cell.headView.image=[UIImage imageNamed:imageArray[indexPath.item]];
  
    cell.btnnameLab.text=titleArray[indexPath.item];
    return cell;
}

#pragma mark - - - UICollectionView 的 delegate 方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegete && [_delegete respondsToSelector:@selector(choseFEPaymentView:didSelectedItemAtIndex:)])
    {
        [_delegete choseFEPaymentView:self didSelectedItemAtIndex:indexPath.item];
        
    }
}



@end
