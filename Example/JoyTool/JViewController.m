//
//  JViewController.m
//  JoyTool
//
//  Created by wangguopeng on 04/12/2017.
//  Copyright (c) 2017 wangguopeng. All rights reserved.
//

#import "JViewController.h"
#import "JVPresenter.h"
#import "JVInteractor.h"
@interface JViewController ()
@property (nonatomic,strong)JoyTableAutoLayoutView *layoutView;
@property (nonatomic,strong)JVInteractor *interactor;
@property (nonatomic,strong)JVPresenter  *presenter;
@end

@implementation JViewController

-(JoyTableAutoLayoutView *)layoutView{
    return _layoutView = _layoutView?:[[JoyTableAutoLayoutView alloc]initWithFrame:CGRectZero];
}

-(JVInteractor *)interactor{
    return _interactor = _interactor?:[[JVInteractor alloc]init];
}

-(JVPresenter *)presenter{
    if (!_presenter)
    {
        _presenter = [[JVPresenter alloc]initWithView:self.view];
        _presenter.layoutView = self.layoutView;
        _presenter.interactor = self.interactor;
    }
    return _presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultConstraintWithView:self.layoutView andTitle:@"10000条随机数据测试"];
    [self setRightNavItemWithTitle:@"edit"];
    [self.presenter reloadDataSource];
}

-(void)leftNavItemClickAction{
    [super leftNavItemClickAction];
    [JoyAlert showWithMessage:@"你要往哪儿跳,默认返回上一级页面"];
}

-(void)rightNavItemClickAction{
    [super rightNavItemClickAction];
    [self.presenter rightNavItemClickAction];
}

@end
