//
//  FPAlertController.m
//  FoodPin
//
//  Created by polycom on 2017/1/4.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FPAlertController.h"

@interface FPAlertActionModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UIAlertActionStyle style;

@end

@implementation FPAlertActionModel

- (instancetype)init {
    if(self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    
    return self;
}

@end

typedef void (^FPAlertActionsConfig)(FPAlertActionBlock actionBlock);

@interface FPAlertController()

@property (nonatomic, strong) NSMutableArray <FPAlertActionModel *> *fp_alertActionArray;
@property (nonatomic, assign) BOOL fp_setAlertAnimated;

- (FPAlertActionsConfig)alertActionConfig;

@end

@implementation FPAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if(self.alertDidDissmiss) {
        self.alertDidDissmiss();
    }
}

- (void)dealloc {
    NSLog(@"print something");
}

- (NSMutableArray<FPAlertActionModel *> *)fp_alertActionArray {
    if(!_fp_alertActionArray) {
        _fp_alertActionArray = [NSMutableArray array];
    }
    
    return _fp_alertActionArray;
}

- (FPAlertActionsConfig)alertActionConfig {
    return ^(FPAlertActionBlock actionBlock) {
        if(self.fp_alertActionArray.count > 0) {
            __weak typeof(self)weakSelf = self;
            [self.fp_alertActionArray enumerateObjectsUsingBlock:^(FPAlertActionModel * actionModel, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionModel.title style:actionModel.style handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    
                    if(actionBlock) {
                        actionBlock(idx, action, strongSelf);
                    }
                }];
                [self addAction:alertAction];
            }];
        }
    };
}

- (instancetype)initAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    if(!(title.length > 0) && (message.length > 0) && (preferredStyle == UIAlertControllerStyleAlert)) {
        title = @"";
    }
    
    self = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    self.fp_setAlertAnimated = NO;
    
    return self;
}

- (void)alertAnimateDisabled {
    self.fp_setAlertAnimated = YES;
}

- (FPAlertActionTitle)addActionDefaultTitle {
    return ^(NSString *title) {
        FPAlertActionModel *actionModel = [[FPAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.fp_alertActionArray addObject:actionModel];
        return self;
    };
}

- (FPAlertActionTitle)addActionCancelTitle {
    return ^(NSString *title) {
        FPAlertActionModel *actionModel = [[FPAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleCancel;
        [self.fp_alertActionArray addObject:actionModel];
        return self;
    };
}

- (FPAlertActionTitle)addActionDestructiveTitle {
    return ^(NSString *title) {
        FPAlertActionModel *actionModel = [[FPAlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDestructive;
        [self.fp_alertActionArray addObject:actionModel];
        return self;
    };
}

@end

@implementation UIViewController (FPAlertController)

- (void)fp_showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(FPAlertAppearanceProcess)appearanceProcess actionsBlock:(FPAlertActionBlock)actionBlock {
    if(appearanceProcess) {
        FPAlertController *alertMaker = [[FPAlertController alloc] initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        
        if(!alertMaker) {
            return;
        }
        
        appearanceProcess(alertMaker);
        alertMaker.alertActionConfig(actionBlock);
        
        if(alertMaker.alertDidShown) {
            [self presentViewController:alertMaker animated:!(alertMaker.fp_setAlertAnimated) completion:^{
                alertMaker.alertDidShown();
            }];
        } else {
            [self presentViewController:alertMaker animated:!(alertMaker.fp_setAlertAnimated) completion:nil];
        }
    }
}

- (void)fp_showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(FPAlertAppearanceProcess)appearanceProcess acitonsBlock:(FPAlertActionBlock)acitonBlock {
    [self fp_showAlertWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:acitonBlock];
}

@end
