//
//  RestaurantDetailViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/16.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "RestaurantDetailTableViewCell.h"
#import "ReviewViewController.h"
#import "Masonry.h"

@interface RestaurantDetailViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_restaurantDetailView;
    UIImageView *_headView;
    UIView *_footView;
    UIButton *_reviewButton;
    NSArray *_cellArray;
}


@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.restaurant.name;
    [self initCellArray];
    [self layoutTableView];
    _restaurantDetailView.estimatedRowHeight = 36.0;
    _restaurantDetailView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.hidesBarsOnSwipe = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initCellArray {
    _cellArray = @[@"Name", @"Type", @"Location", @"Been here"];
}

- (void)layoutTableView {
    self.view.backgroundColor = [UIColor whiteColor];
    _restaurantDetailView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    _restaurantDetailView.delegate = self;
    _restaurantDetailView.dataSource = self;
    _restaurantDetailView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.2];
    [self.view addSubview:_restaurantDetailView];
    
    _headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    _headView.backgroundColor = [UIColor redColor];
    _headView.image = [UIImage imageNamed:self.restaurant.iamge];
    _headView.contentMode = UIViewContentModeScaleAspectFill;
    _headView.clipsToBounds = YES;
    _restaurantDetailView.tableHeaderView = _headView;
    
    _reviewButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _reviewButton.layer.cornerRadius = 20;
    [_reviewButton setBackgroundImage:[[UIImage imageNamed:@"rating"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    _reviewButton.backgroundColor = [UIColor redColor];
    [_reviewButton setTintColor:[UIColor whiteColor]];
    [_reviewButton addTarget:self action:@selector(clickReview:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reviewButton];
    
    [_reviewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(72);
        make.right.mas_equalTo(self.view.mas_right).offset(-7);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    _footView = [[UIView alloc] initWithFrame:CGRectZero];
    _restaurantDetailView.tableFooterView = _footView;
    
    _restaurantDetailView.separatorColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.8];
}

- (void)dealloc {
    NSLog(@"print the delloc");
}

#pragma mark -UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark -UITableViewDataSource-
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"restaurantDetailCell";
    
    RestaurantDetailTableViewCell *restaurantDetailCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!restaurantDetailCell) {
        restaurantDetailCell = [[RestaurantDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        restaurantDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    restaurantDetailCell.backgroundColor = [UIColor clearColor];
    restaurantDetailCell.nameLabel.text = _cellArray[indexPath.row];
    
    if(indexPath.row == 0) {
        restaurantDetailCell.filedLabel.text = self.restaurant.name;
    } else if(indexPath.row == 1) {
        restaurantDetailCell.filedLabel.text = self.restaurant.type;
    } else if(indexPath.row == 2) {
        restaurantDetailCell.filedLabel.text = self.restaurant.location;
    } else if(indexPath.row == 3) {
        restaurantDetailCell.filedLabel.text = (self.restaurant.isVisited) ? @"Yes, I've been here before" : @"NO";
    }
    
    return restaurantDetailCell;
}

#pragma mark -ButtonSender-
- (void)clickReview:(UIButton *)sender {
    NSLog(@"print some thing");
    ReviewViewController *reviewViewController = [[ReviewViewController alloc] init];
    [self presentViewController:reviewViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
