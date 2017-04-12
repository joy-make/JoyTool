//
//  JVPresenter.m
//  JoyTool
//
//  Created by wangguopeng on 2017/4/12.
//  Copyright © 2017年 wangguopeng. All rights reserved.
//

#import "JVPresenter.h"
#import "JVInteractor.h"
#import <JoyTool.h>

@interface JVPresenter ()<TextChangedDelegete>

@end

@implementation JVPresenter
-(void)setLayoutView:(JoyTableAutoLayoutView *)layoutView{
    _layoutView = layoutView;
    _layoutView.editing = YES;  //设置可编辑
    __weak __typeof (&*self)weakSelf = self;
    _layoutView.tableDidSelectBlock =^(NSIndexPath *indexPath,NSString *tapAction){
        [weakSelf performTapAction:tapAction];
    };
    
    _layoutView.tableEditingBlock =^(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath){
        //自定义编辑action
    };
    
    _layoutView.tableMoveBlock = ^(NSIndexPath *sourceIndexPath, NSIndexPath *toIndexPath){
        //挪移
    };
    
    _layoutView.tableTextCharacterHasChangedBlock = ^(NSIndexPath *indexPath, NSString *content, NSString *key){
        //字符发生变化
    };
    
    _layoutView.tableTextEndChangedBlock = ^(NSIndexPath *indexPath, NSString *content, NSString *key){
        //文本结束编辑
    };
}

-(void)reloadDataSource{
    __weak __typeof (&*self)weakSelf = self;
    [self.interactor getDataSourceSuccess:^(NSArray *list)
    {
        weakSelf.layoutView.dataArrayM = weakSelf.interactor.dataArrayM;
        [weakSelf.layoutView reloadTableView];
    }];
}

-(void)rightNavItemClickAction{
    _layoutView.editing = !_layoutView.editing;  //设置可编辑
}

- (void)tapAction{
    JoySectionBaseModel *section = self.interactor.dataArrayM[self.layoutView.currentSelectIndexPath.section];
    JoyCellBaseModel *rowModel = section.rowArrayM[self.layoutView.currentSelectIndexPath.row];
    [JoyAlert showWithMessage:[NSString stringWithFormat:@"你点了%@,section:%ld,row:%ld",rowModel.title,self.layoutView.currentSelectIndexPath.section,self.layoutView.currentSelectIndexPath.row]];
}


@end
