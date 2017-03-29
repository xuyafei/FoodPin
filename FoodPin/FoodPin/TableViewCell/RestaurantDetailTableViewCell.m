//
//  RestaurantDetailTableViewCell.m
//  FoodPin
//
//  Created by xuyafei on 16/11/16.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "RestaurantDetailTableViewCell.h"

@implementation RestaurantDetailTableViewCell

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

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        UILabel *nameLabel = [FPPublicUIKit labelWithText:nil labelFont:[UIFont systemFontOfSize:16.0]];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return _nameLabel;
}

- (UILabel *)filedLabel {
    if(!_filedLabel) {
        UILabel *filedLabel = [FPPublicUIKit labelWithTextColor:nil numberOfLines:0 text:nil labelFont:[UIFont systemFontOfSize:16.0]];
        CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 100 - 15;
        filedLabel.preferredMaxLayoutWidth = preferredMaxWidth;
        [filedLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.contentView addSubview:filedLabel];
        _filedLabel = filedLabel;
    }
    return _filedLabel;
}

- (void)configView {
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
