//
//  ViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/14.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "ViewController.h"
#import "RestaurantTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *foodRestaurantsTableView;
@property (nonatomic, copy) NSArray *restaurantArray;
@property (nonatomic, copy) NSArray *restaurantImages;
@property (nonatomic, copy) NSArray *restaurantLocations;
@property (nonatomic, copy) NSArray *restaurantType;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initRestaurantArray];
    [self layoutTableView];
}

- (void)initRestaurantArray {
    self.restaurantArray = @[@"Cafe Deadend", @"Homei", @"Teakha", @"Cafe Loisl", @"PetiteOyster", @"For Kee Restaurant", @"Po's Atelier", @"Bourke Street Bakery", @"Haigh'sChocolate", @"Palomino Espresso", @"Upstate", @"Traif", @"Graham Avenue Meats AndDeli", @"Waffle & Wolf", @"Five Leaves", @"Cafe Lore", @"Confessional",@"Barrafina", @"Donostia", @"Royal Oak", @"CASK Pub and Kitchen"];
    
    self.restaurantImages = @[@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg",@"cafeloisl.jpg", @"petiteoyster.jpg", @"forkeerestaurant.jpg", @"posatelier.jpg",@"bourkestreetbakery.jpg", @"haighschocolate.jpg", @"palominoespresso.jpg",
        @"upstate.jpg", @"traif.jpg", @"grahamavenuemeats.jpg", @"wafflewolf.jpg",@"fiveleaves.jpg", @"cafelore.jpg", @"confessional.jpg", @"barrafina.jpg",@"donostia.jpg", @"royaloak.jpg", @"thaicafe.jpg"];
    
    self.restaurantLocations = @[@"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong",
        @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Sydney", @"Sydney", @"Sydney", @"NewYork", @"New York", @"New York", @"New York", @"New York", @"New York", @"New York",@"London", @"London", @"London", @"London"];
    
    self.restaurantType = @[@"Coffee & Tea Shop", @"Cafe", @"Tea House", @"Austrian Causual Drink", @"French", @"Bakery", @"Bakery", @"Chocolate", @"Cafe", @"American Seafood", @"American", @"American", @"Breakfast & Brunch", @"Coffee & Tea", @"Coffee& Tea", @"Latin American", @"Spanish", @"Spanish", @"Spanish", @"British", @"Thai"];
}

- (void)layoutTableView {
    self.foodRestaurantsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.foodRestaurantsTableView.delegate = self;
    self.foodRestaurantsTableView.dataSource = self;
    [self.view addSubview:self.foodRestaurantsTableView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark -UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurantArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark -UITableViewDataSource-
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"restaurantCell";
    
    RestaurantTableViewCell *restaurantCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!restaurantCell) {
        restaurantCell = [[RestaurantTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        restaurantCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    restaurantCell.nameLabel.text = self.restaurantArray[indexPath.row];
    restaurantCell.thumbnailImageView.image = [UIImage imageNamed:self.restaurantImages[indexPath.row]];
    restaurantCell.locationLabel.text = self.restaurantLocations[indexPath.row];
    restaurantCell.typeLabel.text = self.restaurantType[indexPath.row];
    
    
    return restaurantCell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
