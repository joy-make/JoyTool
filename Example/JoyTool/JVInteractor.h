//
//  JVInteractor.h
//  JoyTool
//
//  Created by wangguopeng on 2017/4/12.
//  Copyright © 2017年 wangguopeng. All rights reserved.
//

#import <JoyTool/JoyTool.h>

@interface JVInteractor : JoyInteractorBase
@property (nonatomic,strong)NSMutableArray *dataArrayM;
- (void)getDataSourceSuccess:(LISTBLOCK)list;
@end
