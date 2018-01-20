//
//  TNAAutoLayoutTableBaseView.m
//  Toon
//
//  Created by wangguopeng on 16/6/20.
//  Copyright © 2016年 Joy. All rights reserved.
//
#define KNoInfoSectionFootH 0.0f
#define KNoInfoSectionH 10
#define KNormalSectionH 40
#import "JoySectionBaseModel.h"
#import "UITableViewCell+JoyCell.h"
#import "JoyTableAutoLayoutView.h"
#import <objc/runtime.h>
#import "JoyCellBaseModel+Action.h"
#import "JoyCellBaseModel+Edit.h"

#define SCREEN_HEIGHT_OF_IPHONE6PLUS 736
#define IOS8_OR_LATER ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)
@interface JoyTableAutoLayoutView ()<JoyCellDelegate>{
    NSMutableArray *registCellArrayM;
    BOOL _isHasTableFoot;
}
@property (nonatomic,readonly)BOOL                        editing;
@property (nonatomic,strong)UIView                      *backView;

@end

const NSString *tableHDelegate =  @"tableHDelegate";
@implementation JoyTableAutoLayoutView
#pragma mark 动态执行代理
CGFloat tableRowH(id self, SEL _cmd, UITableView *tableView,NSIndexPath *indexPath){
    NSMutableArray *array =  objc_getAssociatedObject(self, &tableHDelegate);
    JoySectionBaseModel *sectionModel = [array objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return model.cellH;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!IOS8_OR_LATER)
        {class_addMethod([self class], @selector(tableView:heightForRowAtIndexPath:), (IMP)tableRowH, "f@:@:@");}
        registCellArrayM = [NSMutableArray array];
        [self addSubview:self.tableView];
        [self addSubViewToSelf];
        [self setConstraint];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

#pragma mark 供子类扩展使用
- (void)addSubViewToSelf{}

#pragma mark getter method
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromRGB(0xF2F2F4);
        _tableView.sectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
    }
    return _tableView;
}

#pragma clang diagnostic ignored "-Wunused-variable"
#pragma mark 设置约束
-(void)setConstraint{
    __weak __typeof (&*self)weakSelf = self;
    MAS_CONSTRAINT(weakSelf.tableView, make.edges.equalTo(weakSelf););
}

-(void)setBackView:(UIView *)backView{
    _backView = backView;
    self.tableView.backgroundView = backView;
}

-(void)setEditing:(BOOL)editing{
    _editing = editing;
    _tableView.editing = editing;
}

#pragma mark 准备刷新
- (JoyTableAutoLayoutView *)beginUpdates{
    [self.tableView beginUpdates];
    return self;
}

#pragma mark 结束新列
- (JoyTableAutoLayoutView *)endUpdates{
    [self.tableView endUpdates];
    return self;
}

#pragma mark 刷新table
-(JoyTableAutoLayoutView *)reloadTableView{
    objc_setAssociatedObject(self, &tableHDelegate, self.dataArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.tableView reloadData];
    return self;
}

#pragma mark 刷新table 的section
- (JoyTableAutoLayoutView *)reloadSection:(NSIndexPath *)indexPath{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    return self;
}

#pragma mark 刷新table 的row
- (JoyTableAutoLayoutView *)reloadRow:(NSIndexPath *)indexPath{
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    return self;
}

