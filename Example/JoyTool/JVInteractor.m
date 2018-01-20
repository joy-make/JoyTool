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

    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        int i = 0;
        while (i++<1000) {
            NSLog(@"%@", [NSString stringWithFormat:@"apply😄%d",i]);
            [self.dataArrayM addObject:[self getSectionData]];
        }
//        dispatch_apply(1000, queue, ^(size_t index) {
//            NSLog(@"%@", [NSString stringWithFormat:@"apply😄%ld",index]);
//            [self.dataArrayM addObject:[self getSectionData]];
//        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            list?list(self.dataArrayM):nil;
        });
    });
}

//获取section上的row数据源
- (JoySectionBaseModel *)getSectionData{
    JoySectionBaseModel *section =[[JoySectionBaseModel alloc] init];

        JoyCellBaseModel *cellModel= (JoyCellBaseModel *)[self joyProtocolObjectFromStr:@"JoyCellBaseModel"];
        cellModel.cellName = @[JoyMiddleLabelCell,JoyLeftMiddleRightLabelCell,JoyLeftLabelRightPlaceHolderLabelCell][arc4random()%3];
        [self setCellWithModel:cellModel];
        [section.rowArrayM addObject:cellModel];
    
        JoyTextCellBaseModel *textCellModel= (JoyTextCellBaseModel *)[self joyProtocolObjectFromStr:@"JoyTextCellBaseModel"];
        textCellModel.cellName = @[JoyTextCell,JoyTextNoLabelCell,JoyLeftLabelTextViewCell,@"JoyTextViewCell"][arc4random()%4];
//    textCellModel.cellName = @"JoyTextViewCell";

        [self setCellWithModel:textCellModel];
        [section.rowArrayM addObject:textCellModel];

        JoySwitchCellBaseModel *switchCellModel= (JoySwitchCellBaseModel *)[self joyProtocolObjectFromStr:@"JoySwitchCellBaseModel"];
        [self setCellWithModel:switchCellModel];
        [section.rowArrayM addObject:switchCellModel];
//
        JoyImageCellBaseModel *imageCellModel= (JoyImageCellBaseModel *)[self joyProtocolObjectFromStr:@"JoyImageCellBaseModel"];
        imageCellModel.cellName = @[JoyLeftAvatarRightLabelCell,JoyLeftIconCell,JoyLeftLabelRightIconCell,JoyLeftIconTopBottomLabelCell,JoyLeftAvatarRightTopBottomLabel][arc4random()%5];
        [self setImageCellModel:imageCellModel];
        [section.rowArrayM addObject:imageCellModel];
    return section;
}

- (void)setCellWithModel:(JoyCellBaseModel *)cellModel{
    cellModel.title =cellModel.placeHolder= [NSString stringWithFormat:@"这是一个%@cell",cellModel.cellName];
//    cellModel.cellType = [cellModel.cellName isEqualToString:JoyLeftLabelTextViewCell]?ECellXibType: ECellCodeType;
    cellModel.titleColor = JOY_RandomColor;
    cellModel.subTitleColor = JOY_RandomColor;
    cellModel.backgroundColor = JOY_RandomColor;
    cellModel.accessoryType = arc4random()%4;
    //        cellModel.canMove = YES;
    cellModel.subTitle = [NSString stringWithFormat:@"model%@",NSStringFromClass(cellModel.class)];
    cellModel.bundleName = JoyToolBundle;
    cellModel.editingStyle = arc4random()%3;
    cellModel.tapAction = @"tapAction";
}

- (void)setImageCellModel:(JoyImageCellBaseModel *)cellModel{
    [self setCellWithModel:cellModel];
    cellModel.viewShape = EImageTypeRound;
    cellModel.placeHolderImageStr = @"joymakeHead.jpg";
    cellModel.avatarBundleName = JoyToolBundle;
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM = _dataArrayM?:[NSMutableArray arrayWithCapacity:0];
}
@end
