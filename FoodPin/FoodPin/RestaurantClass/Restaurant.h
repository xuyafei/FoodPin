//
//  Restaurant.h
//  FoodPin
//
//  Created by 永康范 on 16/11/16.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Restaurant : NSObject {
}
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSString *iamge;
@property(nonatomic, assign) BOOL   isVisited;

- (id)initWithNmae:(NSString *)name
              type:(NSString *)type
          location:(NSString *)location
             image:(NSString *)image
         isVisited:(BOOL)isVisited;

+ (instancetype)restaurantWithName:(NSString *)name
                              type:(NSString *)type
                          location:(NSString *)location
                             image:(NSString *)image
                         isVisited:(BOOL)isVisited;

@end

