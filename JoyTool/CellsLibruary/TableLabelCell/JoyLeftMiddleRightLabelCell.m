//
//  JoyLeftMiddleRightLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftMiddleRightLabelCell.h"
#import "Joy.h"

@interface JoyLeftMiddleRightLabelCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *middleLabel;
@property (strong, nonatomic) UILabel *rightLabel;
@end

@implementation JoyLeftMiddleRightLabelCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.middleLabel];
        [self.contentView addSubview:self.rightLabel];
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

-(UILabel *)middleLabel{
    if(!_middleLabel){
        _middleLabel = [[UILabel alloc]init];
        _middleLabel.numberOfLines = 0;
        _middleLabel.font = [UIFont systemFontOfSize:15];
        _middleLabel.textColor = UIColorFromRGB(0xACA3BF);
    }
    return _middleLabel;
}

-(UILabel *)rightLabel{
    if(!_rightLabel){
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.numberOfLines = 0;
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _middleLabel.textColor = UIColorFromRGB(0xAAAAAA);
    }
    return _rightLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.trailing.mas_greaterThanOrEqualTo(weakSelf.titleLabel.mas_leading).offset(-3);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.width.mas_lessThanOrEqualTo(60);
                   make.top.mas_equalTo(weakSelf.contentView).mas_offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.middleLabel,
                   make.trailing.mas_equalTo(weakSelf.rightLabel.mas_leading).offset(-3);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(weakSelf.contentView).mas_offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.rightLabel,
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.width.mas_lessThanOrEqualTo(100);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(weakSelf.contentView).mas_offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

- (void)setCellWithModel:(JoyCellBaseModel *)model{
    JoyCellBaseModel *setModel = (JoyCellBaseModel *)model;
    self.titleLabel.text = setModel.title;
    self.middleLabel.text = setModel.topicTitle;
    self.rightLabel.text = model.subTitle;
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.subTitleColor) {
        self.middleLabel.textColor = model.subTitleColor;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
