//
//  FPTableViewBaseCell.h
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FPTableViewBaseItem;

@interface FPTableViewBaseCell : UITableViewCell

@property (nonatomic, strong) id object;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(FPTableViewBaseItem *)object;

@end
