//
//  AddRestaurantInfoTableViewCell.m
//  FoodPin
//
//  Created by xuyafei on 16/11/21.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "AddRestaurantInfoTableViewCell.h"
#import "Masonry.h"

@interface AddRestaurantInfoTableViewCell() <UITextFieldDelegate> {
    
}

@end

@implementation AddRestaurantInfoTableViewCell 

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

- (UILabel *)titleLable {
    if(!_titleLable) {
        UILabel *titleLable = [FPPublicUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:nil textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil labelFont:[UIFont fontWithName:@"Medium" size:17.0]];
        [self.contentView addSubview:titleLable];
        _titleLable = titleLable;
    }
    return _titleLable;
}

- (UITextField *)detailTextField {
    if(!_detailTextField) {
        UITextField *detailTextField = [FPPublicUIKit textFieldWithText:nil fontSize:16.0 fontColor:[UIColor darkGrayColor] textAlignment:NSTextAlignmentLeft];
        detailTextField.delegate = self;
        detailTextField.tag = 101;
        [detailTextField addTarget:self action:@selector(inputTextFieldResponse:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:detailTextField];
        _detailTextField = detailTextField;
    }
    return _detailTextField;
}

- (UIButton *)yesButton {
    if(!_yesButton) {
        UIButton *yesButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor redColor] buttonType:UIButtonTypeSystem buttonWithTitle:@"YES" buttonWithTitleColor:[UIColor whiteColor] buttonWithTitleFont:nil buttonWithImage:nil];
        yesButton.tag = 102;
        [yesButton addTarget:self action:@selector(toggleButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:yesButton];
        _yesButton = yesButton;
    }
    return _yesButton;
}

- (UIButton *)noButton {
    if(!_noButton) {
        UIButton *noButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor grayColor] buttonType:UIButtonTypeSystem buttonWithTitle:@"NO" buttonWithTitleColor:[UIColor whiteColor] buttonWithTitleFont:nil buttonWithImage:nil];
        noButton.tag = 103;
        [noButton addTarget:self action:@selector(toggleButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:noButton];
        _noButton = noButton;
    }
    return _noButton;
}

- (void)configView {
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

- (void)inputTextFieldResponse:(UITextField *)textField {
    if(textField.tag == 101) {
        NSLog(@"%@", textField.text);
        if(self.delegate && [self.delegate respondsToSelector:@selector(setTextFieldText:withTextTextString:)]) {
            [self.delegate setTextFieldText:self.currentIndexPath withTextTextString:textField.text];
        }
    }
}

#pragma mark -ButtonSender-
- (void)toggleButton:(UIButton *)sender {
    BOOL isHaveBeenThere = NO;
    
    if(sender.tag == 102) {
        isHaveBeenThere = YES;
    } else if(sender.tag == 103) {
        isHaveBeenThere = NO;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(setButtonToggle:)]) {
        [self.delegate setButtonToggle:isHaveBeenThere];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
