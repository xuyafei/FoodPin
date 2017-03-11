//
//  FPTableViewCell.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPTableViewCell.h"
#import <Masonry/Masonry.h>

@interface FPTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation FPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    [self setupUserInterface];
    [self setupReactiveCocoa];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    self.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.bounds);
}

- (void)setupUserInterface {
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
}

- (void)setupReactiveCocoa {
    
}

#pragma mark -  Configure data

- (void)setupData:(id)data {
    self.nameLabel.text = data;
}

#pragma mark -  Accessor


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

@end
