//
//  FoodPinCycleScrollView.m
//  FoodPin
//
//  Created by polycom on 2017/4/12.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FoodPinCycleScrollView.h"

#define FP_CYCLEINDEX_CALCULATE(x,y) (x+y)%y
#define FP_DEFAULT_DURATION_TIME 2.0f
#define FP_DEFAULT_DURATION_FRAME CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/4)

@interface FoodPinCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIScrollView *containerView;
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
        [self pageControlConfig];
        [self cycleImageConfig];
    }
    return self;
}

- (void)cycleViewConfig {
    self.containerView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.containerView.contentSize = CGSizeMake(3 * _containerView.frame.size.width, _containerView.frame.size.height);
    self.containerView.contentOffset = CGPointMake(_containerView.frame.size.width, _containerView.frame.origin.y);
    self.containerView.backgroundColor = [UIColor grayColor];
    
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height)];
    self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_containerView.frame.size.width, 0, _containerView.frame.size.width, _containerView.frame.size.height)];
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * _containerView.frame.size.width, 0, _containerView.frame.size.width, _containerView.frame.size.height)];
    
    self.containerView.delegate = self;
    [self.containerView addSubview:self.leftImageView];
    [self.containerView addSubview:self.rightImageView];
    [self.containerView addSubview:self.middleImageView];
    
    self.containerView.scrollEnabled = YES;
    self.containerView.showsHorizontalScrollIndicator = NO;
    self.containerView.showsVerticalScrollIndicator = NO;
    self.containerView.pagingEnabled = YES;
    
    [self addSubview:self.containerView];
}

- (void)pageControlConfig {
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPage = 0;
    [self pageControlPosition:_pageLocation];
    _pageControl.numberOfPages = _images.count;
}

- (void)cycleImageConfig {
    if([_images count] == 0) {
        NSLog(@"image is empty!");
        return;
    }
    
    _middleImageView.image = (UIImage *)_images[FP_CYCLEINDEX_CALCULATE(_currentNumber, _images.count)];
    _leftImageView.image = (UIImage *)_images[FP_CYCLEINDEX_CALCULATE(_currentNumber - 1, _images.count)];
    _rightImageView.image = (UIImage *)_images[FP_CYCLEINDEX_CALCULATE(_currentNumber + 1, _images.count)];
    
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
        _pageControl.frame = CGRectMake(self.center.x - 50, self.frame.size.height - 30, 100, 30);
    } else if(position == FPCycleScrollPageViewPositionBottomLeft) {
        _pageControl.frame = CGRectMake(50, self.frame.size.height - 30, 100, 30);
    } else if(position == FPCycleScrollPageViewPositionBottomRight) {
        _pageControl.frame = CGRectMake(self.frame.size.width - 100 - 20, self.frame.size.height - 30, 100, 30);
    }
    
    self.pageControl.currentPage = self.currentNumber;
    [self changeImageViewWith:self.currentNumber];
    self.containerView.contentOffset = CGPointMake(_containerView.frame.size.width, _containerView.frame.origin.y);
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
