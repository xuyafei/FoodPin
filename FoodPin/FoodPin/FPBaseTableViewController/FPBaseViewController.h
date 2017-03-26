//
//  FPBaseViewController.h
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPBaseTableView.h"

@class FPTableViewDataSource;

@protocol FPTableViewControllerDelegate <NSObject>

@required

- (void)createDataSource;

@end

@interface FPBaseViewController : UIViewController<FPTableViewDelegate, FPTableViewControllerDelegate>

@property (nonatomic, weak)   FPBaseTableView *tableView;
@property (nonatomic, strong) FPTableViewDataSource *dataSource;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
