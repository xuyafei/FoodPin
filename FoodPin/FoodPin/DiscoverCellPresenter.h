//
//  DiscoverCellPresenter.h
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>

@interface DiscoverCellPresenter : NSObject

@property (nonatomic, copy)UIImage  *image;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *location;
@property (nonatomic, copy)NSString *type;

- (CKRecord *)draft;

+ (instancetype)presenterWithPorperty:(CKRecord *)result;

@end
