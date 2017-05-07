//
//  NSString+Extend.h
//  DDLC
//
//  Created by dh on 14/10/29.
//  Copyright (c) 2014年 dh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extend)
//传入OBJ对象返回字符串
+(NSString *)stringWithObject:(id)obj;
//替换手机号中间4位位*
+(NSString *)stringByReplaceWithPhoneNumber:(NSString *)phoneNumber;
+ (BOOL)isBlankString:(NSString *)str;
+ (BOOL)isValidString:(NSString *)str;
- (CGSize)adaptSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;
- (BOOL)containsString:(NSString *)subString;

@end
