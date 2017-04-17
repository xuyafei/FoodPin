//
//  FoodPinDiscoverTitleView.m
//  FoodPin
//
//  Created by polycom on 2017/4/14.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FoodPinDiscoverTitleView.h"

@implementation FoodPinDiscoverTitleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self configTitleView];
    }
    
    return self;
}

- (UIImageView *)personImageView {
    if(!_personImageView) {
        UIImageView *personImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewCornerRadius:30 imageViewClipsToBounds:YES];
        [self addSubview:personImageView];
        _personImageView = personImageView;
    }
    return _personImageView;
}

- (void)configTitleView {
    self.personImageView.backgroundColor = [UIColor whiteColor];
    [self.personImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(-30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
}

@end
