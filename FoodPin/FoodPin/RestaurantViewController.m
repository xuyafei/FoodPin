//
//  ViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/14.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "RestaurantViewController.h"
#import "RestaurantTableViewCell.h"
#import "Restaurant.h"
#import "RestaurantDetailViewController.h"

@interface RestaurantViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_restaurants;
}
@property (nonatomic, strong) UITableView *foodRestaurantsTableView;
@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self initRestaurantArray];
    [self layoutTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.hidesBarsOnSwipe = YES;
}

- (void)initRestaurantArray {
    _restaurants = [NSMutableArray arrayWithObjects:
                    [Restaurant restaurantWithName:@"Cafe Deadend" type:@"Coffee & Tea Shop" location:@"Hong Kong" image:@"cafedeadend.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Homei" type:@"Cafe" location:@"Hong Kong" image:@"homei.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Teakha" type:@"Tea House" location:@"Hong Kong" image:@"teakha.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Cafe Loisl" type:@"Austrian Causual Drink" location:@"Hong Kong" image:@"cafeloisl.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"PetiteOyster" type:@"French" location:@"Hong Kong" image:@"petiteoyster.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"For Kee Restaurant" type:@"Bakery" location:@"Hong Kong" image:@"forkeerestaurant.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Po's Atelier" type:@"Bakery" location:@"Hong Kong" image:@"posatelier.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Bourke Street Bakery" type:@"Chocolate" location:@"Sydney" image:@"bourkestreetbakery.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Haigh'sChocolate" type:@"Cafe" location:@"Sydney" image:@"haighschocolate.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Palomino Espresso" type:@"American Seafood" location:@"Sydney" image:@"palominoespresso.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Upstate" type:@"American" location:@"NewYork" image:@"upstate.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Traif" type:@"American" location:@"NewYork" image:@"traif.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Graham Avenue Meats AndDeli" type:@"Breakfast & Brunch" location:@"NewYork" image:@"grahamavenuemeats.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Waffle & Wolf" type:@"Coffee & Tea" location:@"NewYork" image:@"wafflewolf.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Five Leaves" type:@"Coffee& Tea" location:@"NewYork" image:@"fiveleaves.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Cafe Lore" type:@"Latin American" location:@"NewYork" image:@"cafelore.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Confessional" type:@"Spanish" location:@"NewYork" image:@"confessional.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Barrafina" type:@"Spanish" location:@"London" image:@"barrafina.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Donostia" type:@"Spanish" location:@"London" image:@"donostia.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"Royal Oak" type:@"British" location:@"London" image:@"royaloak.jpg" isVisited:NO],
                    [Restaurant restaurantWithName:@"CASK Pub and Kitchen" type:@"Thai" location:@"London" image:@"thaicafe.jpg" isVisited:NO],nil];
}

- (void)layoutTableView {
    self.foodRestaurantsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.foodRestaurantsTableView.delegate = self;
    self.foodRestaurantsTableView.dataSource = self;
    [self.view addSubview:self.foodRestaurantsTableView];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark -UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _restaurants.count;
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
    
    
    RestaurantDetailViewController *detailViewController = [[RestaurantDetailViewController alloc] init];
    detailViewController.restaurant = _restaurants[indexPath.row];
    [detailViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [_restaurants removeObjectAtIndex:indexPath.row];
    }
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]  withRowAnimation:UITableViewRowAnimationFade];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSString *defaultText =[NSString stringWithFormat:@"Just checking in at%@",((Restaurant*)_restaurants[indexPath.row]).name];
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:defaultText] applicationActivities:nil];
        [self presentViewController:activityController animated:YES completion:nil];
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [_restaurants removeObjectAtIndex:indexPath.row];
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

    restaurantCell.nameLabel.text = ((Restaurant*)_restaurants[indexPath.row]).name;
    restaurantCell.thumbnailImageView.image = [UIImage imageNamed:((Restaurant*)_restaurants[indexPath.row]).iamge];
    restaurantCell.locationLabel.text = ((Restaurant*)_restaurants[indexPath.row]).location;
    restaurantCell.typeLabel.text = ((Restaurant*)_restaurants[indexPath.row]).type;
    restaurantCell.accessoryType = ((Restaurant*)_restaurants[indexPath.row]).isVisited ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return restaurantCell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
