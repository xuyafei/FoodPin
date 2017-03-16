//
//  FPPublicUIKit.m
//  FoodPin
//
//  Created by polycom on 2017/3/14.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPPublicUIKit.h"

@implementation FPPublicUIKit

#pragma mark ------------- UILabel ---------------
+ (UILabel *)labelTextColor:(UIColor *)textColor
                  labelFont:(UIFont *)font {
    return [FPPublicUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:1 text:nil labelFont:font];
}

+ (UILabel *)labelWithText:(NSString *)text
                 labelFont:(UIFont *)font {
    return [FPPublicUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:text labelFont:font];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                      labelFont:(UIFont *)font {
    return [FPPublicUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:textColor textAlignment:NSTextAlignmentLeft numberOfLines:numberOfLines text:text labelFont:font];
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                            labelFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.text = text;
    label.font = font;
    
    return label;
}

#pragma mark ------------- UIButton ---------------
+ (UIButton *)buttonWithBackGroundColor:(UIColor *)backGroundColor
                             buttonType:(UIButtonType)buttonType
                        buttonWithTitle:(NSString *)buttonTitle
                   buttonWithTitleColor:(UIColor *)titleColor
                    buttonWithTitleFont:(UIFont *)titleFont
                        buttonWithImage:(UIImage *)buttonImage {
    UIButton *button = [UIButton buttonWithType:buttonType];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = backGroundColor;
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    
    return button;
}

+ (UIButton *)buttonWithBackGroundColor:(UIColor *)backGroundColor
                             buttonType:(UIButtonType)buttonType
                        buttonTintColor:(UIColor *)tintColor
                     buttonCornerRadius:(NSInteger)radius
                        buttonWithImage:(UIImage *)image{
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.layer.cornerRadius = radius;
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:tintColor];
    button.backgroundColor = backGroundColor;
    
    return button;
}

#pragma mark ------------- UITextField -----------
+ (UITextField *)textFieldColor:(UIColor *)textColor
                       fontSize:(CGFloat)size {
    return [FPPublicUIKit textFieldWithTextColor:textColor
                                   borderStyle:UITextBorderStyleNone
                            autocorrectionType:UITextAutocorrectionTypeNo
                        autocapitalizationType:UITextAutocapitalizationTypeNone
                               clearButtonMode:UITextFieldViewModeWhileEditing
                                          text:nil
                                   placeholder:nil
                              placeholderColor:[UIColor clearColor]
                                 textAlignment:NSTextAlignmentLeft
                                      fontSize:size];
}

+ (UITextField *)textFieldWithText:(NSString *)text
                          fontSize:(CGFloat)size {
    return [FPPublicUIKit textFieldWithTextColor:[UIColor whiteColor]
                                   borderStyle:UITextBorderStyleNone
                            autocorrectionType:UITextAutocorrectionTypeNo
                        autocapitalizationType:UITextAutocapitalizationTypeNone
                               clearButtonMode:UITextFieldViewModeWhileEditing
                                          text:text
                                   placeholder:nil
                              placeholderColor:[UIColor clearColor]
                                 textAlignment:NSTextAlignmentLeft
                                      fontSize:size];
}

+ (UITextField *)textFieldWithText:(NSString *)text
                          fontSize:(CGFloat)size
                         fontColor:(UIColor *)color
                     textAlignment:(NSTextAlignment)textAlignment {
    return [FPPublicUIKit textFieldWithTextColor:color
                                   borderStyle:UITextBorderStyleNone
                            autocorrectionType:UITextAutocorrectionTypeNo
                        autocapitalizationType:UITextAutocapitalizationTypeNone
                               clearButtonMode:UITextFieldViewModeWhileEditing
                                          text:text
                                   placeholder:nil
                              placeholderColor:[UIColor clearColor]
                                 textAlignment:textAlignment
                                      fontSize:size];
    
}
+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                                 fontSize:(CGFloat)size
                                fontColor:(UIColor *)color
                            textAlignment:(NSTextAlignment)textAlignment; {
    return [FPPublicUIKit textFieldWithTextColor:color
                                   borderStyle:UITextBorderStyleNone
                            autocorrectionType:UITextAutocorrectionTypeNo
                        autocapitalizationType:UITextAutocapitalizationTypeNone
                               clearButtonMode:UITextFieldViewModeWhileEditing
                                          text:nil
                                   placeholder:placeholder
                              placeholderColor:[UIColor clearColor]
                                 textAlignment:NSTextAlignmentLeft
                                      fontSize:size];
}

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                                 fontSize:(CGFloat)size
                                fontColor:(UIColor *)color
                         placeholderColor:(UIColor *)placeholderColor
                            textAlignment:(NSTextAlignment)textAlignment {
    return [FPPublicUIKit textFieldWithTextColor:color
                                   borderStyle:UITextBorderStyleNone
                            autocorrectionType:UITextAutocorrectionTypeNo
                        autocapitalizationType:UITextAutocapitalizationTypeNone
                               clearButtonMode:UITextFieldViewModeWhileEditing
                                          text:nil
                                   placeholder:placeholder
                              placeholderColor:placeholderColor
                                 textAlignment:NSTextAlignmentLeft
                                      fontSize:size];
}

+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                            borderStyle:(UITextBorderStyle)borderStyle
                     autocorrectionType:(UITextAutocorrectionType)autocorrectionType
                 autocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
                        clearButtonMode:(UITextFieldViewMode)clearButtonMode
                                   text:(NSString *)text
                            placeholder:(NSString *)placeholder
                       placeholderColor:(UIColor *)placeholerColor
                          textAlignment:(NSTextAlignment)textAlignment
                               fontSize:(CGFloat)size {
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = textColor;
    textField.textAlignment = textAlignment;
    textField.text = text;
    textField.placeholder = placeholder;
    if(placeholder != nil) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:placeholerColor}];
    }
    textField.font = [UIFont systemFontOfSize:size];
    textField.borderStyle = borderStyle;
    textField.autocorrectionType = autocorrectionType;
    textField.autocapitalizationType = autocapitalizationType;
    textField.clearButtonMode = clearButtonMode;
    
    return textField;
}

#pragma mark ------------- UIImageView -----------
+ (UIImageView *)imageViewContentMode:(UIViewContentMode)contentMode
                imageViewCornerRadius:(CGFloat)radius
               imageViewClipsToBounds:(BOOL)clipsToBounds {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = contentMode;
    imageView.layer.cornerRadius = radius;
    imageView.clipsToBounds = clipsToBounds;
    
    return imageView;
}

+ (UIImageView *)imageViewContentMode:(UIViewContentMode)contentMode
             imageViewBackGroundColor:(UIColor *)color
               imageViewClipsToBounds:(BOOL)clipsToBounds
      imageViewUserInteractionEnabled:(BOOL)userInteractionEnable {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = contentMode;
    imageView.clipsToBounds = clipsToBounds;
    imageView.userInteractionEnabled = userInteractionEnable;
    
    return imageView;
}

@end
