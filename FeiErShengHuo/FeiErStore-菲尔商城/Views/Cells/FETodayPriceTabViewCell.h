//
//  FETodayPriceTabViewCell.h
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FETodayPriceCollectionView.h"

static NSString *const ExploreCollectionViewCellID = @"ExploreCollectionViewCellID";

@interface FETodayPriceTabViewCell : UITableViewCell

/// UITableViewCell 中嵌套 CollectionView。
@property (nonatomic, strong) FETodayPriceCollectionView *collectionView;

/// 设置 CollectionView 的 DataSource 与 Delegate。
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
