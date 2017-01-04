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

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
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
    UIView *destinationView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    if(!containerView) {
        return;
    }
    [containerView addSubview:destinationView];
    
    FoodPinRootViewController *fromRootViewController = (FoodPinRootViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RestaurantDetailViewController *fromViewController = fromRootViewController.favoritesNav.viewControllers[1];
    
    UIImageView *currentImageView  = fromViewController.headView;
    UIImageView *annimateView = [[UIImageView alloc] init];
    annimateView.image = currentImageView.image;
    annimateView.contentMode = UIViewContentModeScaleAspectFill;
    annimateView.clipsToBounds = YES;
    
    CGRect originFrame = [currentImageView convertRect:currentImageView.frame toView:[UIApplication sharedApplication].keyWindow];
    annimateView.frame = originFrame;
    [containerView addSubview:annimateView];
    
    CGRect endFrame = coverImageFrameToFullScreenFrame(currentImageView.image);
    destinationView.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        annimateView.frame = endFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [UIView animateWithDuration:0.5 animations:^{
            destinationView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [annimateView removeFromSuperview];
        }];
    }];
}

- (void) dissmissViewAnimation:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *transitionView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *contentView = transitionContext.containerView;
    
    FoodPhotoBrowseCollectionViewController *destinationController = (FoodPhotoBrowseCollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UICollectionView *presentView = destinationController.collectionView;
    FoodPhotoBrowserCollectionViewCell *dismissCell = (FoodPhotoBrowserCollectionViewCell *)presentView.visibleCells[0];
    UIImageView *animateImageView = [[UIImageView alloc] init];
    animateImageView.contentMode = UIViewContentModeScaleAspectFill;
    animateImageView.clipsToBounds = YES;
    animateImageView.image = dismissCell.photoImageView.image;
    animateImageView.frame = dismissCell.photoImageView.frame;
    [contentView addSubview:animateImageView];
    
    FoodPinRootViewController *fromRootViewController = (FoodPinRootViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    RestaurantDetailViewController *fromViewController = fromRootViewController.favoritesNav.viewControllers[1];
    
    UIView *originView = fromViewController.headView;
    CGRect originFrame = [originView convertRect:originView.frame toView:[UIApplication sharedApplication].keyWindow];
    
    [UIView animateWithDuration:1.0 animations:^{
        animateImageView.frame = originFrame;
        transitionView.alpha = 1.0;
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
