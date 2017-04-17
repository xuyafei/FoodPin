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
}

- (void)configView {
    self.cycleScrollView.backgroundColor = [UIColor grayColor];
    self.personImageView.backgroundColor = [UIColor redColor];
}
@end
