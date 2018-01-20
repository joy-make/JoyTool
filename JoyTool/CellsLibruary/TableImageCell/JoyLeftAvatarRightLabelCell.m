//
//  JoyLeftAvatarRightLabelCell.m
//  Toon
//
//  Created by wangguopeng on 16/3/16.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftAvatarRightLabelCell.h"
#import "joy.h"
@interface JoyLeftAvatarRightLabelCell ()
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end
@implementation JoyLeftAvatarRightLabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UIImageView *)headImageView{
    return _headImageView =  _headImageView?: [[UIImageView alloc]initWithFrame:CGRectZero];
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
    MAS_CONSTRAINT(self.headImageView,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.height.mas_lessThanOrEqualTo(54.0f);
                   make.width.mas_equalTo(weakSelf.headImageView.mas_height);
                   make.top.mas_greaterThanOrEqualTo(weakSelf.contentView.mas_top).offset(5);
                   make.centerY.mas_equalTo(weakSelf.contentView);
                   );
//
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.headImageView.mas_trailing).offset(15);
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}

- (void)setCellWithModel:(JoyImageCellBaseModel *)model{
    
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);

    SDIMAGE_LOAD(self.headImageView, model.avatar,placeHolderImageStr);
    if (model.title) {
        self.titleLabel.text =  model.title;
    }
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.viewShape == EImageTypeRound) {
        self.headImageView.layer.cornerRadius = 27;
        self.headImageView.layer.masksToBounds = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
