//
//  JoyBaseVC+Extention.m
//
//  Created by wangguopeng on 2017/3/15.
//  Copyright © 2017年 JoyMake. All rights reserved.
//

#import "JoyBaseVC+Extention.h"

@implementation JoyBaseVC (Extention)

- (void)disableRightNavItem{
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = NO;
    }];
}

-(void)enableRightNavItem{
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = YES;
    }];
}



@end
