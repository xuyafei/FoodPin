//
//  AddPhotoTableViewCell.h
//  FoodPin
//
//  Created by xuyafei on 16/11/21.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoTableViewCell : UITableViewCell

@property(weak, nonatomic) UIImageView *photoImageView;

- (void)updateContentViewConstraints;

@end
