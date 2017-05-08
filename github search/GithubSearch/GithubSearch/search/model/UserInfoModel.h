//
//  UserInfoModel.h
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy) NSString *name;              /**< repos名称*/
@property (nonatomic, copy) NSString *descriptionStr;    /**< 头像*/
@property (nonatomic, copy) NSString *language;          /**< 个人详细信息*/
@property (nonatomic, copy) NSString *stars;             /**< 获得星星数*/
@property (nonatomic, copy) NSMutableArray *dataArr;     /**< 数据*/
- (void)requestDataWithUrl:(NSString*)url;

@end
