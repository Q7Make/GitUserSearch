//
//  NetWork.h
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject

+ (NetWork *)shareDataNetWork;
+ (void)getRequestWithURL:(NSString *)url success:(void (^)(id resultDic))success failure:(void (^)(NSError * error))failure;
+ (void)cancelRequest;

@end
