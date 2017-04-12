//
//  JoyProtoCol.h
//  Toon
//
//  Created by wangguopeng on 2017/3/8.
//  Copyright © 2017年 思源. All rights reserved.
//

typedef void (^JoyBlock)(id parameter);
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JoyProtoCol <NSObject>

- (void)setParameter:(id)parameter block:(JoyBlock)block;

@end
