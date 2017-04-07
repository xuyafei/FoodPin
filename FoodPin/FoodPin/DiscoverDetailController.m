//
//  DiscoverDetailController.m
//  FoodPin
//
//  Created by polycom on 2017/4/6.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "DiscoverDetailController.h"

@interface DiscoverDetailController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIView *headView;

@end


@implementation DiscoverDetailController

+ (instancetype)initWithPresenter {
    return [[DiscoverDetailController alloc] initWithPresenter];
}

- (instancetype)initWithPresenter {
    if(self = [super init]) {
        self.discoverDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeigth)];
        self.discoverDetailTableView.backgroundColor = [UIColor blackColor];
        self.discoverDetailTableView.dataSource = self;
        self.discoverDetailTableView.delegate = self;
        self.discoverDetailTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.discoverDetailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //self.headView.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (UIView *)headView {
    if(!_headView) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
        self.discoverDetailTableView.tableHeaderView = headView;
        _headView = headView;
    }
    return _headView;
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



@end
