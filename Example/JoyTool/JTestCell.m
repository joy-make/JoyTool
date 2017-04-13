//
//  JTestCell.m
//  JoyTool
//
//  Created by wangguopeng on 2017/4/13.
//  Copyright © 2017年 wangguopeng. All rights reserved.
//

#import "JTestCell.h"
#import <JoyTool.h>
@interface JTestCell ()
@property (nonatomic,strong)UILabel *titleLabel;
@end

@implementation JTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if  (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.titleLabel];
    }
    [self setConstraint];
    [self.contentView setNeedsUpdateConstraints];
    return self;
}

- (void)setConstraint
{
    __weak typeof(self)weakSelf = self;
    MAS_CONSTRAINT(self.titleLabel, make.leading.equalTo(weakSelf.contentView.mas_leading).offset(15);
                   make.trailing.equalTo(weakSelf.contentView.mas_trailing).offset(-15);
                   make.top.equalTo(weakSelf.contentView.mas_top).offset(10);
                   make.height.mas_greaterThanOrEqualTo(24);
                   make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-10););
}

-(void)setCellWithModel:(JoyCellBaseModel *)model{
    self.titleLabel.text = model.title;
    _titleLabel.numberOfLines = 0;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

@end
