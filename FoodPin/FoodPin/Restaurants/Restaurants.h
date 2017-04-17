//
//  Restaurants.h
//  FoodPin
//
//  Created by polycom on 2016/12/24.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurants : NSObject {
}
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSString *iamge;
@property(nonatomic, copy) NSString *phoneNumber;
@property(nonatomic, assign) BOOL   isVisited;

- (id)initWithNmae:(NSString *)name
              type:(NSString *)type
          location:(NSString *)location
             image:(NSString *)image
       phoneNumber:(NSString *)phoneNumber
         isVisited:(BOOL)isVisited;

+ (instancetype)restaurantWithName:(NSString *)name
                              type:(NSString *)type
                          location:(NSString *)location
                       phoneNumber:(NSString *)phoneNumber
                             image:(NSString *)image
                         isVisited:(BOOL)isVisited;

@end
