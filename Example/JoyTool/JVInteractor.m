//
//  JVInteractor.m
//  JoyTool
//
//  Created by wangguopeng on 2017/4/12.
//  Copyright © 2017年 wangguopeng. All rights reserved.
//

#import "JVInteractor.h"
#import <JoyTool.h>

@implementation JVInteractor

//获取section数据源
- (void)getDataSourceSuccess:(LISTBLOCK)list{
    __weak __typeof (&*self)weakSelf = self;
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t sectionIndex) {
        JoySectionBaseModel *section =[[JoySectionBaseModel alloc] init];
        section.sectionTitle = [NSString stringWithFormat:@"sectionTitle%zu",sectionIndex];
        [self getSectionData:section];
        __weak __typeof (&*weakSelf)strongSelf = weakSelf;
        [strongSelf.dataArrayM addObject:section];
    });
    list?list(self.dataArrayM):nil;
}

//获取section上的row数据源
- (void)getSectionData:(JoySectionBaseModel *)section{
    dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        JoyImageCellBaseModel *cellModel = (JoyImageCellBaseModel *)[self joyProtocolObjectFromStr:@[@"JoyTextCellBaseModel",@"JoyCellBaseModel",@"JoySwitchCellBaseModel",@"JoyImageCellBaseModel"][arc4random()%4]];
        cellModel.title =cellModel.placeHolder= [NSString stringWithFormat:@"rowTitle%zu",index];
        cellModel.titleColor = JOY_RandomColor;
        cellModel.subTitleColor = JOY_RandomColor;
        cellModel.backgroundColor = JOY_RandomColor;
        cellModel.accessoryType = arc4random()%4;
//        cellModel.canMove = YES;
        cellModel.subTitle = [NSString stringWithFormat:@"rowSubTitle%zu",index];
        if([cellModel isKindOfClass:[JoyImageCellBaseModel class]])
        {
            cellModel.viewShape = EImageTypeRound;
            cellModel.placeHolderImageStr = @"joymakeHead.jpg";
            cellModel.avatarBundleName = JoyToolBundle;
        }
        cellModel.bundleName = JoyToolBundle;
        cellModel.editingStyle = arc4random()%3;
        cellModel.tapAction = @"tapAction";
        [section.rowArrayM addObject:cellModel];
    });
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray arrayWithCapacity:0];
}
@end
