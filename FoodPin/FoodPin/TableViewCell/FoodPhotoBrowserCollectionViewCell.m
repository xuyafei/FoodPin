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
        self.photoImageView = [[UIImageView alloc] init];
        self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.photoImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.photoImageView];
        
        [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height/2);
        }];
    }
    
    return self;
}
@end
