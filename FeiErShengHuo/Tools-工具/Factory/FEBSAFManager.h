//
//  BSAFManager.h
//  
//
//  Created by lc on 2017/3/15.
//  Copyright © 2017年 lc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

typedef enum{
    GET,
    POST,
    PUT,
    DELETE,
    HEAD,
}HTTPMethod;
typedef void (^requestSuccessBlock)(NSDictionary *dic);

typedef void(^netBlock)(NSString * I);

//不成功的回调的msg
typedef void (^requestFialedBlock)(NSString *msg);
@interface FEBSAFManager : AFHTTPSessionManager

@property(nonatomic,strong)netBlock  netblock;

-(void)requestHttpWithMethod:(HTTPMethod)method withPath:(NSString*)path withDictionary:(NSDictionary*)dictionary withSuccessBlock:(requestSuccessBlock)success;



//需要做操作的方法
-(void)doOperationRequestHttpWithMethod:(HTTPMethod)method withPath:(NSString*)path withDictionary:(NSDictionary*)dictionary withSuccessBlock:(requestSuccessBlock)success withfialedBlock:(requestFialedBlock)Fialed;
+ (instancetype)sharedManager;

+(instancetype) sharedManagerwith:(NSString *)baseUrl;


@end
