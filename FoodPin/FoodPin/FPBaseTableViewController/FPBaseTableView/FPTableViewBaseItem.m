//
//  FPTableViewBaseItem.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPTableViewBaseItem.h"

CGFloat const CellInvalidHeight = -1;

@implementation FPTableViewBaseItem

- (instancetype)init {
    self = [self initWithImage:nil isVisited:nil location:nil name:nil phoneNumber:nil type:nil];
    
    return self;
}


- (instancetype)initWithImage:(NSData *)image isVisited:(NSNumber *)visited location:(NSString *)location name:
(NSString *)name phoneNumber:(NSString *)phoneNumber type:(NSString *)type {
    self = [super init];
    
    if(self) {
        _cellHeight = CellInvalidHeight;
        _image = image;
        _isVisited = visited;
        _location = location;
        _name = name;
        _phoneNumber = phoneNumber;
        _type = type;
    }
    return self;
}

@end
