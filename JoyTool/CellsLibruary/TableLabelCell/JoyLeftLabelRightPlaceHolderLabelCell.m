//
//  JoyLeftLabelRightPlaceHolderLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/4/15.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftLabelRightPlaceHolderLabelCell.h"
#import "JoyCellBaseModel.h"
#import "joy.h"
@interface JoyLeftLabelRightPlaceHolderLabelCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *placeHolderLabe;

@end

@implementation JoyLeftLabelRightPlaceHolderLabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.placeHolderLabe];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        _subTitleLabel.backgroundColor = JOY_clearColor;
    }
    return _subTitleLabel;
}

-(UILabel *)placeHolderLabe{
    if(!_placeHolderLabe){
    _placeHolderLabe = [[UILabel alloc]init];
    _placeHolderLabe.textColor = UIColorFromRGB(0x95989F);
    _placeHolderLabe.font = [UIFont systemFontOfSize:15];
    }
    return _placeHolderLabe;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.width.mas_lessThanOrEqualTo(100);
                   make.top.mas_equalTo(weakSelf.contentView).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.subTitleLabel,
                   make.leading.mas_equalTo(weakSelf.titleLabel.mas_trailing).offset(10);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.height.mas_greaterThanOrEqualTo(33.5);
                   make.top.mas_equalTo(weakSelf.contentView).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.placeHolderLabe,
                   make.edges.mas_equalTo(weakSelf.subTitleLabel);
                   );
}

- (void)setCellWithModel:(JoyCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    self.titleLabel.textColor = model.titleColor?:UIColorFromRGB(0x000000);
    self.placeHolderLabe.text = model.placeHolder;
    self.placeHolderLabe.hidden =  self.subTitleLabel.text.length;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
