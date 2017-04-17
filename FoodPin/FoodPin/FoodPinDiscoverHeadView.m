//
//  FoodPinDiscoverHeadView.m
//  FoodPin
//
//  Created by polycom on 2017/4/15.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FoodPinDiscoverHeadView.h"

@interface FoodPinDiscoverHeadView()

@property (nonatomic, strong) NSMutableArray *imagesArray;

@end

@implementation FoodPinDiscoverHeadView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self configArrays];
        [self configView];
        [self configDiscoverHeadView];
    }
    return self;
}

- (FoodPinCycleScrollView *)cycleScrollView {
    if(!_cycleScrollView) {
         FoodPinCycleScrollView *cycleScrollView = [[FoodPinCycleScrollView alloc] initWithImages:self.imagesArray];
        [self addSubview:cycleScrollView];
        _cycleScrollView = cycleScrollView;
    }
    return _cycleScrollView;
}

- (UIImageView *)personImageView {
    if(!_personImageView) {
        UIImageView *personImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewCornerRadius:30 imageViewClipsToBounds:YES];
        [self addSubview:personImageView];
        _personImageView = personImageView;
    }
    return _personImageView;
}

- (UILabel *)hostLabel {
    if(!_hostLabel) {
        UILabel *hostLabel = [FPPublicUIKit labelWithTextColor:[UIColor redColor] numberOfLines:1 text:@"AT MARIE-CLAUDE'S" labelFont:[UIFont systemFontOfSize:13.0]];
        [self addSubview:hostLabel];
        _hostLabel = hostLabel;
    }
    
    return _hostLabel;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        UILabel *nameLabel = [FPPublicUIKit labelWithTextColor:[UIColor blackColor] numberOfLines:1 text:@"A Seasonal French Experience" labelFont:[UIFont systemFontOfSize:20.0]];
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

- (UIImageView *)slideImageView {
    if(!_slideImageView) {
        UIImageView *slideImageView = [[UIImageView alloc] init];
        slideImageView.backgroundColor = [UIColor grayColor];
        [self addSubview:slideImageView];
        _slideImageView = slideImageView;
    }
    return _slideImageView;
}

- (UILabel *)locationLable {
    if(!_locationLable) {
        UILabel *locationLable = [FPPublicUIKit labelWithTextColor:[UIColor blackColor] numberOfLines:1 text:@"Firenze, Italie" labelFont:[UIFont systemFontOfSize:14.0]];
        [self addSubview:locationLable];
        _locationLable = locationLable;
    }
    
    return _locationLable;
}

- (UILabel *)priceLabel {
    if(!_priceLabel) {
        UILabel *priceLabel = [FPPublicUIKit labelWithTextColor:[UIColor redColor] numberOfLines:1 text:@"36 $" labelFont:[UIFont systemFontOfSize:16.0]];
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return _priceLabel;
}

- (UIButton *)mapButton {
    if(!_mapButton) {
        UIButton *mapButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor redColor] buttonType:UIButtonTypeSystem buttonTintColor:[UIColor whiteColor] buttonCornerRadius:0 buttonWithImage:[[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [mapButton addTarget:self action:@selector(clickMap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mapButton];
        _mapButton = mapButton;
    }
    return _mapButton;
}

- (UILabel *)numberLabel {
    if(!_numberLabel) {
        UILabel *numberLabel = [FPPublicUIKit labelWithTextColor:[UIColor blackColor] numberOfLines:1.0 text:@"per guest" labelFont:[UIFont systemFontOfSize:14.0]];
        [self addSubview:numberLabel];
        _numberLabel = numberLabel;
    }
    return _numberLabel;
}

- (void)configArrays {
    NSArray *array = @[@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg",@"cafeloisl.jpg", @"petiteoyster.jpg"];
    self.imagesArray = [NSMutableArray array];
    for(NSString *imageString in array) {
        UIImage *image = [UIImage imageNamed:imageString];
        [self.imagesArray addObject:image];
    }
}

- (void)configDiscoverHeadView {
    [self.personImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(-40);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.hostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.personImageView.mas_bottom).offset(10);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.hostLabel.mas_bottom).offset(10);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.slideImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.locationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.right.mas_equalTo(self.slideImageView.mas_left).offset(-30);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.mapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.locationLable.mas_centerY);
        make.right.mas_equalTo(self.locationLable.mas_left).offset(-5);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.locationLable.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX).offset(ScreenWidth / 4);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.priceLabel.mas_centerX);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(10);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
}

- (void)configView {
    self.cycleScrollView.backgroundColor = [UIColor grayColor];
    self.personImageView.backgroundColor = [UIColor redColor];
}
@end
