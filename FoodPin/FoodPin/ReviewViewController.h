//
//  ReviewViewController.h
//  FoodPin
//
//  Created by xuyafei on 16/11/18.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReviewViewDelegate <NSObject>
- (void)setButtonImage:(NSString *)buttonBackgoundImage;
@end

@interface ReviewViewController : UIViewController
@property(nonatomic, weak)id<ReviewViewDelegate> delegate;
@end
