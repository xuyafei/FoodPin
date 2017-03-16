//
//  FPTableViewBaseCell.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPTableViewBaseCell.h"
#import "FPTableViewBaseItem.h"

@implementation FPTableViewBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//子类在这个方法中解析数据
- (void)setObject:(FPTableViewBaseItem *)object {
    self.imageView.image = object.itemImage;
    self.textLabel.text = object.itemTitle;
    self.detailTextLabel.text = object.itemSubtitle;
    self.accessoryView = [[UIImageView alloc] initWithImage:object.itemAccessoryImage];
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(FPTableViewBaseItem *)object {
    return 44.0f;
}

@end
