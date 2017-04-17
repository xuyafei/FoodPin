//
//  FoodPinCycleScrollView.m
//  FoodPin
//
//  Created by polycom on 2017/4/12.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FoodPinCycleScrollView.h"

#define FP_CYCLEINDEX_CALCULATE(x,y) (x+y)%y
#define FP_DEFAULT_DURATION_TIME 2.0f
#define FP_DEFAULT_DURATION_FRAME CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,230)

@interface FoodPinCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UIImageView *middleImageView;
@property (nonatomic, weak) UIImageView *rightImageView;
@property (nonatomic, weak) UIScrollView *containerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentNumber;

@end

@implementation FoodPinCycleScrollView
- (instancetype)initWithImages:(NSArray *)images {
    return [self initWithImages:images withFrame:FP_DEFAULT_DURATION_FRAME];
}

- (instancetype)initWithImages:(NSArray *)images withFrame:(CGRect)frame {
    return [self initWithImages:images withPageViewLocation:FPCycleScrollPageViewPositionBottomCenter withPageChangeTime:FP_DEFAULT_DURATION_TIME withFrame:frame];
}

- (instancetype)initWithImages:(NSArray *)images withPageViewLocation:(FPCycleScrollPageViewPosition)pageLocation withPageChangeTime:(NSTimeInterval)changeTime withFrame:(CGRect)frame {
    self = [super init];
    
    if(self) {
        self.frame = frame;
        _images = [[NSArray alloc] initWithArray:images];
        _pageLocation = pageLocation;
        _pageChangeTime = changeTime;
        _currentNumber = 0;
        
        [self cycleViewConfig];
        [self pageControlPosition:_pageLocation];
        [self cycleImageConfig];
    }
    return self;
}

- (UIScrollView *)containerView {
    if(!_containerView) {
        UIScrollView *containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        containerView.contentSize = CGSizeMake(3 * containerView.frame.size.width, containerView.frame.size.height);
        containerView.contentOffset = CGPointMake(containerView.frame.size.width, containerView.frame.origin.y);
        containerView.backgroundColor = [UIColor grayColor];
        _containerView = containerView;
        [self addSubview:containerView];
    }
    
    return _containerView;
}

- (UIImageView *)leftImageView {
    if(!_leftImageView) {
        UIImageView *leftImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewCornerRadius:0 imageViewClipsToBounds:YES];
        _leftImageView = leftImageView;
        [self.containerView addSubview:leftImageView];
    }
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if(!_middleImageView) {
        UIImageView *middleImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewCornerRadius:0 imageViewClipsToBounds:YES];
        _middleImageView = middleImageView;
        [self.containerView addSubview:middleImageView];
    }
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if(!_rightImageView) {
        UIImageView *rightImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewCornerRadius:0 imageViewClipsToBounds:YES];
        _rightImageView = rightImageView;
        [self.containerView addSubview:_rightImageView];
    }
    return _rightImageView;
}


- (void)cycleViewConfig {
    self.containerView.scrollEnabled = YES;
    self.containerView.showsHorizontalScrollIndicator = NO;
    self.containerView.showsVerticalScrollIndicator = NO;
    self.containerView.pagingEnabled = YES;
    
    self.leftImageView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
    self.middleImageView.frame = CGRectMake(_containerView.frame.size.width, 0, _containerView.frame.size.width, _containerView.frame.size.height);
    self.rightImageView.frame = CGRectMake(2 * _containerView.frame.size.width, 0, _containerView.frame.size.width, _containerView.frame.size.height);
}

- (UIPageControl *)pageControl {
    if(!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        pageControl.currentPage = 0;
        pageControl.numberOfPages = _images.count;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    
    return _pageControl;
}

- (void)cycleImageConfig {
    if([_images count] == 0) {
        NSLog(@"image is empty!");
        return;
    }
    
    self.middleImageView.image = (UIImage *)_images[FP_CYCLEINDEX_CALCULATE(_currentNumber, _images.count)];
    self.leftImageView.image = (UIImage *)_images[FP_CYCLEINDEX_CALCULATE(_currentNumber - 1, _images.count)];
    self.rightImageView.image = (UIImage *)_images[FP_CYCLEINDEX_CALCULATE(_currentNumber + 1, _images.count)];
    
    [self timeSetter];
}

- (void)timeSetter {
    self.timer = [NSTimer timerWithTimeInterval:self.pageChangeTime target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timeChanged {
    if(_images.count == 0) {
        NSLog(@"images is empty");
        return;
    }
    
    self.currentNumber = FP_CYCLEINDEX_CALCULATE(_currentNumber + 1, _images.count);
    self.pageControl.currentPage = self.currentNumber;
    [self pageChangeAnimationType:1];
    [self changeImageViewWith:self.currentNumber];
    self.containerView.contentOffset = CGPointMake(_containerView.frame.origin.x, _containerView.frame.origin.y);
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self timeSetter];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = [self.containerView contentOffset];
    
    if(offset.x == 2 * _containerView.frame.size.width) {
        self.currentNumber = FP_CYCLEINDEX_CALCULATE(_currentNumber + 1, _images.count);
    } else if (offset.x == 0) {
        self.currentNumber = FP_CYCLEINDEX_CALCULATE(_currentNumber - 1, _images.count);
    } else {
        return;
    }
}

- (void)pageControlPosition:(FPCycleScrollPageViewPosition)position {
    if(position == FPCycleScrollPageViewPositionBottomCenter) {
        self.pageControl.frame = CGRectMake(self.center.x - 50, 30, 100, 30);
    } else if(position == FPCycleScrollPageViewPositionBottomLeft) {
        self.pageControl.frame = CGRectMake(50, self.frame.size.height - 30, 100, 30);
    } else if(position == FPCycleScrollPageViewPositionBottomRight) {
        self.pageControl.frame = CGRectMake(self.frame.size.width - 100 - 20, self.frame.size.height - 30, 100, 30);
    }
    
    self.pageControl.currentPage = self.currentNumber;
    [self changeImageViewWith:self.currentNumber];
    self.containerView.contentOffset = CGPointMake(self.containerView.frame.size.width, self.containerView.frame.origin.y);
}

- (void)changeImageViewWith:(NSInteger)imageNumber {
    self.middleImageView.image = self.images[FP_CYCLEINDEX_CALCULATE(imageNumber, self.images.count)];
    self.leftImageView.image = self.images[FP_CYCLEINDEX_CALCULATE(imageNumber - 1, self.images.count)];
    self.rightImageView.image = self.images[FP_CYCLEINDEX_CALCULATE(imageNumber + 1, self.images.count)];
}

- (void)setPageLocation:(FPCycleScrollPageViewPosition)pageLocation {
    [self pageControlPosition:pageLocation];
}

- (void)setPageChangeTime:(NSTimeInterval)pageChangeTime {
    _pageChangeTime = pageChangeTime;
    [_timer invalidate];
    [self timeSetter];
}

- (void)pageChangeAnimationType:(NSInteger)animationType {
    if(animationType == 0) {
        return;
    } else if(animationType == 1) {
        [self.containerView setContentOffset:CGPointMake(2 * self.containerView.frame.size.width, 0) animated:YES];
    } else if(animationType == 2) {
        self.containerView.contentOffset = CGPointMake(2 *self.frame.size.width, 0);
        [UIView animateWithDuration:self.pageChangeTime delay:0.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
