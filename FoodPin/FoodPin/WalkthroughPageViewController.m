//
//  WalkthroughPageViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/22.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "WalkthroughPageViewController.h"
#import "WalkthroughContentViewController.h"

@interface WalkthroughPageViewController ()<UIPageViewControllerDataSource, WalkthroughContentViewControllerDelegate> {
    NSArray *_pageHeadings;
    NSArray *_pageImages;
    NSArray *_pageContent;
}

@end

@implementation WalkthroughPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNSArrays];
    self.dataSource = self;
    [self initPageViewController];
}

- (void)initPageViewController {
    WalkthroughContentViewController *contentViewController = [self viewControllerAtIndex:0];
    if(contentViewController) {
        [self setViewControllers:@[contentViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

- (void)initNSArrays {
    _pageHeadings = @[@"Personalize", @"Locate", @"Discover"];
    _pageImages = @[@"foodpin-intro-1", @"foodpin-intro-2", @"foodpin-intro-3"];
    _pageContent = @[@"Pin your favorite restaurants and create your own food guide",
                   @"Search and locate your favourite restaurant on Maps",
                     @"Find restaurants pinned by your friends and other foodies around the world"];
}

- (WalkthroughContentViewController *)viewControllerAtIndex:(NSInteger)index {
    if(index < 0 || index >= _pageHeadings.count) {
        return nil;
    }
    
    WalkthroughContentViewController *pageContentViewController = [[WalkthroughContentViewController alloc] init];
    if(pageContentViewController) {
        pageContentViewController.delegate = self;
        pageContentViewController.imageFile = _pageImages[index];
        pageContentViewController.heading = _pageHeadings[index];
        pageContentViewController.content = _pageContent[index];
        pageContentViewController.index = index;
        
        return pageContentViewController;
    } else {
        return  nil;
    }
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((WalkthroughContentViewController *)viewController).index;
    index += 1;
    
    return [self viewControllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((WalkthroughContentViewController *)viewController).index;
    index -= 1;
    
    return [self viewControllerAtIndex:index];
}

- (void)forward:(NSInteger)index {
    WalkthroughContentViewController *nextViewController = [self viewControllerAtIndex:index+1];
    [self setViewControllers:/*@[nextViewController]*/[NSArray arrayWithObject:nextViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)setButtonIndex:(NSInteger )buttonIndex {
    if(buttonIndex == 0 || buttonIndex == 1) {
        [self forward:buttonIndex];
    } else if(buttonIndex == 2) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"hasViewedWalkthrough"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
