//
//  UIBarButtonItem+JoyBarItem.h
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 思源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JoyBarItem)
+ (UIBarButtonItem *)JoyBarButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                 normalImage:(NSString *)normalImgName
                              highLightImage:(NSString *) highLightImageName
                                       title:(NSString *)title
                                  titleColor:(UIColor *)titleColor
                                       frame:(CGRect)frame;
@end
