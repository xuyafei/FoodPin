//
//  FPTableViewSectionObject.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPTableViewSectionObject.h"

@implementation FPTableViewSectionObject

- (instancetype)init {
    self = [super init];
    if(self) {
        self.headerTitle = @"";
        self.footerTitle = @"";
        self.items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (instancetype)initWithItemArray:(NSMutableArray *)items {
    self = [self init];
    
    if(self) {
        [self.items addObjectsFromArray:items];
    }
    
    return self;
}

@end
