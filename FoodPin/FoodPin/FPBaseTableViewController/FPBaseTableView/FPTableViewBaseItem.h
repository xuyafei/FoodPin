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
@property (nonatomic, copy)   NSString *itemIdentifier;
@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, copy)   NSString *itemTitle;
@property (nonatomic, copy)   NSString *itemSubtitle;
@property (nonatomic, strong) UIImage *itemAccessoryImage;

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:
    (UIImage *)accessoryImage;
@end
