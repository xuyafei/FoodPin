//
//  RestaurantTableViewCell.m
//  FoodPin
//
//  Created by xuyafei on 16/11/15.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "RestaurantTableViewCell.h"
#import "Masonry.h"
@interface RestaurantTableViewCell()

@end

@implementation RestaurantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.thumbnailImageView = [[UIImageView alloc] init];
        self.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
        self.thumbnailImageView.layer.cornerRadius = 30.0;
        self.thumbnailImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.thumbnailImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        UIFontDescriptor *bodyFontDesciptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline];
        self.nameLabel.font = [UIFont fontWithDescriptor:bodyFontDesciptor size:0.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.locationLabel = [[UILabel alloc] init];
        self.locationLabel.font = [UIFont fontWithName:@"Systom-Light" size:14.0];
        self.locationLabel.textColor = [UIColor darkGrayColor];
        self.locationLabel.numberOfLines = 0;
        CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 60 - 10 - 5 - 14;
        self.locationLabel.preferredMaxLayoutWidth = preferredMaxWidth;
        [self.contentView addSubview:self.locationLabel];
        
        self.typeLabel = [[UILabel alloc] init];
        self.typeLabel.font = [UIFont fontWithName:@"Systom-Light" size:13.0];
        [self.contentView addSubview:self.typeLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(self.contentView.mas_left).offset(84);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
            make.left.mas_equalTo(self.contentView.mas_left).offset(84);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(2);
            make.left.mas_equalTo(self.contentView.mas_left).offset(84);
            make.bottom.mas_equalTo(self.typeLabel.mas_top).offset(-2);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        }];
        
        [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.centerY.mas_equalTo(self.locationLabel.mas_centerY);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
