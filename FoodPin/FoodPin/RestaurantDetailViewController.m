//
//  RestaurantDetailViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/16.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "RestaurantDetailTableViewCell.h"

@interface RestaurantDetailViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_restaurantDetailView;
    UIImageView *_headView;
    UIView *_footView;
    NSArray *_cellArray;
}


@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.restaurant.name;
    [self initCellArray];
    [self layoutTableView];
    // Do any additional setup after loading the view.
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
    return 36;
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
