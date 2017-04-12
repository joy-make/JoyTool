//
//  JVPresenter.h
//  JoyTool
//
//  Created by wangguopeng on 2017/4/12.
//  Copyright © 2017年 wangguopeng. All rights reserved.
//

#import <JoyTool/JoyTool.h>

@class JVInteractor,JoyTableAutoLayoutView;
@interface JVPresenter : JoyPresenterBase
@property (nonatomic,strong)JoyTableAutoLayoutView *layoutView;
@property (nonatomic,strong)JVInteractor *interactor;
@end