#pragma mark 🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲Table DataSource Protocol🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.sectionH?:([sectionModel.sectionTitle length]?KNormalSectionH:KNoInfoSectionH);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.sectionFootH?:([sectionModel.sectionFootTitle length]?KNormalSectionH:KNoInfoSectionFootH);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    sectionModel.sectionH = sectionModel.sectionH?:sectionModel.sectionTitle?KNormalSectionH:KNoInfoSectionH;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, sectionModel.sectionH)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,view.frame.size.width, sectionModel.sectionH)];
    titleLabel.text =  sectionModel.sectionTitle;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = UIColorFromRGB(0x777E8C);
    [titleLabel sizeToFit];
    CGFloat titleLabelW = titleLabel.frame.size.width;
    CGFloat titleLabelH = titleLabel.frame.size.height;
    CGFloat titleLabelX = 9;
    CGFloat titleLabelY = sectionModel.sectionH - (7) - titleLabelH;
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    [view addSubview:titleLabel];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    sectionModel.sectionFootH = sectionModel.sectionFootH?:sectionModel.sectionFootTitle?KNormalSectionH:KNoInfoSectionFootH;
    if (sectionModel.sectionFootH <=KNoInfoSectionFootH) return nil;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, sectionModel.sectionFootH)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,view.frame.size.width-30, sectionModel.sectionFootH)];
    titleLabel.numberOfLines = 0;
    titleLabel.text =  sectionModel.sectionFootTitle;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = UIColorFromRGB(0x777E8C);
    [titleLabel sizeToFit];
    CGFloat titleLabelW = titleLabel.frame.size.width;
    CGFloat titleLabelH = titleLabel.frame.size.height;
    CGFloat titleLabelX = 15;
    CGFloat titleLabelY = 10;
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    [view addSubview:titleLabel];
    return view;
}

//ios7系统需要计算cell的h
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
//    if(!model.cellH){
//        [self registTableCellWithCellModel:model];
//        UITableViewCell <JoyCellProtocol>*cell= [tableView dequeueReusableCellWithIdentifier:model.cellName];
//        if ([cell respondsToSelector:@selector(setCellWithModel:)]) {
//            [cell setCellWithModel:model];
//        }
//        [cell.contentView setNeedsLayout];
//        [cell.contentView layoutIfNeeded];
//        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
//        model.cellH = height;
//    }
    return model.cellH?:44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArrayM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:section];
    return sectionModel.rowArrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    [self registTableCellWithCellModel:model];
    UITableViewCell <JoyCellProtocol>*cell = [tableView dequeueReusableCellWithIdentifier:model.cellName];
    __weak __typeof (&*self)weakSelf = self;
    model.cellBlock =^(id obj,ERefreshScheme scheme){
        [weakSelf.tableView beginUpdates];
        [weakSelf reloadWithScheme:scheme andIndexPath:indexPath andObj:obj];
        [weakSelf.tableView endUpdates];
    };
    cell.delegate = self;
    
    cell.index = indexPath;
    
    if ([cell respondsToSelector:@selector(setCellWithModel:)]) {
        [cell setCellWithModel:model];
    }
    
    model.backgroundColor? cell.backgroundColor = model.backgroundColor:nil;
    
    cell.beginUpdatesBlock =^(){
        [weakSelf beginUpdates];
    };
    
    cell.endUpdatesBlock =^(){
        [weakSelf endUpdates];
    };
    
    cell.scrollBlock = ^(NSIndexPath *indexPath,UITableViewScrollPosition scrollPosition,BOOL animated){
        [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    };
    
    cell.longPressBlock = ^{
        [weakSelf cellDidSelectWithIndexPath:indexPath action:model.longPressAction];
    };
    
    cell.accessoryType = model.accessoryType;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.userInteractionEnabled = !model.disable;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self cellDidSelectWithIndexPath:indexPath action:nil];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    
    if(sectionModel.sectionLeadingOffSet)
    {
        [cell respondsToSelector:@selector(setSeparatorInset:)]?[cell setSeparatorInset:UIEdgeInsetsMake(0, sectionModel.sectionLeadingOffSet, 0, 0)]:nil;
        [cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]?[cell setPreservesSuperviewLayoutMargins:NO]:nil;
    }
    else
    {
        [cell respondsToSelector:@selector(setSeparatorInset:)]?[cell setSeparatorInset:UIEdgeInsetsMake(0, KNoInfoSectionH, 0, 0)]:nil;
        [cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]?[cell setPreservesSuperviewLayoutMargins:NO]:nil;
    }
}

#pragma mark ⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️Table's Action Delegate Protocol⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️⚙️
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentSelectIndexPath = nil;
}

#pragma mark 是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return model.editingStyle != UITableViewCellEditingStyleNone;
}

#pragma mark 是否可挪移
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return [model respondsToSelector:@selector(canMove)]?model.canMove:NO;
}

