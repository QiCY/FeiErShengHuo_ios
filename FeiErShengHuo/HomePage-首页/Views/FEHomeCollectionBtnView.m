//
//  FEHomeCollectionBtnView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEHomeCollectionBtnView.h"

@implementation FEHomeCollectionBtnView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
        [clay setMinimumLineSpacing:15];
        CGFloat width=(MainW-30*2-60*4)/3;
        [clay setMinimumInteritemSpacing:width];
        clay.itemSize=CGSizeMake(60,90);
        clay.sectionInset = UIEdgeInsetsMake(10,30,10, 30);
        UICollectionView *collections=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainW,90*2+15*3) collectionViewLayout:clay];
        collections.delegate = self;
        collections.dataSource = self;
        collections.scrollsToTop=NO;
        collections.scrollEnabled=NO;
        
        collections.backgroundColor = [UIColor clearColor];
        [collections registerClass:NSClassFromString(@"FEHomeCelletionCell") forCellWithReuseIdentifier:@"cellectionCell"];
        [self addSubview:collections];
        self.tempArray=[NSArray array];

    }
    return self;
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
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
    
    cell.headView.image=[UIImage imageNamed:_tempArray[indexPath.item]];
    NSArray *nameArray=@[@"物业服务",@"智能家居",@"智能开门",@"共享停车",@"生活缴费",@"违章服务",@"综合查询",@"全部"];
    cell.btnnameLab.text=nameArray[indexPath.item];
    return cell;
}

#pragma mark - - - UICollectionView 的 delegate 方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegate && [_delegate respondsToSelector:@selector(choseCollectionBtnView:didSelectedItemAtIndex:)])
    {
        [self.delegate choseCollectionBtnView:self didSelectedItemAtIndex:indexPath.item];
    }
}
@end
