//
//  AddPhotoTableViewCell.m
//  FoodPin
//
//  Created by xuyafei on 16/11/21.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "AddPhotoTableViewCell.h"

@implementation AddPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCellView];
    }
    return self;
}

- (UIImageView *)photoImageView {
    if(!_photoImageView) {
        UIImageView *photoImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewCornerRadius:0 imageViewClipsToBounds:YES];
        [self.contentView addSubview:photoImageView];
        _photoImageView = photoImageView;
    }
    return _photoImageView;
}

- (void)configCellView {
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.width.mas_equalTo(84);
        make.height.mas_equalTo(84);
    }];
}

- (void)updateContentViewConstraints {
    [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    // 更新约束
    [self.contentView layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
