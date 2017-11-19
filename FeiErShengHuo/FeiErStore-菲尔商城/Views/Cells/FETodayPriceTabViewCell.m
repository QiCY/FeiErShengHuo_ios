//
//  FETodayPriceTabViewCell.m
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import "FETodayPriceTabViewCell.h"
#import "FETodayPriceCollectionViewCell.h"


@implementation FETodayPriceTabViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;

    // 使用 UICollectionViewFlowLayout 进行布局。
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[FETodayPriceCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    // 注册 Explore Cell
    [self.collectionView registerClass:[FETodayPriceCollectionViewCell class] forCellWithReuseIdentifier:ExploreCollectionViewCellID];
 
   
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    self.collectionView.delegate=self;
    
    self.backgroundColor= [UIColor whiteColor];

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath {
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    [self.collectionView reloadData];
}



@end
