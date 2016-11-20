//
//  ReviewViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/18.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "ReviewViewController.h"
#import "Masonry.h"

@interface ReviewViewController () {
    UIImageView *_backgroundImageView;
    UIButton *_closeButton;
    UILabel *_questionLabel;
    UIButton *_dislikeButton;
    UIButton *_greatButton;
    UIButton *_goodButton;
}
@property(nonatomic, strong)NSString *imageString;
@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubViews];
    
    CGAffineTransform scale = CGAffineTransformMakeScale(0.0, 0.0);
    CGAffineTransform tranlate = CGAffineTransformMakeTranslation(0, 500);
    
    _dislikeButton.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.0, 0.0), CGAffineTransformMakeTranslation(0, 500));
    _goodButton.transform = CGAffineTransformConcat(scale, tranlate);
    _greatButton.transform = CGAffineTransformConcat(scale, tranlate);
    
    self.imageString = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:nil animations:^{
        _dislikeButton.transform = CGAffineTransformIdentity;
        _goodButton.transform = CGAffineTransformIdentity;
        _greatButton.transform = CGAffineTransformIdentity;
    }
 completion:nil];
    
}

- (void)layoutSubViews {
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _backgroundImageView.image = [UIImage imageNamed:@"barrafina"];
    [self.view addSubview:_backgroundImageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    [_backgroundImageView addSubview:blurEffectView];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.layer.cornerRadius = 15;
    [_closeButton setBackgroundImage:[[UIImage imageNamed:@"close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_closeButton setTintColor:[UIColor whiteColor]];
    [_closeButton addTarget:self action:@selector(clickClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    
    _questionLabel = [[UILabel alloc] init];
    _questionLabel.numberOfLines = 2;
    _questionLabel.text = @"You've dined here. What do you think?";
    _questionLabel.font = [UIFont systemFontOfSize:30.0];
    _questionLabel.textAlignment = NSTextAlignmentCenter;
    [_questionLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_questionLabel];
    
    _dislikeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _dislikeButton.layer.cornerRadius = 35;
    [_dislikeButton setBackgroundImage:[[UIImage imageNamed:@"dislike"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    _dislikeButton.backgroundColor = [UIColor redColor];
    [_dislikeButton setTintColor:[UIColor whiteColor]];
    _dislikeButton.tag = 101;
    [_dislikeButton addTarget:self action:@selector(tapThreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dislikeButton];
    
    _goodButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _goodButton.layer.cornerRadius = 35;
    [_goodButton setBackgroundImage:[[UIImage imageNamed:@"good"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    _goodButton.backgroundColor = [UIColor redColor];
    [_goodButton setTintColor:[UIColor whiteColor]];
    _goodButton.tag = 102;
    [_goodButton addTarget:self action:@selector(tapThreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goodButton];
    
    _greatButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _greatButton.layer.cornerRadius = 35;
    [_greatButton setBackgroundImage:[[UIImage imageNamed:@"great"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    _greatButton.backgroundColor = [UIColor redColor];
    [_greatButton setTintColor:[UIColor whiteColor]];
    _greatButton.tag = 103;
    [_greatButton addTarget:self action:@selector(tapThreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_greatButton];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(25);
        make.right.mas_equalTo(self.view.mas_right).offset(-7);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(287);
        make.height.mas_equalTo(72);
    }];
    
    [_dislikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_questionLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_questionLabel.mas_bottom).offset(20);
        make.right.mas_equalTo(_dislikeButton.mas_left).offset(-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [_greatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_questionLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(_dislikeButton.mas_right).offset(10);
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
