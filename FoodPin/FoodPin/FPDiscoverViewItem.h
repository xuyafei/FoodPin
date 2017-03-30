//
//  FPDiscoverViewItem.h
//  FoodPin
//
//  Created by polycom on 2017/3/30.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPTableViewBaseItem.h"

@interface FPDiscoverViewItem : FPTableViewBaseItem

//@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSData *discoverImage;
@property (nonatomic, copy)   NSString *discoverLocation;
@property (nonatomic, copy)   NSString *discoverName;
@property (nonatomic, copy)   NSString *discoverType;

- (instancetype)initWithDiscoverImage:(NSData *)image withDiscoverLocation:(NSString *)location withDiscoverName:(NSString *)name withDiscoverType:(NSString *)type;

@end
