//
//  Utilities.m
//  GithubSearch
//
//  Created by ZhangQian on 17/5/7.
//  Copyright © 2017年 ZhangQian. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string ==NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}



@end
