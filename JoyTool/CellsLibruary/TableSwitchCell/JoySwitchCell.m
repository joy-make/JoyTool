//
//  SwitchCell.m
//  Toon
//
//  Created by wangguopeng on 16/5/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoySwitchCell.h"
#import "JoyCellBaseModel.h"
#import "Joy.h"

@interface JoySwitchCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UISwitch *mySwitch;

@end

@implementation JoySwitchCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.mySwitch];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}


-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(UISwitch *)mySwitch{
    if (!_mySwitch) {
        _mySwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
        [_mySwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.trailing.mas_equalTo(weakSelf.mySwitch.mas_leading).offset(-15);
                   make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(10);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.mySwitch,
                   make.trailing.mas_equalTo(weakSelf.contentView.mas_trailing).offset(-15);
                   make.height.mas_equalTo(31);
                   make.width.mas_equalTo(49);
                   make.top.mas_greaterThanOrEqualTo(weakSelf.contentView.mas_top).offset(6);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

-(void)setCellWithModel:(JoySwitchCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.mySwitch.userInteractionEnabled = !model.disable;
    self.mySwitch.on = model.on;
    __block JoySwitchCellBaseModel *switchModel = model;
    __weak typeof (self) weakSelf = self;
    model.aToBCellBlock= ^(id onState){
        switchModel.on = [onState boolValue];
        [weakSelf.mySwitch setOn:[onState boolValue] animated:NO];
        [weakSelf.mySwitch layoutIfNeeded];
    };
    objc_setAssociatedObject(self, @selector(switchValueChanged:), model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)switchValueChanged:(UISwitch *)sender {
    JoySwitchCellBaseModel *model = objc_getAssociatedObject(self, _cmd) ;
    model.on = sender.on;
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        [self.delegate textChanged:self.index andText:(NSString *)@(sender.on) andChangedKey:model.changeKey];
    }
}

@end
