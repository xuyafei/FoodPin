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
@property (nonatomic, copy) NSArray *restaurantIsVisited;
@property (nonatomic, copy) NSMutableArray *mutableRestaurantIsVisited;
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
    
    //self.restaurantIsVisited = @[@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO];
    self.mutableRestaurantIsVisited = [NSMutableArray arrayWithObjects:@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, nil];
    
//    self.mutableRestaurantIsVisited = [[NSMutableArray alloc] init];
//    [self.mutableRestaurantIsVisited addObjectsFromArray:self.restaurantIsVisited];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:nil message:@"What do you want to do?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [optionMenu addAction:cancelAction];
    
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *alertMessage = [UIAlertController alertControllerWithTitle:@"Service Unavailable" message:@"Sorry, the call feature is not available yet. Please retry later." preferredStyle:UIAlertControllerStyleAlert];
        [alertMessage addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertMessage animated:YES completion:nil];
    }];
    [optionMenu addAction:callAction];
    
    NSString *title = (self.restaurantIsVisited[indexPath.row]) ? @"I've not been here" : @"I've been here";
    BOOL isSelected = self.mutableRestaurantIsVisited[indexPath.row] ? NO : YES;
    UIAlertAction *isVisitedAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RestaurantTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //BOOL isSelected = self.mutableRestaurantIsVisited[indexPath.row] ? NO : YES;
        //self.mutableRestaurantIsVisited[indexPath.row] = [NSNumber numberWithBool:isSelected];
        //[self.mutableRestaurantIsVisited replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:isSelected]];
        cell.accessoryType = isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
       
    }];
    self.mutableRestaurantIsVisited[indexPath.row] = [NSNumber numberWithBool:isSelected];
    [optionMenu addAction:isVisitedAction];
    
    [self presentViewController:optionMenu animated:YES completion:nil];
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
    restaurantCell.accessoryType = self.mutableRestaurantIsVisited[indexPath.row] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    restaurantCell.accessoryType = UITableViewCellAccessoryNone;
    
    return restaurantCell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
