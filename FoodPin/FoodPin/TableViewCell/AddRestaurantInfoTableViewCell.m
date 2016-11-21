//
//  AddRestaurantInfoTableViewCell.m
//  FoodPin
//
//  Created by 永康范 on 16/11/21.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "AddRestaurantInfoTableViewCell.h"
#import "Masonry.h"

@implementation AddRestaurantInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.font = [UIFont fontWithName:@"Medium" size:17.0];
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLable];
        
        self.detailTextField = [[UITextField alloc] init];
        self.detailTextField.textColor = [UIColor darkGrayColor];
        self.detailTextField.font = [UIFont systemFontOfSize:16.0];
        self.detailTextField.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.detailTextField];
        
        self.yesButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.yesButton.backgroundColor = [UIColor redColor];
        [self.yesButton setTitle:@"YES" forState:UIControlStateNormal];// 添加文字
        [self.yesButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [self.contentView addSubview:self.yesButton];
        
        self.noButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.noButton.backgroundColor = [UIColor grayColor];
        [self.noButton setTitle:@"NO" forState:UIControlStateNormal];// 添加文字
        [self.noButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [self.contentView addSubview:self.noButton];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLable.mas_bottom).offset(3);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.mas_greaterThanOrEqualTo(0);
        }];
        
        [self.yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLable.mas_bottom).offset(3);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.width.mas_equalTo(52);
            make.height.mas_equalTo(26);
        }];

        [self.noButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLable.mas_bottom).offset(3);
            make.left.mas_equalTo(self.yesButton.mas_right).offset(3);
            make.width.mas_equalTo(52);
            make.height.mas_equalTo(26);
        }];

    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
