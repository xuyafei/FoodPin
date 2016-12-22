//
//  RestaurantTableViewCell.h
//  FoodPin
//
//  Created by xuyafei on 16/11/15.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *thumbnailImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *locationLabel;
@property (nonatomic, strong)UILabel *typeLabel;

@end
