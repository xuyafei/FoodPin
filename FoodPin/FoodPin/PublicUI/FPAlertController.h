//
//  FPAlertController.h
//  FoodPin
//
//  Created by polycom on 2017/1/4.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class FPAlertController;

typedef FPAlertController * _Nonnull (^FPAlertActionTitle)(NSString *title);
typedef void (^FPAlertActionBlock)(NSInteger buttonIndex, UIAlertAction *aciton, FPAlertController *alertSelf);

@interface FPAlertController : UIAlertController

@property (nullable, nonatomic, copy) void (^alertDidShown)();
@property (nullable, nonatomic, copy) void (^alertDidDissmiss)();

- (FPAlertActionTitle)addActionDefaultTitle;
- (FPAlertActionTitle)addActionCancelTitle;
- (FPAlertActionTitle)addActionDestructiveTitle;

@end

typedef void(^FPAlertAppearanceProcess)(FPAlertController *alertMaker);

@interface UIViewController (FPAlertController)

- (void)fp_showAlertWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
            appearanceProcess:(FPAlertAppearanceProcess)appearanceProcess
                 acitonsBlock:(nullable FPAlertActionBlock)acitonBlock;

@end

NS_ASSUME_NONNULL_END
