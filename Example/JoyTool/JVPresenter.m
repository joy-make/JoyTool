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


@implementation JVPresenter

-(void)reloadDataSource{
    __weak __typeof (&*self)weakSelf = self;
    [self.interactor getDataSourceSuccess:^(NSArray *list)
    {
    weakSelf.layoutView.setDataSource(weakSelf.interactor.dataArrayM).reloadTable().setTableEdit(YES).cellDidSelect(^(NSIndexPath *indexPath, NSString *tapAction) {
            [weakSelf performTapAction:tapAction];
        }).cellEiditAction(^(UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath) {
            //自定义编辑action
        }).cellMoveAction(^(NSIndexPath *sourceIndexPath,NSIndexPath *toIndexPath){
            //挪移
        }).cellTextCharacterHasChanged(^(NSIndexPath *indexPath, NSString *content, NSString *key){
            //字符发生变化
        }).cellTextEiditEnd(^(NSIndexPath *indexPath, NSString *content, NSString *key){
            //文本结束编辑
        });
    }];
}

-(void)rightNavItemClickAction{
    _layoutView.setTableEdit(!_layoutView.tableView.editing);
}

- (void)tapAction{
    JoySectionBaseModel *section = self.interactor.dataArrayM[self.layoutView.currentSelectIndexPath.section];
    JoyCellBaseModel *rowModel = section.rowArrayM[self.layoutView.currentSelectIndexPath.row];
    [JoyAlert showWithMessage:[NSString stringWithFormat:@"你点了%@,section:%ld,row:%ld",rowModel.title,self.layoutView.currentSelectIndexPath.section,self.layoutView.currentSelectIndexPath.row]];
}


@end
