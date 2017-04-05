//
//  DiscoverPresenter.h
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodPinUserAPIManager.h"
#import "DiscoverCellPresenter.h"

@interface DiscoverPresenter : NSObject

+ (instancetype)presentWithUserId:(NSUInteger)userID;
- (NSArray<DiscoverPresenter *> *)allDatas;
- (void)refreshDataPage:(NSInteger)page withRequireArray:(NSArray *)array WithCompletionHandler:(CloudworkCompletionHandler)completionHander;
@end
