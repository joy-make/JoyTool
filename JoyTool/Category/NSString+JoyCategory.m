//
//  NSString+JoyCategory.m
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 Joy. All rights reserved.
//

#import "NSString+JoyCategory.h"

@implementation NSString (JoyCategory)
- (NSInteger)strLength {
    __block NSInteger chinese = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if( hs >= 0x4e00 && hs <= 0x9fff) {
            chinese++;
        }
    }];
    NSInteger length=self.length + chinese;
    return length;
}

- (NSString *)subToMaxIndex:(NSInteger)maxNum{
    __block NSInteger chinese = 0;
    __block NSInteger location = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if( hs >= 0x4e00 && hs <= 0x9fff) {
            chinese+=2;
        }
        else{
            chinese+=1;
        }
        location +=1;
        if (chinese>=maxNum) {
            *stop = YES;
        }
    }];
    return [self substringToIndex:location];
}

#pragma mark 邮箱是否正确
- (BOOL)isValidateEmail
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}

@end
