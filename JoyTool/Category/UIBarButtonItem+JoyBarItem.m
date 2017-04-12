//
//  UIBarButtonItem+JoyBarItem.m
//  Toon
//
//  Created by wangguopeng on 2017/2/24.
//  Copyright © 2017年 思源. All rights reserved.
//

#import "UIBarButtonItem+JoyBarItem.h"

@implementation UIBarButtonItem (JoyBarItem)
+ (UIBarButtonItem *)JoyBarButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                 normalImage:(NSString *)normalImgName
                              highLightImage:(NSString *)highLightImageName
                                       title:(NSString *)title
                                  titleColor:(UIColor *)titleColor
                                       frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage* rendingNormalImage = [[UIImage imageNamed:normalImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage* rendingHighlightImage = [[UIImage imageNamed:highLightImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:rendingNormalImage forState:UIControlStateNormal];
    [button setImage:rendingHighlightImage forState:UIControlStateHighlighted];
    [button.imageView setValue:@"ThemeOtherBarItemImageView" forKey:@"nuiClass"];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[titleColor colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 0, 0);
    [button sizeToFit];
    button.frame = (CGRect){
        frame.origin,
        {button.frame.size.width + 2.5,button.frame.size.height},
    };
    [button setValue:@"ThemeLeftCustomBarButton" forKey:@"nuiClass"];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
