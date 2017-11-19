//
//  FEFourbtnView.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEFourbtnView.h"

@implementation FEFourbtnView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
    
}

-(void)creatUI
{
    //collectionView
    UICollectionViewFlowLayout *clay = [[UICollectionViewFlowLayout alloc] init];
    [clay setMinimumLineSpacing:6];
    CGFloat width=(MainW-208/3*4-8*2)/3;
    [clay setMinimumInteritemSpacing:width];
    clay.itemSize=CGSizeMake(208/3, 208/3+20);
    clay.sectionInset = UIEdgeInsetsMake(8,8, 8,8);
    _collections=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:clay];
    _collections.delegate = self;
    _collections.dataSource = self;
    _collections.scrollsToTop=NO;
    _collections.scrollEnabled=NO;
    _collections.backgroundColor = [UIColor clearColor];
    [_collections registerClass:NSClassFromString(@"FEFourbtnCollectionViewCell") forCellWithReuseIdentifier:@"cellectionCell"];
    [self addSubview:_collections];

}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FEFourbtnCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellectionCell" forIndexPath:indexPath];
    cell.imageView.image=[UIImage imageNamed:_fourbtnimageArray[indexPath.item]];
    cell.btnnameLab.text=_fourbtnnameArray[indexPath.item];
    return cell;
}

#pragma mark - - - UICollectionView 的 delegate 方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegete && [_delegete respondsToSelector:@selector(choseCollectionBtnView:didSelectedItemAtIndex:)])
    {
        [self.delegete choseCollectionBtnView:self didSelectedItemAtIndex:indexPath.item];
    }
}


@end
