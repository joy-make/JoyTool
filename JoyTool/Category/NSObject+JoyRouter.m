//
//  NSObject+JoyRouter.m
//  Toon
//
//  Created by wangguopeng on 2017/3/8.
//  Copyright © 2017年 思源. All rights reserved.
//

#import "NSObject+JoyRouter.h"

@implementation NSObject (JoyRouter)
-(NSObject *)joyProtocolObjectFromStr:(NSString *)classStr{
    Class JoyClass = NSClassFromString(classStr);
    NSObject *joyVC = [[JoyClass alloc]init];
    return joyVC;
}

-(Class)joyClassFromStr:(NSString *)classStr{
    return NSClassFromString(classStr);
}

@end
