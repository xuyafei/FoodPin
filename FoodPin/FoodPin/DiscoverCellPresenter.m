//
//  DiscoverCellPresenter.m
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "DiscoverCellPresenter.h"

@implementation DiscoverCellPresenter

+ (instancetype)presenterWithPorperty:(CKRecord *)result {
    DiscoverCellPresenter *presenter = [DiscoverCellPresenter new];
    presenter.name = [result objectForKey:@"name"];
    presenter.type = [result objectForKey:@"type"];
    presenter.location = [result objectForKey:@"location"];
    CKAsset *imageAsset = [result objectForKey:@"image"];
    presenter.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:imageAsset.fileURL]];
    
    return presenter;
}
@end
