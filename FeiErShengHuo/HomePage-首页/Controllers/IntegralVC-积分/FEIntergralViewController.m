//
//  FEIntergralViewController.m
//  FeiErShengHuo
//
//  Created by zy on 2017/4/27.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEIntergralViewController.h"
#import "FEIntergralCollectionViewCell.h"
#import "MyCollectionReusableView.h"
#import "FEIntergralRecordViewController.h"
#import "FEIntegralModel.h"
#import "FEIntergralDetailViewController.h"
#import "FEBreakRulesViewController.h"


@interface FEIntergralViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat width;
    CGFloat HW;
    
 }
@property(nonatomic,strong)UICollectionView *IntergralCollectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)MyCollectionReusableView *headerView;

@end

@implementation FEIntergralViewController
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: YES];
    
    [self doRRequest];
    
    
    FELoginInfo  *info=[LoginUtil getInfoFromLocal];
    [_headerView.intergralCoutBtn setTitle:[NSString stringWithFormat:@"积分值:%@",info.integral] forState:UIControlStateNormal];
    
}

-(void)initView
{
    _imageArray=[[NSMutableArray alloc]init];
    
    width=(MainW-1)/2;
    self.title=@"积分商城";
    _IntergralCollectionView=[UICollectionView collectionViewWithFrame:CGRectMake(0, 0, MainW, MainH-64) setMinLineSpacing:1.5 setMiniInteritemSpacing:1 setItemSize:CGSizeMake(width, width+20) setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    _IntergralCollectionView.delegate=self;
    _IntergralCollectionView.dataSource=self;
    _IntergralCollectionView.scrollsToTop=YES;
    _IntergralCollectionView.scrollEnabled=YES;
    
    [_IntergralCollectionView registerClass:[FEIntergralCollectionViewCell class] forCellWithReuseIdentifier:@"FEIntergralCollectionViewCell"];
    //注册分区头
    [_IntergralCollectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionReusableView"];

    [self.view addSubview:self.IntergralCollectionView];
        
}
-(void)doRRequest
{
    NSString *str=@"020appd/integral/showIntegralMall";
    
    [RYLoadingView showRequestLoadingView];
    [[FEBSAFManager sharedManager]doOperationRequestHttpWithMethod:POST withPath:str withDictionary:nil withSuccessBlock:^(NSDictionary *dic) {
        NSLog(@" 积分列表-----%@",dic);
        NSArray *array=[FEIntegralModel mj_objectArrayWithKeyValuesArray:dic[@"integralMall"]];
        
        self.dataArray=[NSMutableArray arrayWithArray:array];
        NSMutableArray *imageA=[[NSMutableArray alloc]init];
        
        NSArray *imageDicArray=dic[@"xCommunitySlidePublics"];
        for (NSDictionary *imageDic in imageDicArray) {
            NSString *url=imageDic[@"slideUrl"];
            [imageA addObject:url];
        }
        
        
        if (array.count > 0) {
            [RYLoadingView hideNoResultView:self.view];
            
        }else{
            
            [RYLoadingView showNoResultView:self.IntergralCollectionView];
        }
        
        _imageArray=[imageA copy];
        NSString *url=_imageArray[0];
        //处理网络图片大小
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"w = %f,h = %f" ,image.size.width,image.size.height);
        NSLog(@"宽高比---%f",image.size.height/image.size.width);
        HW=image.size.height/image.size.width;
        [self.IntergralCollectionView reloadData];
    
    } withfialedBlock:^(NSString *msg) {
        
    }];
}

#pragma -----九宫格代理------

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0){
        UICollectionReusableView *reusableview = nil;
        if (kind == UICollectionElementKindSectionHeader)
        {
            //重用头
            _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionReusableView" forIndexPath:indexPath];
            //NSDictionary *tpDic = [_dataArray objectAtIndex:indexPath.section];
            _headerView.title =@"大家都在兑";
            _headerView.imagesURLStrings=_imageArray;
            _headerView.HH=HW;
            reusableview = _headerView;
            WeakSelf;
            _headerView.buttonAction = ^(UIButton *sender){
              
                FEIntergralRecordViewController *vc=[[FEIntergralRecordViewController alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
            _headerView.ruleblock = ^{
               
                FEBreakRulesViewController *breakVC2=[[FEBreakRulesViewController alloc]init];
                breakVC2.title=@"积分规则";
                breakVC2.urlStr=@"http://admin.feierlife.com/Home/InterRule";
                [weakSelf.navigationController pushViewController:breakVC2 animated:YES];

                
            };
            
        }
        return reusableview;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(MainW, MainW *0.5+130);
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FEIntergralCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FEIntergralCollectionViewCell" forIndexPath:indexPath];
    
    
    cell.backgroundColor=[UIColor whiteColor];
    FEIntegralModel *model=_dataArray[indexPath.item];
    [cell setupCellWithModel:model];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    
    FEIntergralDetailViewController *VC=[[FEIntergralDetailViewController alloc]init];
    
    FEIntegralModel *model=_dataArray[indexPath.item];
    VC.integralId=model.integralId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)doOpeartion
{
    
}
@end
