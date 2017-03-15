//
//  RestaurantTableViewCell.h
//  FoodPin
//
//  Created by xuyafei on 16/11/15.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView *thumbnailImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UILabel *typeLabel;

@end
