//
//  RestaurantDetailTableViewCell.m
//  FoodPin
//
//  Created by 永康范 on 16/11/16.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "RestaurantDetailTableViewCell.h"
#import "Masonry.h"

@implementation RestaurantDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.filedLabel = [[UILabel alloc] init];
        self.filedLabel.font = [UIFont systemFontOfSize:16.0];
        self.filedLabel.numberOfLines = 0;
        CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 100 - 15;
        self.filedLabel.preferredMaxLayoutWidth = preferredMaxWidth;
        [self.contentView addSubview:self.filedLabel];
        
        [self.filedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.left.mas_equalTo(self.nameLabel.mas_right);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.filedLabel.mas_centerY);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(100);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.filedLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
