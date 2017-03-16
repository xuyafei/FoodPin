//
//  RestaurantSearchResultViewController.m
//  FoodPin
//
//  Created by polycom on 2017/2/22.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "RestaurantSearchResultViewController.h"
#import "RestaurantTableViewCell.h"
#import "RestaurantDetailViewController.h"

@interface RestaurantSearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RestaurantSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configLayOutTableview];
    // Do any additional setup after loading the view.
}

- (void)configLayOutTableview {
    self.searchResultTableView.estimatedRowHeight = 80;
    self.searchResultTableView.rowHeight = UITableViewAutomaticDimension;
}

- (UITableView *)searchResultTableView {
    if(!_searchResultTableView) {
        UITableView *searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
        searchResultTableView.delegate = self;
        searchResultTableView.dataSource = self;
        [self.view addSubview:searchResultTableView];
        _searchResultTableView = searchResultTableView;
    }
    return _searchResultTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResultRestaurants.count;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RestaurantDetailViewController *detailViewController = [[RestaurantDetailViewController alloc] init];
    detailViewController.restaurant = _searchResultRestaurants[indexPath.row];
    self.navigationController.definesPresentationContext = YES;
    [detailViewController setHidesBottomBarWhenPushed:YES];
    NSLog(@"%@", self.navigationController);
    [self.presentingViewController.navigationController pushViewController:detailViewController animated:YES];
    
}

#pragma mark -UITableViewDataSource-
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"restaurantCell";
    
    RestaurantTableViewCell *restaurantCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!restaurantCell) {
        restaurantCell = [[RestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        restaurantCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Restaurant *restaurant = _searchResultRestaurants[indexPath.row];
    restaurantCell.nameLabel.text = restaurant.name;
    restaurantCell.thumbnailImageView.image = [UIImage imageWithData:restaurant.image];
    restaurantCell.locationLabel.text = restaurant.location;
    restaurantCell.typeLabel.text = restaurant.type;
    restaurantCell.accessoryType = [restaurant.isVisited boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    //restaurantCell.backgroundColor = [UIColor redColor];
    return restaurantCell;
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
