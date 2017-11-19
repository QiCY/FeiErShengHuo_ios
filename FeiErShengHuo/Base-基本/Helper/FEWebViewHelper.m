//
//  FEWebViewHelper.m
//  FeiErShengHuo
//
//  Created by lzy on 2017/8/23.
//  Copyright © 2017年 xjbyte. All rights reserved.
//

#import "FEWebViewHelper.h"

@implementation FEWebViewHelper

+ (void)webViewSetTiele:(NSString *)title
                 andUrl:(NSString *)url
            andSelfPush:(UIViewController *)sSelf {
  FEBreakRulesViewController *breakVC3 =
      [[FEBreakRulesViewController alloc] init];
  breakVC3.title = title; //@"综合查询";
  breakVC3.urlStr = url;  //@"http://admin.feierlife.com:8080/Home/Tickets";
  [sSelf.navigationController pushViewController:breakVC3 animated:YES];
}

@end