#pragma mark 挪移action
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    CellMoveBlock cellMoveActionBlock = objc_getAssociatedObject(self, @selector(cellMoveAction));
    cellMoveActionBlock?cellMoveActionBlock(sourceIndexPath, destinationIndexPath):nil;
}


#pragma mark 编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    return model.editingStyle;
}

#pragma mark 编辑action
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    CellEditingBlock cellEiditActionBlock = objc_getAssociatedObject(self, @selector(cellEiditAction));
    cellEiditActionBlock?cellEiditActionBlock(editingStyle,indexPath):nil;
}

#pragma mark 😊😊😊😊😊😊😊😊😊😊😊😊Cell‘s Delegate Protocol(text action)😊😊😊😊😊😊😊😊😊😊😊😊😊😊
-(void)textChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey{
    CellTextEndChanged cellTextEiditEndBlock = objc_getAssociatedObject(self, @selector(cellTextEiditEnd));
    cellTextEiditEndBlock?cellTextEiditEndBlock(selectIndex, content,changeTextKey):nil;
}

- (void)textHasChanged:(NSIndexPath *)selectIndex andText:(NSString *)content andChangedKey:(NSString *)changeTextKey{
    CellTextCharacterHasChanged cellTextCharacterHasChangedBlock = objc_getAssociatedObject(self, @selector(cellTextCharacterHasChanged));
    cellTextCharacterHasChangedBlock?cellTextCharacterHasChangedBlock(selectIndex, content,changeTextKey):nil;
}

-(void)textshouldBeginEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath{
    self.currentSelectIndexPath = indexPath;
    CGFloat footH = SCREEN_H>= SCREEN_HEIGHT_OF_IPHONE6PLUS?190:120;
    CGFloat contentInsetBottom = SCREEN_H>= SCREEN_HEIGHT_OF_IPHONE6PLUS?340:280;
    _isHasTableFoot?:[self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, footH)]];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, contentInsetBottom, 0);
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)textshouldEndEditWithTextContainter:(id)textContainer andIndexPath:(NSIndexPath *)indexPath{
    
}

//模拟selectAction
-(void)cellDidSelectWithIndexPath:(NSIndexPath *)indexPath action:(NSString *)action{
    
    self.oldSelectIndexPath = self.currentSelectIndexPath;
    [self hideKeyBoard];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    if (!model.disable) {
        self.currentSelectIndexPath = indexPath;
        CellSelectBlock cellSelectBlock = objc_getAssociatedObject(self, @selector(cellDidSelect));
        cellSelectBlock?cellSelectBlock(indexPath,action?:model.tapAction):nil;
        [model action:action];
    }
}

#pragma mark ⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️ scrollDelegate protocol⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️⚽️
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.tableView) {
        [self hideKeyBoard];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    ScrollBlock tableScrollBlock = objc_getAssociatedObject(self, @selector(tableScroll));
    tableScrollBlock?tableScrollBlock(scrollView):nil;
}

- (void)hideKeyBoard{
    _isHasTableFoot?:[self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 20)]];
    self.tableView.contentInset = UIEdgeInsetsZero;
    HIDE_KEYBOARD;
}

#pragma mark 手势触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeyBoard];
}

#pragma mark 回刷数据 cellmodel使用
- (void)reloadWithScheme:(ERefreshScheme)scheme andIndexPath:(NSIndexPath *)indexPath andObj:(id)obj{
    switch (scheme) {
        case ERefreshSchemeRow:
            [self reloadRow:indexPath];
            break;
        case ERefreshSchemeSection:
            [self reloadSection:indexPath];
            break;
        case ERefreshSchemeTable:
            [self reloadTableView];
            break;
        case ERefreshSchemeView:
        default:
            break;
    }
    JoySectionBaseModel *sectionModel = [self.dataArrayM objectAtIndex:indexPath.section];
    JoyCellBaseModel * model  = sectionModel.rowArrayM[indexPath.row];
    model.changeKey?[self textChanged:indexPath andText:obj andChangedKey:model.changeKey]:nil;
}

