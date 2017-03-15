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
        [self configView];
    }

    return self;
}

- (UIImageView *)thumbnailImageView {
    if(!_thumbnailImageView) {
        UIImageView *thumbnailImageView = [[UIImageView alloc] init];
        _thumbnailImageView = thumbnailImageView;
        thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
        thumbnailImageView.layer.cornerRadius = 30.0;
        thumbnailImageView.clipsToBounds = YES;
        [self.contentView addSubview:thumbnailImageView];
    }
    return _thumbnailImageView;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc] init];
        _nameLabel = nameLabel;
        UIFontDescriptor *bodyFontDesciptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline];
        nameLabel.font = [UIFont fontWithDescriptor:bodyFontDesciptor size:0.0];
        [self.contentView addSubview:nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if(!_typeLabel) {
        UILabel *typeLabel = [[UILabel alloc] init];
        _typeLabel = typeLabel;
        typeLabel.font = [UIFont fontWithName:@"Systom-Light" size:13.0];
        [self.contentView addSubview:typeLabel];
    }
    return _typeLabel;
}

- (UILabel *)locationLabel {
    if(!_locationLabel) {
        UILabel *locationLabel = [[UILabel alloc] init];
        _locationLabel = locationLabel;
        locationLabel.font = [UIFont fontWithName:@"Systom-Light" size:14.0];
        locationLabel.textColor = [UIColor darkGrayColor];
        locationLabel.numberOfLines = 0;
        CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 60 - 10 - 5 - 14;
        locationLabel.preferredMaxLayoutWidth = preferredMaxWidth;
        [self.contentView addSubview:self.locationLabel];
    }
    return _locationLabel;
}

- (void)configView {
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
