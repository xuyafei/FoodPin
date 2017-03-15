//
//  RestaurantDetailViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/16.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "RestaurantDetailTableViewCell.h"
#import "ReviewViewController.h"
#import "Masonry.h"
#import "MapViewController.h"
#import "FoodPhotoBrowseCollectionViewController.h"

@interface RestaurantDetailViewController () <UITableViewDelegate, UITableViewDataSource, ReviewViewDelegate,UIViewControllerTransitioningDelegate>
@property(nonatomic, weak) UITableView *restaurantDetailView;
@property(nonatomic, weak) UIButton *reviewButton;
@property(nonatomic, weak) UIButton *mapButton;
@property(nonatomic, weak) UIView *footView;
@property(nonatomic, copy) NSArray *cellArray;
@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.restaurant.name;
    [self initCellArray];
    
    self.presentAnimation = [[FoodPinPresentAnimation alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.restaurantDetailView.estimatedRowHeight = 36.0;
    self.restaurantDetailView.rowHeight = UITableViewAutomaticDimension;
    self.footView.frame = CGRectZero;
    self.headView.image = [UIImage imageWithData:self.restaurant.image];
    
    [self addGesture];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //self.navigationController.hidesBarsOnSwipe = NO;
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initCellArray {
    self.cellArray = [@[@"Name", @"Type", @"Location", @"Been here"] copy];
}

- (UITableView *)restaurantDetailView {
    if(!_restaurantDetailView) {
        UITableView *restaurantDetailView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        restaurantDetailView.delegate = self;
        restaurantDetailView.dataSource = self;
        restaurantDetailView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.2];
        restaurantDetailView.separatorColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.8];
        _restaurantDetailView = restaurantDetailView;
        [self.view addSubview:restaurantDetailView];
    }
    return _restaurantDetailView;
}

- (UIImageView *)headView {
    if(!_headView) {
        UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
        headView.backgroundColor = [UIColor redColor];
        headView.contentMode = UIViewContentModeScaleAspectFill;
        headView.clipsToBounds = YES;
        headView.userInteractionEnabled=YES;
        self.restaurantDetailView.tableHeaderView = headView;
        _headView = headView;
    }
    return _headView;
}

- (UIButton *)reviewButton {
    if(!_reviewButton) {
        UIButton *reviewButton = [UIButton buttonWithType:UIButtonTypeSystem];
        reviewButton.layer.cornerRadius = 20;
        [reviewButton setBackgroundImage:[[UIImage imageNamed:@"rating"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        reviewButton.backgroundColor = [UIColor redColor];
        [reviewButton setTintColor:[UIColor whiteColor]];
        [reviewButton addTarget:self action:@selector(clickReview:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:reviewButton];
        _reviewButton = reviewButton;
    }
    return _reviewButton;
}

- (UIButton *)mapButton {
    if(!_mapButton) {
        UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeSystem];
        mapButton.layer.cornerRadius = 20;
        [mapButton setBackgroundImage:[[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        mapButton.backgroundColor = [UIColor redColor];
        [mapButton setTintColor:[UIColor whiteColor]];
        [mapButton addTarget:self action:@selector(clickMap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mapButton];
        _mapButton = mapButton;
    }
    return _mapButton;
}

- (UIView *)footView {
    if(!_footView) {
        UIView *footView = [[UIView alloc] init];
        _restaurantDetailView.tableFooterView = footView;
        _footView = footView;
    }
    return _footView;
}

- (void)configView {
        [self.reviewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(72);
        make.right.mas_equalTo(self.view.mas_right).offset(-7);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.mapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.reviewButton.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-7);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}

- (void)dealloc {
    NSLog(@"print the delloc");
}

#pragma mark -UITapGestureRecognize-
- (void)addGesture {
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [_headView addGestureRecognizer:tapGesture];
}

-(void)tapImage:(UITapGestureRecognizer *)gesture {
    NSLog(@"tap the tableview headview");
    FoodPhotoBrowseCollectionViewController *foodPhotoBrowse = [[FoodPhotoBrowseCollectionViewController alloc] init];
    foodPhotoBrowse.image = self.restaurant.image;
    foodPhotoBrowse.transitioningDelegate = self;
    foodPhotoBrowse.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:foodPhotoBrowse animated:YES completion:nil];
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
    reviewViewController.delegate = self;
    [self presentViewController:reviewViewController animated:YES completion:nil];
}

- (void)clickMap:(UIButton *)sender {
    NSLog(@"click the map");
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.theRestaurant = self.restaurant;
    [self.navigationController pushViewController:mapViewController animated:YES];
}

#pragma mark -ReviewViewDelegate-
- (void)setButtonImage:(NSString *)buttonBackgoundImage {
    [_reviewButton setBackgroundImage:[[UIImage imageNamed:buttonBackgoundImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

#pragma mark -UIViewControllerTransitioningDelegate-
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.presentAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presentAnimation.isPresentAnimationing = NO;
    return self.presentAnimation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
