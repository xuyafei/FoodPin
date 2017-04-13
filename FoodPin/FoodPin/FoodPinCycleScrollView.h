//
//  FoodPinCycleScrollView.h
//  FoodPin
//
//  Created by polycom on 2017/4/12.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, FPCycleScrollPageViewPosition) {
    FPCycleScrollPageViewPositionBottomLeft = 0,
    FPCycleScrollPageViewPositionBottomCenter = 1,
    FPCycleScrollPageViewPositionBottomRight = 2,
};

@interface FoodPinCycleScrollView : UIView

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) NSTimeInterval pageChangeTime;
@property (nonatomic, assign) FPCycleScrollPageViewPosition pageLocation;

- (instancetype)initWithImages:(NSArray *)images;
- (instancetype)initWithImages:(NSArray *)images withFrame:(CGRect)frame;
- (instancetype)initWithImages:(NSArray *)images withPageViewLocation:(FPCycleScrollPageViewPosition)pageLocation
            withPageChangeTime:(NSTimeInterval)changeTime withFrame:(CGRect)frame;
@end
