//
//  Restaurant.m
//  FoodPin
//
//  Created by 永康范 on 16/11/16.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "Restaurant.h"

@interface Restaurant ()

@end

#pragma mark - Implement Restaurant

@implementation Restaurant

- (instancetype)initWithNmae:(NSString *)name type:(NSString *)type location:(NSString *)location
                       image:(NSString *)image phoneNumber:(NSString*)phoneNumber isVisited:(BOOL)isVisited {
    self = [super init];
    
    if(self) {
        self.name = name;
        self.type = type;
        self.location = location;
        self.iamge = image;
        self.phoneNumber = phoneNumber;
        self.isVisited = isVisited;
    }
    
    return self;
}

+ (instancetype)restaurantWithName:(NSString *)name type:(NSString *)type location:(NSString *)location phoneNumber:(NSString *)phoneNumber image:(NSString *)image  isVisited:(BOOL)isVisited {
    Restaurant *theRestaurant = [[Restaurant alloc] initWithNmae:name type:type location:location image:image phoneNumber:phoneNumber isVisited:isVisited];
    
    return theRestaurant;
}

@end

