//
//  ReviewViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/18.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "ReviewViewController.h"
#import "Masonry.h"

@interface ReviewViewController ()
@property(nonatomic, strong) NSString *imageString;
@property(nonatomic, weak) UIImageView *backgroundImageView;
@property(nonatomic, weak) UIButton *closeButton;
@property(nonatomic, weak) UILabel *questionLabel;
@property(nonatomic, weak) UIButton *dislikeButton;
@property(nonatomic, weak) UIButton *greatButton;
@property(nonatomic, weak) UIButton *goodButton;
@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    
    CGAffineTransform scale = CGAffineTransformMakeScale(0.0, 0.0);
    CGAffineTransform tranlate = CGAffineTransformMakeTranslation(0, 500);
    
    self.dislikeButton.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.0, 0.0), CGAffineTransformMakeTranslation(0, 500));
    self.goodButton.transform = CGAffineTransformConcat(scale, tranlate);
    self.greatButton.transform = CGAffineTransformConcat(scale, tranlate);
    
    self.imageString = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:nil animations:^{
        _dislikeButton.transform = CGAffineTransformIdentity;
        _goodButton.transform = CGAffineTransformIdentity;
        _greatButton.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (UIImageView *)backgroundImageView {
    if(!_backgroundImageView) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [self.view addSubview:backgroundImageView];
        backgroundImageView.image = [UIImage imageNamed:@"barrafina"];
        _backgroundImageView = backgroundImageView;
    }
    return _backgroundImageView;
}

- (UIButton *)closeButton {
    if(!_closeButton) {
        UIButton *closeButton = [FPPublicUIKit buttonWithBackGroundColor:nil buttonType:UIButtonTypeCustom buttonTintColor:[UIColor whiteColor] buttonCornerRadius:15 buttonWithImage:[[UIImage imageNamed:@"close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [closeButton addTarget:self action:@selector(clickClose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closeButton];
        _closeButton = closeButton;
    }
    return _closeButton;
}

- (UILabel *)questionLabel {
    if(!_questionLabel) {
        UILabel *questionLabel = [FPPublicUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:2 text:@"You've dined here. What do you think?" labelFont:[UIFont systemFontOfSize:30.0]];
        [self.view addSubview:questionLabel];
        _questionLabel = questionLabel;
    }
    return _questionLabel;
}

- (UIButton *)dislikeButton {
    if(!_dislikeButton) {
        UIButton *dislikeButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor redColor] buttonType:UIButtonTypeSystem buttonTintColor:[UIColor whiteColor] buttonCornerRadius:35 buttonWithImage:[[UIImage imageNamed:@"dislike"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        dislikeButton.tag = 101;
        [dislikeButton addTarget:self action:@selector(tapThreeButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dislikeButton];
        _dislikeButton = dislikeButton;
    }
    return _dislikeButton;
}

- (UIButton *)goodButton {
    if(!_goodButton) {
        UIButton *goodButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor redColor] buttonType:UIButtonTypeSystem buttonTintColor:[UIColor whiteColor] buttonCornerRadius:35 buttonWithImage:[[UIImage imageNamed:@"good"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        goodButton.tag = 102;
        [goodButton addTarget:self action:@selector(tapThreeButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:goodButton];
        _goodButton = goodButton;
    }
    return _goodButton;
}

- (UIButton *)greatButton {
    if(!_greatButton) {
        UIButton *greatButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor redColor] buttonType:UIButtonTypeSystem buttonTintColor:[UIColor whiteColor] buttonCornerRadius:35 buttonWithImage:[[UIImage imageNamed:@"great"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        greatButton.tag = 103;
        [greatButton addTarget:self action:@selector(tapThreeButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:greatButton];
        _greatButton = greatButton;
    }
    return _greatButton;
}


- (void)configView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    [self.backgroundImageView addSubview:blurEffectView];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(25);
        make.right.mas_equalTo(self.view.mas_right).offset(-7);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(287);
        make.height.mas_equalTo(72);
    }];
    
    [self.dislikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.questionLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [self.goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.questionLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(self.dislikeButton.mas_left).offset(-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [self.greatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.questionLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.dislikeButton.mas_right).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
}

- (void)clickClose:(UIButton *)sender {
    if(![self.imageString isEqualToString:@""]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(setButtonImage:)]) {
            [self.delegate setButtonImage:self.imageString];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapThreeButton:(UIButton *)sender {
    if(sender.tag == 101) {
        self.imageString = @"dislike";
    } else if(sender.tag == 102) {
        self.imageString = @"good";
    } else if(sender.tag == 103) {
        self.imageString = @"great";
    }
    [self clickClose:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"delloc for ReviewViewController");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
