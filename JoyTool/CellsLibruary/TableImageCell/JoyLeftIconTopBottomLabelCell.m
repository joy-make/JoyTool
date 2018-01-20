//
//  JoyLeftIconTopBottomLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/9/9.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftIconTopBottomLabelCell.h"
#import "joy.h"

@interface JoyLeftIconTopBottomLabelCell ()
@property (strong, nonatomic) UIImageView *accessView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *subTitleLabel;
@end

@implementation JoyLeftIconTopBottomLabelCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.accessView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UIImageView *)accessView{
    return _accessView =  _accessView?: [[UIImageView alloc]initWithFrame:CGRectZero];
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if(!_subTitleLabel){
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.textColor = UIColorFromRGB(0x757887);
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subTitleLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.accessView,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.width.mas_equalTo(weakSelf.accessView.mas_height);
                   make.height.mas_lessThanOrEqualTo(30);
                   make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(7);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.accessView.mas_trailing).offset(10);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.top.mas_greaterThanOrEqualTo(weakSelf.contentView).offset(7);
                   make.centerY.mas_equalTo(weakSelf.accessView.mas_centerY).offset(-10);
                   );
    
    MAS_CONSTRAINT(self.subTitleLabel,
                   make.leading.mas_equalTo(weakSelf.accessView.mas_trailing).offset(10);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.bottom.mas_greaterThanOrEqualTo(weakSelf.contentView).offset(7);
                   make.centerY.mas_equalTo(weakSelf.accessView.mas_centerY).offset(10);
                   );
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.subTitleColor) {
        self.subTitleLabel.textColor = model.subTitleColor;
    }
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);
    self.accessView.image = model.placeHolderImageStr.length?[UIImage imageNamed:placeHolderImageStr]:nil;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
