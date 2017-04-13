//
//  DiscoverDetailController.m
//  FoodPin
//
//  Created by polycom on 2017/4/6.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "DiscoverDetailController.h"
#import "FoodPinCycleScrollView.h"

@interface DiscoverDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *headView;
@property (nonatomic, weak) FoodPinCycleScrollView *cycleHeadView;
@property (nonatomic, strong) NSMutableArray *imageArray;

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
        self.cycleHeadView.backgroundColor = [UIColor grayColor];
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
}

- (UIView *)cycleHeadView {
    if(!_cycleHeadView) {
        FoodPinCycleScrollView *cycleHeadView = [[FoodPinCycleScrollView alloc] initWithImages:self.imageArray];
        self.discoverDetailTableView.tableHeaderView = cycleHeadView;
        _cycleHeadView = cycleHeadView;
    }
    
    return _cycleHeadView;
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
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
