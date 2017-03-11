//
//  FPTableViewDataSource.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPTableViewDataSource.h"
#import "FPTableViewCell.h"
#import "NSObject+FPIdentifier.h"
#import "FPTableViewHeaderFooterView.h"

@implementation FPTableViewDataSource

#pragma mark - TCDataSourceable

- (void)registerReusableCell {
    [self.tableView registerClass:FPTableViewCell.class forCellReuseIdentifier:FPTableViewCell.fp_identifier];
}

- (NSString *)reusableCellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    return FPTableViewCell.fp_identifier;
}

- (void)loadData:(id)data forReusableCell:(id)cell {
    FPTableViewCell *reusableCell = (FPTableViewCell *)cell;
    [reusableCell setupData:data];
}


#pragma mark - TCTableViewEditable

- (BOOL)canEditElementAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)commitEditingStyle:(UITableViewCellEditingStyle)style forData:(id)data {
    NSLog(@"%@", self.globalDataMetric);
}


@end

