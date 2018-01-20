//
//  JoyNoDataBackView.m
//  Toon
//
//  Created by wangguopeng on 16/9/1.
//  Copyright © 2016年 Joy. All rights reserved.
//

#import "JoyNoDataBackView.h"
#import "Joy.h"

@interface JoyNoDataBackView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *label;
@end

static const float imageViewCenterOffSet = -125.0;
static const float imageViewWidHeight = 70.0;
static const float labelTopOffSet = 20;

@implementation JoyNoDataBackView

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        [self setConstraint];
    }
    return self;
}

#pragma mark constraint config
- (void)setConstraint{
    MAS_CONSTRAINT(self.imageView, make.centerY.mas_equalTo(self.mas_centerY).mas_offset(imageViewCenterOffSet);
                   make.centerX.mas_equalTo(self.mas_centerX);
                   make.width.height.mas_equalTo(imageViewWidHeight);
                   );
    
    MAS_CONSTRAINT(self.label, make.top.mas_equalTo(self.imageView.mas_bottom).offset(labelTopOffSet);
                   make.leading.mas_equalTo(self.mas_leading);
                   make.trailing.mas_equalTo(self.mas_trailing);
                   );
}

#pragma mark lazy loading
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = JOY_orangeColor;
    }
    return _label;
}


-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [self.imageView setImage:[UIImage imageNamed:imageStr]];
}

-(void)setLabelStr:(NSString *)labelStr{
    _labelStr = labelStr;
    self.label.text = labelStr;
}
@end
