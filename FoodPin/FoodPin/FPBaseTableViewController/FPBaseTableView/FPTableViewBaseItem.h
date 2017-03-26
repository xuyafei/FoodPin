//
//  FPTableViewBaseItem.h
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT CGFloat const CellInvalidHeight;

@interface FPTableViewBaseItem : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSData *image;
@property (nonatomic, strong) NSNumber *isVisited;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *type;

- (instancetype)initWithImage:(NSData *)image isVisited:(NSNumber *)visited location:(NSString *)location name:
(NSString *)name phoneNumber:(NSString *)phoneNumber type:(NSString *)type;
@end
