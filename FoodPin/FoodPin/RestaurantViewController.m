//
//  ViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/14.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Restaurant.h"
#import "Restaurants.h"
#import "RestaurantViewController.h"
#import "RestaurantTableViewCell.h"
#import "RestaurantDetailViewController.h"
#import "AddRestaurantViewController.h"
#import "WalkthroughPageViewController.h"

@interface RestaurantViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating,NSFetchedResultsControllerDelegate> {
    NSMutableArray *_restaurants;
    NSMutableArray *_searchResultRestaurants;
    NSMutableArray *_tempRestaurantArrays;
    UISearchController *_searchController;
    UIPageViewController *_pageViewController;
}
@property (nonatomic, strong) UITableView *foodRestaurantsTableView;
@property (nonatomic, strong) NSManagedObjectContext *restaurantMOC;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController;
@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Food Pin";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentPhontViewController:)];
    [self initRestaurantArray];
    [self layoutTableView];
    [self initSearchContorller];
    self.foodRestaurantsTableView.estimatedRowHeight = 80;
    self.foodRestaurantsTableView.rowHeight = UITableViewAutomaticDimension;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    
    self.restaurantMOC = [self contextWithModelName:@"FoodPin"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasDidLoadCoreData = [defaults boolForKey:@"hasDidLoadCoreData"];
    if(!hasDidLoadCoreData) {
        [self createTestCoreData];
    }
    
    if(self.restaurantMOC != nil) {
        NSError *error = nil;
        
        self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.restaurantMOC sectionNameKeyPath:nil cacheName:nil];
        self.fetchedResultController.delegate = self;
        [self.fetchedResultController performFetch:&error];
        
        if(error) {
            NSLog(@"NSFetchedResultsController init error : %@", error);
            return;
        } else {
            _restaurants = self.fetchedResultController.fetchedObjects;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.hidesBarsOnSwipe = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasViewedWalkthrough = [defaults boolForKey:@"hasViewedWalkthrough"];
    
    if(hasViewedWalkthrough) {
        return;
    }

    WalkthroughPageViewController *pageViewController = [[WalkthroughPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self presentViewController: pageViewController animated:YES completion:nil];
}

- (void)initRestaurantArray {
    _restaurants = [NSMutableArray array];
    _searchResultRestaurants = [NSMutableArray array];
    _tempRestaurantArrays = [NSMutableArray arrayWithObjects:
                    [Restaurants restaurantWithName:@"Cafe Deadend" type:@"Coffee & Tea Shop" location:@"G/F,72 Po Hing Fong, Sheung Wan, Hong Kong" phoneNumber: @"232-923423" image:@"cafedeadend.jpg" isVisited:YES],
                    [Restaurants restaurantWithName:@"Homei" type:@"Cafe" location:@"Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong" phoneNumber: @"348-233423" image:@"homei.jpg" isVisited:YES],
                    [Restaurants restaurantWithName:@"Teakha" type:@"Tea House" location:@"Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong" phoneNumber: @"354-243523" image:@"teakha.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Cafe Loisl" type:@"Austrian Causual Drink" location:@"Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong" phoneNumber: @"453-333423" image:@"cafeloisl.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"PetiteOyster" type:@"French" location:@"24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong" phoneNumber: @"983-284334" image:@"petiteoyster.jpg" isVisited:YES],
                    [Restaurants restaurantWithName:@"For Kee Restaurant" type:@"Bakery" location:@"Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong" phoneNumber:@"232-434222" image:@"forkeerestaurant.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Po's Atelier" type:@"Bakery" location:@"G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong" phoneNumber:@"234-834322" image:@"posatelier.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Bourke Street Bakery" type:@"Chocolate" location:@"633 Bourke St Sydney New South Wales 2010 Surry Hills" phoneNumber:@"982-434343" image:@"bourkestreetbakery.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Haigh'sChocolate" type:@"Cafe" location:@"412-414 George St Sydney New South Wales" phoneNumber:@"734-232323" image:@"haighschocolate.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Palomino Espresso" type:@"American Seafood" location:@"Shop 1 61 York St Sydney New South Wales" phoneNumber: @"872-734343" image:@"palominoespresso.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Upstate" type:@"American" location:@"95 1st Ave New York, NY 10003" phoneNumber:@"343-233221" image:@"upstate.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Traif" type:@"American" location:@"229 S 4th St Brooklyn, NY 11211" phoneNumber:@"985-723623" image:@"traif.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Graham Avenue Meats AndDeli" type:@"Breakfast & Brunch" location:@"445 Graham Ave Brooklyn, NY 11211" phoneNumber: @"455-232345" image:@"grahamavenuemeats.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Waffle & Wolf" type:@"Coffee & Tea" location:@"413 Graham Ave Brooklyn, NY 11211" phoneNumber:@"434-232322" image:@"wafflewolf.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Five Leaves" type:@"Coffee& Tea" location:@"18 Bedford Ave Brooklyn, NY 11222" phoneNumber:@"343-234553" image:@"fiveleaves.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Cafe Lore" type:@"Latin American" location:@"Sunset Park 4601 4th Ave Brooklyn, NY 11220" phoneNumber:@"342-455433" image:@"cafelore.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Confessional" type:@"Spanish" location:@"308 E 6th St New York, NY 10003" phoneNumber:@"643-332323" image:@"confessional.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Barrafina" type:@"Spanish" location:@"54 Frith Street London W1D 4SL United Kingdom" phoneNumber:@"542-343434" image:@"barrafina.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Donostia" type:@"Spanish" location:@"10 Seymour Place London W1H 7ND United Kingdom" phoneNumber:@"722-232323" image:@"donostia.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"Royal Oak" type:@"British" location:@"2 Regency Street London SW1P 4BZ United Kingdom" phoneNumber:@"343-988834" image:@"royaloak.jpg" isVisited:NO],
                    [Restaurants restaurantWithName:@"CASK Pub and Kitchen" type:@"Thai" location:@"22 Charlwood Street London SW1V 2DY Pimlico" phoneNumber:@"432-344050" image:@"thaicafe.jpg" isVisited:NO], nil];
}

- (void)layoutTableView {
    self.foodRestaurantsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.foodRestaurantsTableView.delegate = self;
    self.foodRestaurantsTableView.dataSource = self;
    [self.view addSubview:self.foodRestaurantsTableView];
}

- (void)initSearchContorller {
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.foodRestaurantsTableView.tableHeaderView = _searchController.searchBar;
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = YES;
    self.definesPresentationContext = YES;
    _searchController.searchBar.placeholder = @"Search restaurants...";
    _searchController.searchBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    _searchController.searchBar.barTintColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue: 240.0/255.0 alpha:0.6];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark -UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_searchController.active) {
        return _searchResultRestaurants.count;
    } else {
        return _restaurants.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
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
//        [_restaurants removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]  withRowAnimation:UITableViewRowAnimationFade];
        
        Restaurant *restaurant = [self.fetchedResultController objectAtIndexPath:indexPath];
        [self.restaurantMOC deleteObject:restaurant];
        
        NSError *error = nil;
        if(![self.restaurantMOC save:&error]) {
            NSLog(@"tableView delete cell error : %@", error);
        }
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

    Restaurant *restaurant = (_searchController.active) ? _searchResultRestaurants[indexPath.row] : _restaurants[indexPath.row];
    restaurantCell.nameLabel.text = restaurant.name;
    restaurantCell.thumbnailImageView.image = [UIImage imageWithData:restaurant.image];
    restaurantCell.locationLabel.text = restaurant.location;
    restaurantCell.typeLabel.text = restaurant.type;
    restaurantCell.accessoryType = [restaurant.isVisited boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return restaurantCell;
}

#pragma mark -RightBarButtonItem-
- (void)presentPhontViewController:(UIButton *)sender {
    NSLog(@"present the photoViewController");
    AddRestaurantViewController *addRestaurantViewController = [[AddRestaurantViewController alloc] init];
    addRestaurantViewController.restaurantMOC = self.restaurantMOC;
    addRestaurantViewController.navigationItem.hidesBackButton = YES;
    [self presentViewController:addRestaurantViewController animated:YES completion:nil];
}

#pragma mark -UISearchResultsUpdating-
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"qqqqq%ld", _searchResultRestaurants.count);
    if(_searchResultRestaurants.count != 0) {
        [_searchResultRestaurants removeAllObjects];
    }
    NSString *text = _searchController.searchBar.text;

    for (Restaurant *restaurant in _restaurants) {
        if ([text length] != 0 && [restaurant.name containsString:text]) {
            [_searchResultRestaurants addObject:restaurant];
        }
    }
    NSLog(@"%@", _searchResultRestaurants);
    if(_searchResultRestaurants.count != 0) {
        [self.foodRestaurantsTableView reloadData];
    }
}

#pragma mark -Create CoreData Context-
- (NSManagedObjectContext *)contextWithModelName:(NSString *)modelName {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", modelName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    context.persistentStoreCoordinator = coordinator;
    
    return context;
}

#pragma mark -NSFetchedResultsControllerDelegate-
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.foodRestaurantsTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.foodRestaurantsTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.foodRestaurantsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.foodRestaurantsTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.fetchedResultController.fetchedObjects];
    _restaurants = mutableArray;
    [self.foodRestaurantsTableView reloadData];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.foodRestaurantsTableView endUpdates];
}

- (void)createTestCoreData {
    for(int i = 0; i < _tempRestaurantArrays.count; i++)  {
        Restaurant *restaurant    = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.restaurantMOC];
        restaurant.name = ((Restaurants *)_tempRestaurantArrays[i]).name;
        restaurant.location = ((Restaurants *)_tempRestaurantArrays[i]).location;
        restaurant.type = ((Restaurants *)_tempRestaurantArrays[i]).type;
        restaurant.phoneNumber = ((Restaurants *)_tempRestaurantArrays[i]).phoneNumber;
        restaurant.isVisited = [NSNumber numberWithBool:((Restaurants *)_tempRestaurantArrays[i]).isVisited];
        restaurant.image = UIImagePNGRepresentation([UIImage imageNamed:((Restaurants *)_tempRestaurantArrays[i]).iamge]);
    }
    
    NSError *error = nil;
    if(self.restaurantMOC.hasChanges) {
        [self.restaurantMOC save:&error];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"hasDidLoadCoreData"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
