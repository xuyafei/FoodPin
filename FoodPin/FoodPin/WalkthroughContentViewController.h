//
//  WalkthroughContentViewController.h
//  FoodPin
//
//  Created by xuyafei on 16/11/22.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WalkthroughContentViewControllerDelegate <NSObject>
- (void)setButtonIndex:(NSInteger )buttonIndex;
@end

@interface WalkthroughContentViewController : UIViewController
@property(nonatomic, assign) NSUInteger index;
@property(nonatomic, copy) NSString *heading;
@property(nonatomic, copy) NSString *imageFile;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, weak)id<WalkthroughContentViewControllerDelegate> delegate;
@end
