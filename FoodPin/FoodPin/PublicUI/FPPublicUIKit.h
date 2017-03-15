//
//  FPPublicUIKit.h
//  FoodPin
//
//  Created by polycom on 2017/3/14.
//  Copyright © 2017年 永康范. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FPPublicUIKit : NSObject
#pragma mark ------------- UILabel ---------------
+ (UILabel *)labelTextColor:(UIColor *)textColor
                  labelFont:(UIFont *)font;

+ (UILabel *)labelWithText:(NSString *)text
                 labelFont:(UIFont *)font;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                      labelFont:(UIFont *)font;

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                        numberOfLines:(NSInteger)numberOfLines
                                 text:(NSString *)text
                            labelFont:(UIFont *)font;

#pragma mark ------------- UIButton ---------------

+ (UIButton *)buttonWithBackGroundColor:(UIColor *)backGroundColor
                             buttonType:(UIButtonType)buttonType
                        buttonTintColor:(UIColor *)tintColor
                     buttonCornerRadius:(NSInteger)radius
                        buttonWithImage:(UIImage *)image;

+ (UIButton *)buttonWithBackGroundColor:(UIColor *)backGroundColor
                             buttonType:(UIButtonType)buttonType
                        buttonWithTitle:(NSString *)buttonTitle
                   buttonWithTitleColor:(UIColor *)titleColor
                    buttonWithTitleFont:(UIFont *)titleFont
                        buttonWithImage:(UIImage *)buttonImage;

#pragma mark ------------- UITextField -----------
+ (UITextField *)textFieldColor:(UIColor *)textColor
                       fontSize:(CGFloat)size;

+ (UITextField *)textFieldWithText:(NSString *)text
                          fontSize:(CGFloat)size;

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                                 fontSize:(CGFloat)size
                                fontColor:(UIColor *)color
                            textAlignment:(NSTextAlignment)textAlignment;

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                                 fontSize:(CGFloat)size
                                fontColor:(UIColor *)color
                         placeholderColor:(UIColor *)placeholderColor
                            textAlignment:(NSTextAlignment)textAlignment;

+ (UITextField *)textFieldWithText:(NSString *)text
                          fontSize:(CGFloat)size
                         fontColor:(UIColor *)color
                     textAlignment:(NSTextAlignment)textAlignment;

+ (UITextField *)textFieldWithTextColor:(UIColor *)textColor
                            borderStyle:(UITextBorderStyle)borderStyle
                     autocorrectionType:(UITextAutocorrectionType)autocorrectionType
                 autocapitalizationType:(UITextAutocapitalizationType)autocapitalizationType
                        clearButtonMode:(UITextFieldViewMode)clearButtonMode
                                   text:(NSString *)text
                            placeholder:(NSString *)placeholder
                       placeholderColor:(UIColor *)placeholerColor
                          textAlignment:(NSTextAlignment)textAlignment
                               fontSize:(CGFloat)size;

@end
