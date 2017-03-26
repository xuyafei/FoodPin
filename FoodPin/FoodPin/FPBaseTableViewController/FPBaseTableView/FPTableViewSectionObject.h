//
//  FPTableViewSectionObject.h
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPTableViewSectionObject : NSObject

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, strong) NSMutableArray *items;

- (instancetype)initWithItemArray: (NSMutableArray *)items;

@end
