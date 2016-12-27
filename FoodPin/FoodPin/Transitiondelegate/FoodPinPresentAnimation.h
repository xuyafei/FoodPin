//
//  FoodPinPresentAnimation.h
//  FoodPin
//
//  Created by polycom on 2016/12/27.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FoodPinPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;

@end
