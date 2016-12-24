//
//  DiscoverTableViewCell.m
//  FoodPin
//
//  Created by polycom on 2016/12/22.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import "Masonry.h"

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.bgImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.numberOfLines = 1;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:20.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.locationLabel = [[UILabel alloc] init];
        self.locationLabel.font = [UIFont fontWithName:@"System-Light" size:14.0];
        self.locationLabel.textColor = [UIColor whiteColor];
        self.locationLabel.numberOfLines = 0;
        [self.contentView addSubview:self.locationLabel];
        
        self.typeLabel = [[UILabel alloc] init];
        self.typeLabel.numberOfLines = 1;
        self.typeLabel.textColor = [UIColor whiteColor];
        self.typeLabel.font = [UIFont fontWithName:@"System-Light" size:14.0];
        [self.contentView addSubview:self.typeLabel];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(8);
            make.left.mas_equalTo(self.contentView.mas_left).offset(8);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-8);
            make.left.mas_equalTo(self.contentView.mas_left).offset(8);
            make.width.mas_equalTo(359);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.locationLabel.mas_top).offset(-3);
            make.left.mas_equalTo(self.contentView.mas_left).offset(8);
            make.width.mas_equalTo(359);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(133);
        }];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