#pragma mark table 头和尾
- (void)setTableHeaderView:(UIView *)headView{
    [self.tableView setTableHeaderView:headView];
}

- (void)setTableFootView:(UIView *)footView{
    [self.tableView setTableFooterView:footView];
    _isHasTableFoot = footView.frame.size.height>20;
}

- (void)registTableCellWithCellModel:(JoyCellBaseModel *)cellModel{
    if (![registCellArrayM containsObject:cellModel.cellName])
    {
        cellModel.cellType == ECellCodeType?[_tableView registerClass:NSClassFromString(cellModel.cellName) forCellReuseIdentifier:cellModel.cellName]:
        [_tableView registerNib:[UINib nibWithNibName:cellModel.cellName bundle:JOY_GETBUNDLE(cellModel.bundleName)] forCellReuseIdentifier:cellModel.cellName];
        [registCellArrayM addObject:cellModel.cellName];
    }
}

-(NSMutableArray *)dataArrayM{
    return _dataArrayM =_dataArrayM?:[NSMutableArray arrayWithCapacity:0];
}

#pragma mark getMethod
//让Table确认是否可编辑
-(JoyTableAutoLayoutView *(^)(BOOL))setTableEdit{
    __weak __typeof(&*self)weakSelf = self;
    return ^(BOOL canEdit){
        weakSelf.editing = canEdit;
        return weakSelf;
    };
}

//给Table数据源
-(JoyTableAutoLayoutView *(^)(NSMutableArray<JoySectionBaseModel *> *))setDataSource{
    __weak __typeof(&*self)weakSelf = self;
    return ^(NSMutableArray *dataArrayM){
        weakSelf.dataArrayM = dataArrayM;
        return weakSelf;
    };
}

//给背景视图TableBackView
-(JoyTableAutoLayoutView *(^)(UIView *))setTableBackView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *backView){
        weakSelf.backView = backView;
        return weakSelf;
    };
}

//给头视图TableHeadView
-(JoyTableAutoLayoutView *(^)(UIView *))setTableHeadView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *headView){
        [weakSelf setTableHeaderView:headView];
        return weakSelf;
    };
}

//给尾视图TableFootView
-(JoyTableAutoLayoutView *(^)(UIView *))setTableFootView{
    __weak __typeof(&*self)weakSelf = self;
    return ^(UIView *headView){
        [weakSelf setTableFootView:headView];
        return weakSelf;
    };
}

//刷新整个Table
-(JoyTableAutoLayoutView *(^)(void))reloadTable{
    __weak __typeof(&*self)weakSelf = self;
    return ^(){
        [weakSelf reloadTableView];
        return weakSelf;
    };
}

-(JoyTableAutoLayoutView *(^)(ScrollBlock))tableScroll{
    __weak __typeof(&*self)weakSelf = self;
    return ^(ScrollBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 被点击
-(JoyTableAutoLayoutView *(^)(CellSelectBlock))cellDidSelect{
    
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellSelectBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell编辑事件
-(JoyTableAutoLayoutView *(^)(CellEditingBlock))cellEiditAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellEditingBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 挪移事件
-(JoyTableAutoLayoutView *(^)(CellMoveBlock))cellMoveAction{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellMoveBlock block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell文本编辑结束
-(JoyTableAutoLayoutView *(^)(CellTextEndChanged))cellTextEiditEnd{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellTextEndChanged block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

//cell 文字编辑发生变化
-(JoyTableAutoLayoutView *(^)(CellTextCharacterHasChanged))cellTextCharacterHasChanged{
    __weak __typeof(&*self)weakSelf = self;
    return ^(CellTextCharacterHasChanged block){
        objc_setAssociatedObject(weakSelf, _cmd, block, OBJC_ASSOCIATION_COPY);
        return weakSelf;
    };
}

-(void)dealloc{
    self.dataArrayM = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self removeFromSuperview];
}

@end

@implementation JoyTableBaseView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self.dataArrayM[indexPath.section] rowArrayM][indexPath.row] cellH];
}

@end

