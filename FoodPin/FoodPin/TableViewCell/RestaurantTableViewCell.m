//
//  RestaurantTableViewCell.m
//  FoodPin
//
//  Created by 永康范 on 16/11/15.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "RestaurantTableViewCell.h"
@interface RestaurantTableViewCell()

@property (nonatomic, strong)UIImageView *thumbnailImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *locationLabel;
@property (nonatomic, strong)UILabel *typeLabel;

@end

@implementation RestaurantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
