//
//  FoodPhotoBrowserCollectionViewCell.m
//  FoodPin
//
//  Created by polycom on 2016/12/27.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "FoodPhotoBrowserCollectionViewCell.h"
#import "Masonry.h"

@implementation FoodPhotoBrowserCollectionViewCell

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
       [self configView];
    }
    
    return self;
}

- (UIImageView *)photoImageView {
    if(!_photoImageView) {
        UIImageView *photoImageView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewBackGroundColor:nil imageViewClipsToBounds:YES imageViewUserInteractionEnabled:NO];
        _photoImageView = photoImageView;
        [self.contentView addSubview:photoImageView];
    }
    return _photoImageView;
}

- (void)configView {
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeigth/2);
    }];
}
@end
