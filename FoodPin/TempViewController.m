//
//  TempViewController.m
//  FoodPin
//
//  Created by polycom on 2017/6/12.
//  Copyright © 2017年 yafei.xu. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()

@property(nonatomic,strong) UIButton *testButton;
@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configView {
    self.testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _testButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testButton];
    
    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-7);
        make.left.mas_equalTo(self.view.mas_left).offset(7);
        //make.width.mas_equalTo(40);
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.mas_greaterThanOrEqualTo(0);
    }];
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
