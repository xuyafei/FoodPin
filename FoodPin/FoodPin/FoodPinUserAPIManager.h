//
//  FoodPinUserAPIManager.h
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CloudworkCompletionHandler)(NSError *error, id result);
typedef UIViewController *(^ViewControllerGenerator)(id params);

typedef enum : NSUInteger {
    CloudworkErrorNoData,
    CloudworkErrorNoMoreData
} CloudworkError;

@interface FoodPinUserAPIManager : NSObject

- (void)fetchWithPage:(NSInteger)page withRequireArray:(NSArray *)array CompletionHandler:(CloudworkCompletionHandler)completionHandler;
- (void)refreshWithPage:(NSInteger)page withRequireArray:(NSArray *)array completionHandler:(CloudworkCompletionHandler)completionHandler;

@end
