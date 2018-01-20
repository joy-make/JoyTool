//
//  JoyLeftLabelRightIconCell.m
//  Toon
//
//  Created by wangguopeng on 16/5/11.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyLeftLabelRightIconCell.h"
#import "JoyCellBaseModel.h"
#import "joy.h"

@interface JoyLeftLabelRightIconCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageVIew;
@end
@implementation JoyLeftLabelRightIconCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageVIew];
        [self.contentView addSubview:self.titleLabel];
        [self setConstraint];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(UIImageView *)imageVIew{
    return _imageVIew =  _imageVIew?: [[UIImageView alloc]initWithFrame:CGRectZero];
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
    MAS_CONSTRAINT(self.imageVIew,
                   make.trailing.mas_equalTo(weakSelf.contentView).offset(-15);
                   make.width.mas_equalTo(weakSelf.imageVIew.mas_height);
                   make.height.mas_lessThanOrEqualTo(34);
                   make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(8);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
    
    MAS_CONSTRAINT(self.titleLabel,
                   make.leading.mas_equalTo(weakSelf.contentView).offset(15);
                   make.trailing.mas_equalTo(weakSelf.imageVIew.mas_leading).offset(-15);
                   make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
                   );
}


- (void)setCellWithModel:(JoyImageCellBaseModel *)model{
    self.titleLabel.text = model.title;
    NSString *placeHolderImageStr = JOY_GETBUNDLE_PATH(model.avatarBundleName,model.placeHolderImageStr);

    SDIMAGE_LOAD(self.imageVIew, model.avatar, placeHolderImageStr);
    if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }
    if (model.viewShape == EImageTypeRound) {
        self.imageVIew.layer.masksToBounds = YES;
        self.imageVIew.layer.cornerRadius =self.imageVIew.frame.size.height/2;
    }else{
        self.imageVIew.layer.masksToBounds = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
