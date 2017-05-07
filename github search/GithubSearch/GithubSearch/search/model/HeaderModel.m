//
//  HeaderModel.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/7.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "HeaderModel.h"
#import "NetWork.h"
#import "Utilities.h"

#define WS(weakSelf) __weak typeof(self) weakSelf=self

@implementation HeaderModel

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)requestDataWithUrl:(NSString*)url
{
    WS(weakSelf);
    [NetWork getRequestWithURL:url success:^(id resultDic) {
        [weakSelf jsonData:resultDic];
    } failure:^(NSError *error) {
    }];
}

- (void)jsonData:(NSDictionary *)resultDic
{
    NSLog(@"%@", resultDic);
    //说明not found
    if ([[resultDic allKeys] containsObject:@"message"]) {
        NSLog(@"没有数据");
    } else {
        [self setValuesForKeysWithDictionary:resultDic];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"header" object:nil];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end
