//
//  JoyLeftIconCell.m
//  Toon
//
//  Created by wangguopeng on 16/7/25.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftIconCell.h"
#import "JoyCellBaseModel.h"
#import "joy.h"

@interface JoyLeftIconCell ()

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic)  UILabel *titleLabel;

@end

@implementation JoyLeftIconCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(void)setConstraint{
    __weak __typeof(&*self)weakSelf = self;
    MAS_CONSTRAINT(self.iconImageView,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.height.mas_equalTo(33.5);
                   make.width.mas_equalTo(weakSelf.iconImageView.mas_height);
                   make.top.mas_greaterThanOrEqualTo(weakSelf.contentView).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.iconImageView.mas_trailing).offset(15);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

-(void)setCellWithModel:(JoyImageCellBaseModel *)model{
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);
    SDIMAGE_LOAD(_iconImageView, model.avatar, placeHolderImageStr);

    if (model.viewShape == EImageTypeRound) {
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 17;
    }else{
        _iconImageView.layer.masksToBounds = NO;
    }
    _titleLabel.text = model.title;
}

@end
