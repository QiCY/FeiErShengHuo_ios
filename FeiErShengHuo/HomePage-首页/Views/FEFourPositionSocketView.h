//
//  FEFourPositionSocketView.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FEFourPositionSocketView : UIView

@property (nonatomic,copy) void (^didClickSocketButton) (NSInteger index, BOOL targetOn);

@property (nonatomic,assign) BOOL socket1Selected;
@property (nonatomic,assign) BOOL socket2Selected;
@property (nonatomic,assign) BOOL socket3Selected;
@property (nonatomic,assign) BOOL socket4Selected;

@property (nonatomic,assign) BOOL socket1Enable;
@property (nonatomic,assign) BOOL socket2Enable;
@property (nonatomic,assign) BOOL socket3Enable;
@property (nonatomic,assign) BOOL socket4Enable;

- (void)refreshStatusWithIndex:(NSInteger)index targetOn:(BOOL)targetOn;

@end
