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
#import "MapViewController.h"
#import "FoodPhotoBrowseCollectionViewController.h"
#import "FPBaseTableView.h"
#import "FPDetailRestaurantTableViewDataSource.h"
#import "FPDetailTableViewItem.h"

@interface RestaurantDetailViewController () <UITableViewDelegate, UITableViewDataSource, ReviewViewDelegate,UIViewControllerTransitioningDelegate,FPTableViewDelegate>
@property(nonatomic, weak) FPBaseTableView *restaurantDetailView;
@property(nonatomic, weak) UIButton *reviewButton;
@property(nonatomic, weak) UIButton *mapButton;
@property(nonatomic, weak) UIView *footView;
@property(nonatomic, copy) NSArray *cellArray;
@property(nonatomic, copy) NSArray *fieldArray;
@property (nonatomic, strong) FPDetailRestaurantTableViewDataSource *dataSource;
@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _baseItem.name;
    
    self.dataSource = [[FPDetailRestaurantTableViewDataSource alloc] init];
    [self initCellArray];
    
    self.presentAnimation = [[FoodPinPresentAnimation alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.restaurantDetailView.estimatedRowHeight = 36.0;
    self.restaurantDetailView.rowHeight = UITableViewAutomaticDimension;
    self.footView.frame = CGRectZero;
    self.headView.frame = CGRectMake(0, 0, ScreenWidth, 300);
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
    self.fieldArray = [@[_baseItem.name, _baseItem.type, _baseItem.location, (_baseItem.isVisited) ? @"Yes, I've been here before" : @"NO"] copy];
    [self.dataSource clearAllItems];

    for( int i = 0; i < self.cellArray.count; i++) {
        FPDetailTableViewItem *restaurantItem = [[FPDetailTableViewItem alloc] initWithFieldText:self.cellArray[i] withNameText:self.fieldArray[i]];
        [self.dataSource appenItem:restaurantItem];
    }

}

- (UITableView *)restaurantDetailView {
    if(!_restaurantDetailView) {
        FPBaseTableView *restaurantDetailView = [[FPBaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
        restaurantDetailView.fpDataSource = self.dataSource;
        restaurantDetailView.fpDelegate = self;
        restaurantDetailView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.2];
        restaurantDetailView.separatorColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.8];
        _restaurantDetailView = restaurantDetailView;
        [self.view addSubview:restaurantDetailView];
    }
    return _restaurantDetailView;
}

- (UIImageView *)headView {
    if(!_headView) {
        UIImageView *headView = [FPPublicUIKit imageViewContentMode:UIViewContentModeScaleAspectFill imageViewBackGroundColor:[UIColor redColor] imageViewClipsToBounds:YES imageViewUserInteractionEnabled:YES];
        headView.image = [UIImage imageWithData:_baseItem.image];
       
        self.restaurantDetailView.tableHeaderView = headView;
        _headView = headView;
    }
    return _headView;
}

- (UIButton *)reviewButton {
    if(!_reviewButton) {
        UIButton *reviewButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor redColor] buttonType:UIButtonTypeSystem buttonTintColor:[UIColor whiteColor] buttonCornerRadius:20 buttonWithImage:[[UIImage imageNamed:@"rating"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [reviewButton addTarget:self action:@selector(clickReview:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:reviewButton];
        _reviewButton = reviewButton;
    }
    return _reviewButton;
}

- (UIButton *)mapButton {
    if(!_mapButton) {
        UIButton *mapButton = [FPPublicUIKit buttonWithBackGroundColor:[UIColor redColor] buttonType:UIButtonTypeSystem buttonTintColor:[UIColor whiteColor] buttonCornerRadius:20 buttonWithImage:[[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        [mapButton addTarget:self action:@selector(clickMap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:mapButton];
        _mapButton = mapButton;
    }
    return _mapButton;
}

- (UIView *)footView {
    if(!_footView) {
        UIView *footView = [[UIView alloc] init];
        self.restaurantDetailView.tableFooterView = footView;
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
    foodPhotoBrowse.image = _baseItem.image;
    foodPhotoBrowse.transitioningDelegate = self;
    foodPhotoBrowse.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:foodPhotoBrowse animated:YES completion:nil];
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
    //mapViewController.theRestaurant = self.restaurant;
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
