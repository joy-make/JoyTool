//
//  JoyPickerView.h
//  Toon
//
//  Created by wangguopeng on 16/1/4.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "UIView+JoyCategory.h"

@interface JoyPickerView : UIView
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,copy)void (^CancleBtnClickBlock)(void);
@property (nonatomic,copy)void (^EntryBtnClickBlock)(void);
@property (nonatomic,copy)void (^pickSelectBlock)(NSInteger coponent,NSInteger row);

//数组套数组格式,多section
- (void)reloadPickViewWithDataSource:(NSArray <NSArray *>*)sourceArray;

- (void)showPickView;

- (void)hidePickView;

#pragma mark 选中某一个component的某一个row
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

#pragma mark 根据component(key)对应的value进行查找 可全给或者给部分，根据componet确定
- (void)selectStrWithDict:(NSDictionary *)selectDict animated:(BOOL)animated;
@end
