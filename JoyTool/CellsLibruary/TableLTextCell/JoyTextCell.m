//
//  JoyTextCell.m
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyTextCell.h"
#import "JoyCellBaseModel.h"
#import "NSString+JoyCategory.h"
#import "UITextField+JoyCategory.h"
#import "joy.h"

@interface JoyTextCell()<UITextFieldDelegate>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (nonatomic,copy) NSString *inputOldStr;
@property (nonatomic,copy)NSString *changeTextKey;
@end

@implementation JoyTextCell

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textField];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.delegate = self;
        _textField.font = [UIFont systemFontOfSize:15];
    }
    return _textField;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.width.mas_lessThanOrEqualTo(80);
                   make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.textField,
                   make.leading.mas_equalTo(weakSelf.titleLabel.mas_trailing).offset(5);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

- (void)setCellWithModel:(JoyTextCellBaseModel *)model{
    self.changeTextKey = model.changeKey;
    self.textField.keyboardType = model.keyboardType?model.keyboardType:UIKeyboardTypeDefault;
    [self.textField setTextMaxNum:model.maxNumber];
    self.textField.secureTextEntry = model.secureTextEntry;
    if (self.maxNum && model.subTitle.strLength> self.maxNum) {
        model.subTitle  =  [model.subTitle subToMaxIndex:self.maxNum];
    }
    self.titleLabel.text = model.title;
    self.textField.text = model.subTitle;
    self.textField.placeholder = model.placeHolder;
    objc_setAssociatedObject(self, @selector(editingEnd:), model, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @selector(textFieldDidEndEditing:), model, OBJC_ASSOCIATION_RETAIN);
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.placeHolder) {
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:model.placeHolder];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:UIColorFromRGB(0x95989F)
                            range:NSMakeRange(0, model.placeHolder.length)];
        self.textField.attributedPlaceholder = placeholder;
  
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)editDidBegin:(id)sender {
    
}

- (IBAction)editingEnd:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, _cmd);
        model.subTitle = textField.text;
        [self.delegate textChanged:self.index andText:textField.text andChangedKey:self.changeTextKey];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textChanged:andText:andChangedKey:)]) {
        JoyTextCellBaseModel *model = objc_getAssociatedObject(self, _cmd);
        model.title = textField.text;
        [self.delegate textChanged:self.index andText:textField.text andChangedKey:self.changeTextKey];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldBeginEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldBeginEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textshouldEndEditWithTextContainter:andIndexPath:)]) {
        [self.delegate textshouldEndEditWithTextContainter:textField andIndexPath:self.index];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
