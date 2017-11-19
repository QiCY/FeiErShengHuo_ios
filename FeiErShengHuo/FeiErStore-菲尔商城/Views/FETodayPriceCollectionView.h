//
//  FETodayPriceCollectionView.h
//  QTTableCollectionView
//
//  Created by Tang Qi on 18/02/2017.
//  Copyright © 2017 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FETodayPriceCollectionView : UICollectionView

/// indexPath 用于查询相应的 Model，并填充至 Cell。
@property (nonatomic, strong) NSIndexPath *indexPath;


@end
