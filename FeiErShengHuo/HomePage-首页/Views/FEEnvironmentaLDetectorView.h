//
//  FEEnvironmentaLDetectorView.h
//  FeiErShengHuo
//
//  Created by TAKUMI on 2017/7/6.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FEEnvironmentaLDetectorView : UIView

- (void)refreshViewWithTemperature:(NSString *)temperature humidity:(NSString *)humidity light:(NSString *)light air:(NSString *)air noisy:(NSString *)noisy;

@end
