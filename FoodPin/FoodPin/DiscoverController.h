//
//  DiscoverController.h
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodPinUserAPIManager.h"
#import "DiscoverPresenter.h"

@interface DiscoverController : NSObject

@property (strong, nonatomic) UITableView *discoverTableView;

+ (instancetype)inistanceWithPresenter:(DiscoverPresenter *)presenter;

- (void)fetchDataWithCompletionHander:(CloudworkCompletionHandler)completionHander;

- (void)setDidSelectedRowHandler:(void (^)(CKRecord*))didSelectedRowHandler;

@end
