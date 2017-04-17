//
//  RestaurantHelper.h
//  FoodPin
//
//  Created by polycom on 2017/3/17.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantHelper : NSObject

@property(nonatomic, strong) NSMutableArray *testArray;
@property (nonatomic, strong) NSManagedObjectContext *restaurantMOC;

- (void)createTestCoreData;
@end
