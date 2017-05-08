//
//  Utilities.h
//  GithubSearch
//
//  Created by ZhangQian on 17/5/7.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

#define WS(weakSelf) __weak typeof(self) weakSelf=self

+ (BOOL) isBlankString:(NSString *)string;

@end
