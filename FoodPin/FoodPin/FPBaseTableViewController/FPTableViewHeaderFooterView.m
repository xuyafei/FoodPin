//
//  FPTableViewHeaderFooterView.m
//  FoodPin
//
//  Created by polycom on 2017/3/9.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPTableViewHeaderFooterView.h"
#import <Masonry/Masonry.h>


@interface FPTableViewHeaderFooterView ()
@property (nonatomic, strong) UILabel *nameLabel;
@end


@implementation FPTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
    self.nameLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLabel.bounds) - 16;
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
        _nameLabel.backgroundColor = [UIColor yellowColor];
    }
    return _nameLabel;
}

@end
