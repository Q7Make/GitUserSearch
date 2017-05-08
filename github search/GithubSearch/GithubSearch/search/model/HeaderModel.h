//
//  HeaderModel.h
//  GithubSearch
//
//  Created by ZhangQian on 17/5/7.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject

@property (nonatomic, copy) NSString *name;         /**< 昵称*/
@property (nonatomic, copy) NSString *location;     /**< 地理位置*/
@property (nonatomic, copy) NSString *bio;          /**< 个人签名*/
@property (nonatomic, copy) NSString *followers;    /**< follower*/
@property (nonatomic, copy) NSString *following;    /**< following*/
@property (nonatomic, copy) NSString *public_repos; /**< repos数*/
- (void)requestDataWithUrl:(NSString*)url;
@end
