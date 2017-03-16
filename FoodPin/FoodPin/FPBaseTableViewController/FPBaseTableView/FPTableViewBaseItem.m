//
//  FPTableViewBaseItem.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPTableViewBaseItem.h"

CGFloat const CellInvalidHeight = -1;

@implementation FPTableViewBaseItem

- (instancetype)init {
    self = [self initWithImage:nil Title:nil SubTitle:nil AccessoryImage:nil];
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage {
    self = [super init];
    
    if(self) {
        _cellHeight = CellInvalidHeight;
        _itemImage = image;
        _itemTitle = title;
        _itemSubtitle = subTitle;
        _itemAccessoryImage = accessoryImage;
    }
    
    return self;
}

@end
