
//
//  BSAFManager.m
//
//
//  Created by lc on 2017/3/15.
//  Copyright © 2017年 lc. All rights reserved.
//

#import "FEBSAFManager.h"
#import "FELoginInfo.h"

@implementation FEBSAFManager

-(instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self) {
        
    
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 10;
        //self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        //[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer =[AFJSONRequestSerializer serializer];
        
        
    }
    return self;
}

+ (instancetype)sharedManager {
    static FEBSAFManager *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    });
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.userId] forHTTPHeaderField:@"master"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.villageId] forHTTPHeaderField:@"regionid"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.mobile] forHTTPHeaderField:@"mobile"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.district] forHTTPHeaderField:@"district"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.integral] forHTTPHeaderField:@"integral"];
    
    return manager;
}


+(instancetype) sharedManagerwith:(NSString *)baseUrl {
    FEBSAFManager *manager=[[self alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
    FELoginInfo *info=[LoginUtil getInfoFromLocal];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.userId] forHTTPHeaderField:@"master"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.villageId] forHTTPHeaderField:@"regionid"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.mobile] forHTTPHeaderField:@"mobile"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.district] forHTTPHeaderField:@"district"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",info.integral] forHTTPHeaderField:@"integral"];
    
    return manager;
    
    

}


//
//#pragma mark -- 弹出提示框
//-(void)showMessage:(NSString *)info{
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//}


-(void)requestHttpWithMethod:(HTTPMethod)method withPath:(NSString *)path withDictionary:(NSDictionary *)dictionary withSuccessBlock:(requestSuccessBlock)success
{


    //新建loadingView,展示loadingView.
    switch (method) {
        case GET:{

            [self GET:path parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                NSLog(@"服务器返回----%@",responseObject);


                    success(responseObject);
                    NSLog(@"success_Block----%@",responseObject);

                               //
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

               
                
                //统一做处理,关闭loadingview
                [RYLoadingView hideRequestLoadingView];
                
                [FENavTool showAlertViewByAlertMsg:@"网络错误" andType:@"提示"];

                
            }];

        }
            break;

        case POST:{

            [self POST:path parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               NSLog(@"服务器返回----%@",responseObject);
                 [RYLoadingView hideRequestLoadingView];

                    success(responseObject);
                      NSLog(@"success_Block----%@",responseObject);
                //

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //统一做处理,关闭loadingview
                
               
                [RYLoadingView hideRequestLoadingView];
                
              //  [FENavTool showAlertViewByAlertMsg:@"网络错误" andType:@"提示"];
            }];
        }
            break;

        case PUT:{


            [self PUT:path parameters:dictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"服务器返回----%@",responseObject);


               
                    success(responseObject);
                    NSLog(@"success_Block----%@",responseObject);

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //统一做处理,关闭loadingview
                NSLog(@"请求失败—————%@",error);
                
                [RYLoadingView hideRequestLoadingView];
                
                [FENavTool showAlertViewByAlertMsg:@"网络错误" andType:@"提示"];


            }];

        }
            break;


        default:
            break;
    }

}


//做操作的
-(void)doOperationRequestHttpWithMethod:(HTTPMethod)method withPath:(NSString *)path withDictionary:(NSDictionary *)dictionary withSuccessBlock:(requestSuccessBlock)success withfialedBlock:(requestFialedBlock)Fialed
{
    
    //新建loadingView,展示loadingView.
    switch (method) {
        case GET:{
            
            [self GET:path parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //统一做处理,关闭loadingview
                [RYLoadingView hideRequestLoadingView];
               
                
                
                if ([responseObject[@"code"] isEqualToString:@"1"]) {
                    
                    success(responseObject);
                    
                }else {
                    NSString* msg= responseObject[@"description"];
                    Fialed(msg);
                    [FENavTool showAlertViewByAlertMsg:msg andType:@"提示"];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //统一做处理,关闭loadingview
                [RYLoadingView hideRequestLoadingView];
                Fialed(@"网络错误");
                [FENavTool showAlertViewByAlertMsg:@"网络错误" andType:@"提示"];
            }];
            
        }
            break;
            
        case POST:{
            
            [self POST:path parameters:dictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //统一做处理,关闭loadingview
                [RYLoadingView hideRequestLoadingView];
                
                
                
                if ([responseObject[@"code"] isEqualToString:@"1"]) {
                    success(responseObject);
                }else {
                    
                    NSString* msg= responseObject[@"description"];
                    
                    Fialed(msg);
                    [FENavTool showAlertViewByAlertMsg:msg andType:@"提示"];
                }
                //
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //统一做处理,关闭loadingview
                [RYLoadingView hideRequestLoadingView];
                Fialed(@"网络错误");
                [FENavTool showAlertViewByAlertMsg:@"网络错误" andType:@"提示"];
            }];
        }
            break;
        default:
            break;
    }
}

@end
