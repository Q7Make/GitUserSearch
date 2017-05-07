//
//  NetWork.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@implementation NetWork

#define WS(weakSelf) __weak typeof(self) weakSelf=self

+ (NetWork *)shareDataNetWork {
    static NetWork *dataNetWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataNetWork = [[self alloc] init];
    });
    return dataNetWork;
}

+ (void)isNetWorkOk {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == 0) {
            [SVProgressHUD showText:@"请检查网络连接" duration:1.5];
            return;
        }
    }];
}

//GET
+ (void)getRequestWithURL:(NSString *)url success:(void (^)(id resultDic))success failure:(void (^)(NSError * error))failure {
    [[self class] isNetWorkOk];
    WS(weakSelf);
    //管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (success && responseObject) {
                 success(responseObject);
             }
             NSLog(@"请求成功");
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             if (failure) {
                 failure(error);
             }
             NSLog(@"请求失败：%@",error);  //这里打印错误信息
             [weakSelf requestFailWithJsonData:error WithTag:0];
         }];
}

+ (void)requestFailWithJsonData:(NSError*)json WithTag:(NSInteger)tag {
    if (json.code == -1009) {
        [SVProgressHUD showText:@"请检查网络连接" duration:1.5];
    } else if (json.code == -1004) {
        [SVProgressHUD showText:@"连接不到服务器" duration:1.5];
    } else if (json.code == -1001) {
        [SVProgressHUD showText:@"请求超时" duration:1.5];
    } else {
        [SVProgressHUD showText:@"服务异常，请稍候再试!" duration:1.5];
    }
}

#pragma mark 取消网络请求
+ (void)cancelRequest {
    NSLog(@"cancelRequest...");
    [[[[self class] sharedManager] operationQueue] cancelAllOperations];
}

@end
