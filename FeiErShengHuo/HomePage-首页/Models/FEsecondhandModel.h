//
//  FEsecondhandModel.h
//  FeiErShengHuo
//
//  Created by zy on 2017/6/29.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEsecondhandModel : NSObject
@property(nonatomic,strong)NSString *quality;
@property(nonatomic,strong)NSString *storeImages;
@property(nonatomic,strong)NSString *mobile;


@property(nonatomic,strong)NSNumber *transaction;
@property(nonatomic,strong)NSNumber *secondHandId;
@property(nonatomic,strong)NSString *regionTitle;
@property(nonatomic,strong)NSNumber *sellPrice;
@property(nonatomic,strong)NSNumber *regionId;
@property(nonatomic,strong)NSNumber *userId;


@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *goodsContent;
@property(nonatomic,strong)NSNumber *rankId;
@property(nonatomic,strong)NSString *publishDateLineStr;
@property(nonatomic,strong)NSString *transactionStr;


@property(nonatomic,strong)NSNumber *orginPrice;

@property(nonatomic,strong)NSMutableArray *pictureMap;//图片


@property(nonatomic,strong)NSNumber *publishDateLine;

@end

/*

"quality" = 还好好的的,
"storeImages" = 1498699221124.jpg@1498699221452.jpg,
"mobile" = 85764676464,
"transaction" = 1,
"secondHandId" = 21,
"regionTitle" = 丁香花园,
"sellPrice" = 274498800,
"regionId" = 0,
"userId" = 0,
"avatar" = http://192.168.1.133:8020/pic/headIcon/149681786041013338062713.jpg,
"goodsContent" = 到底,
"rankId" = 1,
"publishDateLineStr" = 2017-06-29 09:20:20,
"transactionStr" = 自取,
"orginPrice" = 5564400,
"pictureMap" = 2 (
                  {
                      "url" = http://192.168.1.133:8020/pic/snsImage/1498699221124.jpg,
                  },
                  {
                      "url" = http://192.168.1.133:8020/pic/snsImage/1498699221452.jpg,
                  }, 
                  ),
"publishDateLine" = 1498699220,


*/
