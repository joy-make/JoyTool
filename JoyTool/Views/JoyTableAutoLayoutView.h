//
//  TNAAutoLayoutTableBaseView.h
//  Toon
//
//  Created by wangguopeng on 16/6/20.
//  Copyright © 2016年 Joy. All rights reserved.
//  autolayout table

//autolayout基类，勿改，若需修改，请建子类修改


#import "UIView+JoyCategory.h"
#import "joy.h"
@class JoyTableAutoLayoutView;

typedef void (^CellSelectBlock)(NSIndexPath *indexPath,NSString *tapAction);

typedef void (^CellEditingBlock)(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath);

typedef void (^CellMoveBlock)(NSIndexPath *sourceIndexPath,NSIndexPath *toIndexPath);

typedef void (^CellTextEndChanged)(NSIndexPath *indexPath,NSString *content,NSString *key);

typedef void (^CellTextCharacterHasChanged)(NSIndexPath *indexPath,NSString *content,NSString *key);

typedef void (^ScrollBlock)(UIScrollView *scrollView);

@class JoySectionBaseModel;
@interface JoyTableAutoLayoutView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView                             *tableView;

@property (nonatomic,strong)NSMutableArray<JoySectionBaseModel *>   *dataArrayM;

@property (nonatomic,strong)NSIndexPath                             *oldSelectIndexPath;

@property (nonatomic,strong)NSIndexPath                             *currentSelectIndexPath;

//**********************************链式配置,以支持链式调用*************************************************
#pragma mark  让Table确认是否可编辑
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableEdit)(BOOL canEdit);
#pragma mark  给Table数据源
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setDataSource)(NSMutableArray<JoySectionBaseModel *> *dataArrayM);
#pragma mark  给背景视图TableBackView
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableBackView)(UIView *backView);
#pragma mark  给头视图TableHeadView
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableHeadView)(UIView *headView);
#pragma mark  给尾视图TableFootView
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^setTableFootView)(UIView *footView);
#pragma mark  刷新整个Table
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^reloadTable)(void);

//**************编辑Action
#pragma mark  Cell 选中
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellDidSelect)(CellSelectBlock cellSelectBlock);
#pragma mark  Cell 编辑
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellEiditAction)(CellEditingBlock cellEditingBlock);
#pragma mark  Cell 挪动从from 挪到to
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellMoveAction)(CellMoveBlock cellMoveBlock);
#pragma mark  Cell上文本编辑结束
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellTextEiditEnd)(CellTextEndChanged cellTextEiditEndBlock);
#pragma mark  Cell上文本字符编辑发生变化
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^cellTextCharacterHasChanged)(CellTextCharacterHasChanged cellTextCharacterHasChangedBlock);
//**************编辑Action结束
#pragma mark Table滚动
@property (nonatomic,readonly)JoyTableAutoLayoutView    *(^tableScroll)(ScrollBlock scrollBlock);

//**********************************链式配置,以支持链式调用*************************************************

#pragma mark 刷新section
- (JoyTableAutoLayoutView *)reloadSection:(NSIndexPath *)indexPath;

#pragma mark 刷新列
- (JoyTableAutoLayoutView *)reloadRow:(NSIndexPath *)indexPath;

#pragma mark 设置约束 子类调super时用
- (void)setConstraint;

#pragma mark 准备刷新
- (JoyTableAutoLayoutView *)beginUpdates;

#pragma mark 结束新列
- (JoyTableAutoLayoutView *)endUpdates;

@end

@interface JoyTableBaseView : JoyTableAutoLayoutView

@end

