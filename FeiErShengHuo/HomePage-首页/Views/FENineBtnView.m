//
//  FENineBtnView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/6/13.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FENineBtnView.h"
#import "FEHomeCelletionCell.h"

@implementation FENineBtnView

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
    self.BackGroundBtn=[[UIButton alloc]init];
    [self.BackGroundBtn setBackgroundColor:[UIColor clearColor]];
    self.BackGroundBtn.frame=CGRectMake(0, 0, MainW, MainH);
    
    [self addSubview:self.BackGroundBtn];
    
    _fourView=[[UIView alloc]init];
    
    
    CGFloat width=(MainW-30-20*2-60*3)/2;
    CGFloat height=(MainW-30-20*2-90*3)/2;
    CGFloat HH=0;
    
    
    if (height>0) {
        height=(MainW-30-20*2-90*3)/2;
        HH=MainW-30;
    }
    if (height<0) {
        height=10;
        HH=10*2+90*3+40;
        
    }

    _fourView.frame=CGRectMake(15, MainH/2-(MainW-30)/2-40, MainW-30, HH);
    _fourView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.9];
    _fourView.layer.cornerRadius = 15;
    _fourView.layer.masksToBounds = YES;
    
    
    [self addSubview:_fourView];
    
    UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
    
    [clay setMinimumLineSpacing:height];
    [clay setMinimumInteritemSpacing:width];
    clay.itemSize=CGSizeMake(60,90);
    clay.sectionInset = UIEdgeInsetsMake(20,20,20, 20);
    UICollectionView *collections=[[UICollectionView alloc]initWithFrame:CGRectMake(15, MainH/2-(MainW-30)/2-40, MainW-30, HH) collectionViewLayout:clay];
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
    return 9;
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
    NSArray *titleArray=@[@"共享停车",@"违章查询",@"违章代缴",@"问卷调查",@"车票查询",@"航班查询",@"服务热线",@"流量充值", @"话费充值"];
    NSArray *imageArray=@[@"icon_all_parking",@"icon_all_vioinquiry",@"icon_all_lllpayment",@"icon_all_questionnaire",@"icon_all_ticinquiry",@"icon_all_fliinquiries",@"icon_all_telephone",@"icon_all_florecharge",@"icon_all_recharge"];
    
    
    
    cell.headView.image=[UIImage imageNamed:imageArray[indexPath.item]];
    //NSArray *nameArray=@[@"物业服务",@"智能家居",@"智能开门",@"智慧停车",@"充值中心",@"违章服务",@"生活查询",@"全部"];
    cell.btnnameLab.text=titleArray[indexPath.item];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegete&&[_delegete respondsToSelector:@selector(choseNineCollectionBtnView:didSelectedItemAtIndex:)]) {
        [_delegete choseNineCollectionBtnView:self didSelectedItemAtIndex:indexPath.item];
        
    }
}

@end
