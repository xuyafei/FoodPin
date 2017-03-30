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
#import "RestaurantSearchResultViewController.h"
#import "FPBaseTableView.h"
#import "FPTableViewBaseItem.h"
#import "RestaurantHelper.h"
#import "FPRestaurantViewDataSource.h"

@interface RestaurantViewController () <UISearchResultsUpdating,NSFetchedResultsControllerDelegate,FPTableViewDelegate> {
    NSMutableArray *_restaurants;
    NSMutableArray *_searchResultRestaurants;
    NSMutableArray *_tempRestaurantArrays;
    UISearchController *_searchController;
    UIPageViewController *_pageViewController;
}
@property (nonatomic, weak)   FPBaseTableView *foodRestaurantsTableView;
@property (nonatomic, strong) NSManagedObjectContext *restaurantMOC;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController;
@property (nonatomic, strong) FPRestaurantViewDataSource *dataSource;
@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configCoreData];
    [self initRestaurantArray];
    self.dataSource = [[FPRestaurantViewDataSource alloc] init];
    [self fetchDataSuccess];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Food Pin";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentPhontViewController:)];
    [self initSearchContorller];
    self.foodRestaurantsTableView.estimatedRowHeight = 80;
    self.foodRestaurantsTableView.rowHeight = UITableViewAutomaticDimension;
    self.foodRestaurantsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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

- (void)configCoreData {
    RestaurantHelper *coreDataHelper = [[RestaurantHelper alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasDidLoadCoreData = [defaults boolForKey:@"hasDidLoadCoreData"];
    if(!hasDidLoadCoreData) {
        [coreDataHelper createTestCoreData];
    }
}

- (void)fetchDataSuccess {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    self.restaurantMOC = [self contextWithModelName:@"FoodPin"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasDidLoadCoreData = [defaults boolForKey:@"hasDidLoadCoreData"];
    if(hasDidLoadCoreData) {
        if(self.restaurantMOC != nil) {
            NSError *error = nil;
            
            self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.restaurantMOC sectionNameKeyPath:nil cacheName:nil];
            self.fetchedResultController.delegate = self;
            [self.fetchedResultController performFetch:&error];
            
            if(error) {
                NSLog(@"NSFetchedResultsController init error : %@", error);
                return;
            } else {
                [self.dataSource clearAllItems];
                _restaurants = [NSMutableArray arrayWithArray:self.fetchedResultController.fetchedObjects];
                for(Restaurant *restaurant in self.fetchedResultController.fetchedObjects) {
                    FPTableViewBaseItem *restaurantItem = [[FPTableViewBaseItem alloc] initWithImage:restaurant.image isVisited:restaurant.isVisited location:restaurant.location name:restaurant.name phoneNumber:restaurant.phoneNumber type:restaurant.type];
                    [self.dataSource appenItem:restaurantItem];
                }
            }
        }
    }
}

- (void)initRestaurantArray {
    _restaurants = [NSMutableArray array];
    _searchResultRestaurants = [NSMutableArray array];
}

- (FPBaseTableView *)foodRestaurantsTableView {
    if(!_foodRestaurantsTableView) {
        FPBaseTableView *foodRestaurantsTableView = [[FPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)/* style:UITableViewStyleGrouped*/];
        foodRestaurantsTableView.fpDataSource = self.dataSource;
        foodRestaurantsTableView.fpDelegate = self;
        _foodRestaurantsTableView = foodRestaurantsTableView;
        [self.view addSubview:foodRestaurantsTableView];
    }
    return _foodRestaurantsTableView;
}

- (void)initSearchContorller {
    RestaurantSearchResultViewController *searchResultViewController = [[RestaurantSearchResultViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchResultViewController];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:navController];
    self.foodRestaurantsTableView.tableHeaderView = _searchController.searchBar;
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = YES;
    _searchController.hidesNavigationBarDuringPresentation = YES;
    self.definesPresentationContext = YES;
    _searchController.searchBar.placeholder = @"Search restaurants...";
    _searchController.searchBar.tintColor = RGB(100.0, 100.0, 100.0, 1.0);
    _searchController.searchBar.barTintColor = RGB(240.0, 240.0, 240.0, 0.6);
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark -FPTableViewDelegate-
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    RestaurantDetailViewController *detailViewController = [[RestaurantDetailViewController alloc] init];
    detailViewController.baseItem = (FPTableViewBaseItem *)object;
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
        
        Restaurant *restaurant = [self.fetchedResultController objectAtIndexPath:indexPath];
        [self.restaurantMOC deleteObject:restaurant];
        
        NSError *error = nil;
        if(![self.restaurantMOC save:&error]) {
            NSLog(@"tableView delete cell error : %@", error);
        }
    }];
    
    shareAction.backgroundColor = RGB(28.0, 165.0, 253.0, 1.0);
    deleteAction.backgroundColor = RGB(202.0, 202.0, 203.0, 1.0);
    
    return @[shareAction, deleteAction];
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
    RestaurantSearchResultViewController *searchResultsViewController = ((RestaurantSearchResultViewController *)((UINavigationController *)searchController.searchResultsController).viewControllers[0]);
    searchResultsViewController.searchResultRestaurants = [NSMutableArray arrayWithArray:_searchResultRestaurants];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
