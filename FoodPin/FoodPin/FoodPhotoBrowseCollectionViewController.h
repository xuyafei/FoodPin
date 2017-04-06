//
//  FoodPhotoBrowseCollectionViewController.h
//  FoodPin
//
//  Created by polycom on 2016/12/26.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodPinPresentAnimation.h"

@interface FoodPhotoBrowseCollectionViewController : UICollectionViewController

@property(nonatomic, strong) NSData *image;
@property(nonatomic, strong) FoodPinPresentAnimation *presentAnimation;

@end
