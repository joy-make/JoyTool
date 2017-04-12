//
//  NSObject+JoyRouter.h
//  Toon
//
//  Created by wangguopeng on 2017/3/8.
//  Copyright © 2017年 思源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JoyRouter)
-(NSObject *)joyProtocolObjectFromStr:(NSString *)classStr;


-(Class)joyClassFromStr:(NSString *)classStr;

@end
