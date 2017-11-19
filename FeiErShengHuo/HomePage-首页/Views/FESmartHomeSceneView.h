//
//  FESmartHomeSceneView.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/18.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneModel.h"

@interface FESmartHomeSceneView : UIView

@property (nonatomic,copy) void (^didLongClickScene) (NSInteger index);
@property (nonatomic,copy) void (^didClickScene) (NSInteger index);

- (void)addScene:(SceneModel *)scene;

- (void)addScenes:(NSArray <SceneModel *>*)scenes;

@end
