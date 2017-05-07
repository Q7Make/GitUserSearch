//
//  UserInfoModel.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/6.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "UserInfoModel.h"
#import "NetWork.h"

#define WS(weakSelf) __weak typeof(self) weakSelf=self
NSString *const APIUrl1 = @"https://api.github.com/search/users?q=";

@implementation UserInfoModel

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
    [NetWork getRequestWithURL:url success:^(id resultDic) {
        [weakSelf jsonData:resultDic];
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
}

- (void)jsonData:(NSMutableArray *)resultDic {
    //NSLog(@"%@", resultDic);
    if (resultDic.count > 0 && [resultDic isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dataDict in resultDic) {
            UserInfoModel *model = [[UserInfoModel alloc] init];
            model.name = [dataDict objectForKey:@"name"];
            model.descriptionStr = [dataDict objectForKey:@"description"];
            model.language = [dataDict objectForKey:@"language"];
            model.stars = [NSString stringWithFormat:@"%@", [dataDict objectForKey:@"stargazers_count"]];
            [self.dataArr addObject:model];
        }
    }
    NSNotification *notice = [NSNotification notificationWithName:@"reposList" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

@end
