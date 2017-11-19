//
//  FEIntertingDetailModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/11.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEIntertingDetailModel : NSObject
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *topicContent;
@property(nonatomic,strong)NSString *topicTheme;
@property(nonatomic,strong)NSNumber *themeId;
@property(nonatomic,strong)NSString *createTimeStr;
@property(nonatomic,strong)NSString *topicPic;
@property(nonatomic,strong)NSNumber *topicId;


@end

/*

"author" = 菲尔生活,
"topicContent" = <null>,
"themeId" = 1,
"topicTheme" = 菲尔生活 启示录,
"createTimeStr" = 2015-12-07 20:37:29,
"topicPic" =
 
 */
