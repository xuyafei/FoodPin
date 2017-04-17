//
//  DiscoverDetailController.m
//  FoodPin
//
//  Created by polycom on 2017/4/6.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "DiscoverDetailController.h"
#import "FoodPinDiscoverTitleView.h"
#import "FoodPinDiscoverHeadView.h"
#import "FoodPinSegmentControl.h"


@interface DiscoverDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) FoodPinDiscoverHeadView *headView;
@property (nonatomic, weak) UIView *backGroundView;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSArray *segmentArray;
@property (nonatomic, strong) FoodPinSegmentControl *segmentControl;


@end


@implementation DiscoverDetailController

+ (instancetype)initWithPresenter {
    return [[DiscoverDetailController alloc] initWithPresenter];
}

- (instancetype)initWithPresenter {
    if(self = [super init]) {
        self.discoverDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
        self.discoverDetailTableView.backgroundColor = [UIColor whiteColor];
        self.discoverDetailTableView.dataSource = self;
        self.discoverDetailTableView.delegate = self;
        self.discoverDetailTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.discoverDetailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self configImageArray];
        self.headView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)configImageArray {
    NSArray *array = @[@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg",@"cafeloisl.jpg", @"petiteoyster.jpg"];
    self.imageArray = [NSMutableArray array];
    for(NSString *imageString in array) {
        UIImage *image = [UIImage imageNamed:imageString];
        [self.imageArray addObject:image];
    }
    
    self.segmentArray = @[@"HOST", @"EVENT", @"LOCATION"];
}

- (FoodPinDiscoverHeadView *)headView {
    if(!_headView) {
        FoodPinDiscoverHeadView *headView = [[FoodPinDiscoverHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 385)];
        self.discoverDetailTableView.tableHeaderView = headView;
        _headView = headView;
    }
    return _headView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.segmentControl = [[FoodPinSegmentControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 47)];
    return self.segmentControl;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 47.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"discoverDetailRestaurantCell";
    
    UITableViewCell *discoverRestaurantCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!discoverRestaurantCell) {
        discoverRestaurantCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        discoverRestaurantCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    discoverRestaurantCell.textLabel.text = @"123456";
    
    return discoverRestaurantCell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset < 0) {
        CGFloat totalOffset = 200 + ABS(yOffset);
        CGFloat f = totalOffset / 200;
        
        _headView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
    }
}



@end
