//
//  DiscoverTableViewCell.m
//  FoodPin
//
//  Created by polycom on 2016/12/22.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "DiscoverTableViewCell.h"

@implementation DiscoverTableViewCell

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

- (UIImageView *)bgImageView {
    if(!_bgImageView) {
        UIImageView *bgImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewCornerRadius:0 imageViewClipsToBounds:YES];
        _bgImageView = bgImageView;
        [self.contentView addSubview:bgImageView];
    }
    return _bgImageView;
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        UILabel *nameLabel = [FPPublicUIKit labelWithTextColor:[UIColor blackColor] numberOfLines:1 text:nil labelFont:[UIFont systemFontOfSize:20.0]];
        _nameLabel = nameLabel;
        [self.contentView addSubview:nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if(!_typeLabel) {
        UILabel *typeLabel = [FPPublicUIKit labelWithTextColor:[UIColor grayColor] numberOfLines:1 text:nil labelFont:[UIFont fontWithName:@"System-Light" size:14.0]];
       _typeLabel = typeLabel;
        [self.contentView addSubview:typeLabel];
    }
    return _typeLabel;
}

- (UILabel *)locationLabel {
    if(!_locationLabel) {
        UILabel *locationLabel = [FPPublicUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter numberOfLines:0 text:nil labelFont:[UIFont fontWithName:@"System-Light" size:14.0]];
        
        CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 30;
        locationLabel.preferredMaxLayoutWidth = preferredMaxWidth;
        
        _locationLabel = locationLabel;
        [self.contentView addSubview:locationLabel];
    }
    return _locationLabel;
}

- (void)configView {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(140);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
