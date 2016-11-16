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
        [self.contentView addSubview:self.filedLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo([[UIScreen mainScreen] bounds].size.width/2);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.filedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.left.mas_equalTo(self.nameLabel.mas_right);
            make.width.mas_equalTo([[UIScreen mainScreen] bounds].size.width/2);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
