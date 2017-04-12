//
//  NSString+JoyCategory.h
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JoyCategory)
/**
 *  返回字符串的长度
 *
 */
- (NSInteger)strLength;

/**
 *  截取字符串
 *
 */

- (NSString *)subToMaxIndex:(NSInteger)maxNum;

#pragma mark 邮箱是否正确
- (BOOL)isValidateEmail;
@end
