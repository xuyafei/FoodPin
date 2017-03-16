//
//  FPTableViewDataSource.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPTableViewDataSource.h"
#import "FPTableViewBaseItem.h"
#import "FPTableViewSectionObject.h"
#import "FPTableViewBaseCell.h"

#import <objc/runtime.h>

@implementation FPTableViewDataSource

#pragma mark - FPTableViewDataSource
- (FPTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.sections.count > indexPath.section) {
        FPTableViewSectionObject *sectionObject = [self.sections objectAtIndex:indexPath.section];
        if([sectionObject.items count] > indexPath.row) {
            return [sectionObject.items objectAtIndex:indexPath.row];
        }
    }
    
    return nil;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(FPTableViewBaseItem *)object {
    return [FPTableViewBaseCell class];
}

- (void)clearAllItems {
    self.sections = [NSMutableArray arrayWithObject:[[FPTableViewSectionObject alloc] init]];
}

- (void)appenItem:(FPTableViewBaseItem *)item {
    FPTableViewSectionObject *firstSectionObject = [self.sections objectAtIndex:0];
    [firstSectionObject.items addObject:item];
}

#pragma mark - UITableViewDataSource Required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.sections.count > section) {
        FPTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.items.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FPTableViewBaseItem *object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    FPTableViewBaseCell* cell = (FPTableViewBaseCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    [cell setObject:object];
    
    return cell;
}

#pragma mark - UITableViewDataSource Optional
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections ? self.sections.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.sections.count > section) {
        FPTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.headerTitle;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(self.sections.count > section) {
        FPTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        if(sectionObject != nil && sectionObject.footerTitle != nil &&
           ![sectionObject.footerTitle isEqualToString:@""]) {
            return sectionObject.footerTitle;
        }
    }
    return nil;
}
@end
