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
@property (nonatomic, strong) NSMutableArray *restaurantArray;
@property (nonatomic, strong) NSMutableArray *restaurantImages;
@property (nonatomic, strong) NSMutableArray *restaurantLocations;
@property (nonatomic, strong) NSMutableArray *restaurantType;
@property (nonatomic, strong) NSArray *restaurantIsVisited;
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
    self.restaurantArray = [[NSMutableArray alloc] init];
    self.restaurantImages = [[NSMutableArray alloc] init];
    self.restaurantLocations = [[NSMutableArray alloc] init];
    self.restaurantType = [[NSMutableArray alloc] init];
    
    self.restaurantArray = [NSMutableArray arrayWithObjects:@"Cafe Deadend", @"Homei", @"Teakha", @"Cafe Loisl", @"PetiteOyster", @"For Kee Restaurant", @"Po's Atelier", @"Bourke Street Bakery", @"Haigh'sChocolate", @"Palomino Espresso", @"Upstate", @"Traif", @"Graham Avenue Meats AndDeli", @"Waffle & Wolf", @"Five Leaves", @"Cafe Lore", @"Confessional",@"Barrafina", @"Donostia", @"Royal Oak", @"CASK Pub and Kitchen",nil];
    
    self.restaurantImages = [NSMutableArray arrayWithObjects:@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg",@"cafeloisl.jpg", @"petiteoyster.jpg", @"forkeerestaurant.jpg", @"posatelier.jpg",@"bourkestreetbakery.jpg", @"haighschocolate.jpg", @"palominoespresso.jpg",
        @"upstate.jpg", @"traif.jpg", @"grahamavenuemeats.jpg", @"wafflewolf.jpg",@"fiveleaves.jpg", @"cafelore.jpg", @"confessional.jpg", @"barrafina.jpg",@"donostia.jpg", @"royaloak.jpg", @"thaicafe.jpg",nil];
    
    self.restaurantLocations = [NSMutableArray arrayWithObjects:@"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong",
        @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Sydney", @"Sydney", @"Sydney", @"NewYork", @"New York", @"New York", @"New York", @"New York", @"New York", @"New York",@"London", @"London", @"London", @"London", nil];
    
    self.restaurantType = [NSMutableArray arrayWithObjects:@"Coffee & Tea Shop", @"Cafe", @"Tea House", @"Austrian Causual Drink", @"French", @"Bakery", @"Bakery", @"Chocolate", @"Cafe", @"American Seafood", @"American", @"American", @"Breakfast & Brunch", @"Coffee & Tea", @"Coffee& Tea", @"Latin American", @"Spanish", @"Spanish", @"Spanish", @"British", @"Thai",nil];
    
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
    /*(UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:nil message:@"What do you want to do?" preferredStyle:UIAlertControllerStyleActionSheet];
    
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
    
    [self presentViewController:optionMenu animated:YES completion:nil];*/
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self.restaurantArray removeObjectAtIndex:indexPath.row];
        [self.restaurantImages removeObjectAtIndex:indexPath.row];
        [self.restaurantLocations removeObjectAtIndex:indexPath.row];
        [self.restaurantType removeObjectAtIndex:indexPath.row];
    }
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]  withRowAnimation:UITableViewRowAnimationFade];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSString *defaultText =[NSString stringWithFormat:@"Just checking in at%@",self.restaurantArray[indexPath.row]];
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:defaultText] applicationActivities:nil];
        [self presentViewController:activityController animated:YES completion:nil];
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.restaurantArray removeObjectAtIndex:indexPath.row];
        [self.restaurantImages removeObjectAtIndex:indexPath.row];
        [self.restaurantLocations removeObjectAtIndex:indexPath.row];
        [self.restaurantType removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]  withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    shareAction.backgroundColor = [UIColor colorWithRed: 28.0/255.0 green:165.0/255.0 blue:253.0/255.0 alpha:1.0];
    deleteAction.backgroundColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:203.0/255.0 alpha:1.0];
    
    return @[shareAction, deleteAction];
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
