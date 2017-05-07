//
//  searchModel.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "searchModel.h"
#import "NetWork.h"

#define WS(weakSelf) __weak typeof(self) weakSelf=self
NSString *const APIUrl = @"https://api.github.com/search/users?q=";

@implementation searchModel

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)requestDataWithUrl:(NSString*)url {
    WS(weakSelf);
    url = [NSString stringWithFormat:@"%@%@",APIUrl,url];
    [NetWork getRequestWithURL:url success:^(id resultDic) {
        [weakSelf jsonData:resultDic];
    } failure:^(NSError *error) {
    }];
}

- (void)jsonData:(NSDictionary *)resultDic {
    _total_count = [resultDic objectForKey:@"total_count"];
    NSMutableArray *dataArr = [resultDic objectForKey:@"items"];
    if (dataArr.count > 0 && [dataArr isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dataDict in dataArr) {
            searchModel *model = [[searchModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDict];
            NSLog(@"%@", model.login);
            [self.dataArr addObject:model];
        }
    }
        NSNotification *notice = [NSNotification notificationWithName:@"userList" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end
