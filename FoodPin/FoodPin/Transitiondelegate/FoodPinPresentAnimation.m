//
//  FoodPinPresentAnimation.m
//  FoodPin
//
//  Created by polycom on 2016/12/27.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "FoodPinPresentAnimation.h"
#import "FoodPinRootViewController.h"
#import "RestaurantDetailViewController.h"
#import "FoodPhotoBrowseCollectionViewController.h"
#import "FoodPhotoBrowserCollectionViewCell.h"

@implementation FoodPinPresentAnimation

- (id)init {
    self = [super init];
    
    if(self) {
        self.isPresentAnimationing = YES;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPresentAnimationing) {
        [self presentViewAnimation:transitionContext];
        self.isPresentAnimationing = NO;
    } else {
        [self dissmissViewAnimation:transitionContext];
        self.isPresentAnimationing = YES;
    }
}

- (void)presentViewAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    FoodPinRootViewController *fromRootViewController = (FoodPinRootViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RestaurantDetailViewController *fromeViewController = fromRootViewController.favoritesNav.viewControllers[1];
    FoodPhotoBrowseCollectionViewController *toViewController = (FoodPhotoBrowseCollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIImageView *currentImageView = fromeViewController.headView;
    UIView *containerView = [transitionContext containerView];
    
    //currentImageView.hidden = YES;
    toViewController.view.alpha = 0.0;
    CGRect endFrame = coverImageFrameToFullScreenFrame(currentImageView.image);
    UIImageView *animateImageView = [[UIImageView alloc] init];
    animateImageView.image = currentImageView.image;
    animateImageView.contentMode = UIViewContentModeScaleAspectFill;
    animateImageView.clipsToBounds = YES;
    animateImageView.frame = [currentImageView convertRect:currentImageView.bounds toView:containerView];
    [containerView addSubview:toViewController.view];
    [containerView addSubview:animateImageView];
    
    [UIView animateWithDuration:1.0 animations:^{
        animateImageView.frame = endFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            toViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            [animateImageView removeFromSuperview];
        }];
    }];
}

- (void) dissmissViewAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = transitionContext.containerView;
    
    FoodPhotoBrowseCollectionViewController *fromViewController = (FoodPhotoBrowseCollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UICollectionView *fromView = fromViewController.collectionView;
 
    FoodPhotoBrowserCollectionViewCell *dismissCell = (FoodPhotoBrowserCollectionViewCell *)fromView.visibleCells[0];
    UIImageView *animateImageView = [[UIImageView alloc] init];
    animateImageView.contentMode = UIViewContentModeScaleAspectFill;
    animateImageView.clipsToBounds = YES;
    animateImageView.image = dismissCell.photoImageView.image;
    animateImageView.frame = dismissCell.photoImageView.frame;
    [contentView addSubview:animateImageView];
    
    FoodPinRootViewController *fromRootViewController = (FoodPinRootViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    RestaurantDetailViewController *toViewController = fromRootViewController.favoritesNav.viewControllers[1];
    
    UIView *originView = toViewController.headView;
    CGRect originFrame = [originView convertRect:originView.frame toView:[UIApplication sharedApplication].keyWindow];
    
    [UIView animateWithDuration:1.0 animations:^{
        animateImageView.frame = originFrame;
    } completion:^(BOOL finished) {
        [animateImageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

CGRect coverImageFrameToFullScreenFrame(UIImage *image) {
    if(!image) {
        return CGRectZero;
    }
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height * 0.5;
    CGFloat x = 0;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - h) * 0.5;
    
    return CGRectMake(x, y, w, h);
}


@end
