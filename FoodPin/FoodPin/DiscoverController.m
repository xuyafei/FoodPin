//
//  DiscoverController.m
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "DiscoverController.h"
#import "DiscoverPresenter.h"
#import "DiscoverTableViewCell.h"

@interface DiscoverController()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) DiscoverPresenter *presenter;

@property (copy, nonatomic) void(^didSelectedRowHandler)(CKRecord *);

@end

@implementation DiscoverController

+ (instancetype)inistanceWithPresenter:(DiscoverPresenter *)presenter {
    return [[DiscoverController alloc] initWithPresenter:presenter];
}

- (instancetype)initWithPresenter:(DiscoverPresenter *)presenter {
    if(self = [super init]) {
        self.discoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
        self.discoverTableView.delegate = self;
        self.discoverTableView.dataSource = self;
        self.discoverTableView.estimatedRowHeight = 230;
        self.discoverTableView.rowHeight = UITableViewAutomaticDimension;
        self.presenter = presenter;
        
        __weak typeof(self) weakSelf = self;
        self.discoverTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(NSError *error, id result){
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.discoverTableView.mj_header endRefreshing];
            
            if(!error) {
                [strongSelf.discoverTableView reloadData];
                [strongSelf.discoverTableView.mj_footer resetNoMoreData];
            }
        }];
    }
    return self;
}

- (void)fetchDataWithCompletionHander:(CloudworkCompletionHandler)completionHander {
    [self.presenter refreshDataPage:50 withRequireArray:@[@"name", @"type", @"location", @"image"] WithCompletionHandler:^(NSError *error, id result) {
        if(!error) {
            [self.discoverTableView reloadData];
        } else {
            NSLog(@"print something");
        }
        !completionHander ?: completionHander(error, result);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.presenter.allDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"discoverRestaurantCell";
    
    DiscoverTableViewCell *discoverRestaurantCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!discoverRestaurantCell) {
        discoverRestaurantCell = [[DiscoverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        discoverRestaurantCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    discoverRestaurantCell.presenter = self.presenter.allDatas[indexPath.row];
    
    return discoverRestaurantCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didSelectedRowHandler ?: self.didSelectedRowHandler(self.presenter.allDatas[indexPath.row].draft);
}

@end
