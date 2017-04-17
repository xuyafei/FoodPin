//
//  FoodPinDiscoverHeadView.h
//  FoodPin
//
//  Created by polycom on 2017/4/15.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodPinCycleScrollView.h"

@interface FoodPinDiscoverHeadView : UIView

@property (nonatomic, weak) FoodPinCycleScrollView *cycleScrollView;
@property (nonatomic, weak) UIImageView *personImageView;
@property (nonatomic, weak) UILabel *hostLabel;
@property (nonatomic, weak) UILabel *locationLable;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *numberLabel;
@property (nonatomic, weak) UIImageView *slideImageView;

@end
