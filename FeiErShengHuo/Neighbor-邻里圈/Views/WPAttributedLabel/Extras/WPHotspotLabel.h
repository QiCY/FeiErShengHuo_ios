//
//  WPHotspotLabel.h
//  WPAttributedMarkupDemo
//
//  Created by Nigel Grange on 20/10/2014.
//  Copyright (c) 2014 Nigel Grange. All rights reserved.
//

#import "WPTappableLabel.h"

@class WPHotspotLabel;
@protocol WPHotspotLabelDelegate <NSObject>

-(void)deleteCurrentLabel:(WPHotspotLabel *)curLbl;

@end

@interface WPHotspotLabel : WPTappableLabel

@property (nonatomic, assign) id<WPHotspotLabelDelegate> delegate;

@end

