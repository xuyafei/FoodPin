//
//  FPDiscoverViewItem.m
//  FoodPin
//
//  Created by polycom on 2017/3/30.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPDiscoverViewItem.h"

@implementation FPDiscoverViewItem

- (instancetype)initWithDiscoverImage:(NSData *)image withDiscoverLocation:(NSString *)location withDiscoverName:(NSString *)name withDiscoverType:(NSString *)type {
    self = [super init];
    
    if(self) {
        _discoverImage = image;
        _discoverLocation = location;
        _discoverName = name;
        _discoverType = type;
    }
    return self;
}

@end
