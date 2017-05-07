//
//  NSString+Extend.m
//  DDLC
//
//  Created by dh on 14/10/29.
//  Copyright (c) 2014年 dh. All rights reserved.
//

#import "NSString+Extend.h"
#import <SystemConfiguration/SystemConfiguration.h>

//获取当前设备系统版本
#define DeviceVersion(version) ([[[UIDevice currentDevice] systemVersion] doubleValue] >= version)
#define SystemVersion [UIDevice currentDevice].systemVersion.floatValue
#define Margin1 (SystemVersion >= 7.0 ? 20.0 :0)

@implementation NSString (Extend)
//根据传进来的任何对象返回字符串
+(NSString *)stringWithObject:(id)obj {
    return [self stringWithFormat:@"%@",obj];
}
//替换手机号
+(NSString *)stringByReplaceWithPhoneNumber:(NSString *)phoneNumber {
    if (phoneNumber.length == 11) {
        //判断是否为正确的手机号
        NSRange range = {3,4};
        return [phoneNumber stringByReplacingCharactersInRange:range withString:@"****"];
    }
    return phoneNumber;
}

- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode{
    CGSize retSize=CGSizeZero;
    if (DeviceVersion(7.0)) {
        CGRect rect=[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
        retSize=rect.size;
    } else{
        //已经不支持6.0
//        retSize=[self sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return retSize;
}

+ (BOOL)isValidString:(NSString *)str {
    return ![self isBlankString:str];
}

+ (BOOL)isBlankString:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (!str || [str isEqualToString:@""]) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)containsString:(NSString *)subString {
    NSRange range = [self rangeOfString:subString];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

@end
