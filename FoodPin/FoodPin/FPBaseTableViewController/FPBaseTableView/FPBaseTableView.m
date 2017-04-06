//
//  FPBaseTableView.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPBaseTableView.h"
#import "FPTableViewBaseCell.h"
#import "FPTableViewSectionObject.h"
#import "FPTableViewBaseItem.h"

@implementation FPBaseTableView

- (instancetype)initWithFrame:(CGRect)frame /*style:(UITableViewStyle)style*/ {
    self = [super initWithFrame:frame /*style:style*/];
    
    if(self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.delegate = self;
    }
    
    return self;
}

- (void)setFpDataSource:(id<FPTableViewDataSource>)fpDataSource {
    if(_fpDataSource != fpDataSource) {
        _fpDataSource = fpDataSource;
        self.dataSource = fpDataSource;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<FPTableViewDataSource> dataSource = (id<FPTableViewDataSource>)tableView.dataSource;
    FPTableViewBaseItem *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    
    if(object.cellHeight == CellInvalidHeight) {
        object.cellHeight = [cls tableView:tableView rowHeightForObject:object];
    }
    
    return object.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.fpDelegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
        id<FPTableViewDataSource> dataSource = (id<FPTableViewDataSource>)tableView.dataSource;
        id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.fpDelegate didSelectObject:object atIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else if([self.fpDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.fpDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.fpDelegate respondsToSelector:@selector(headerViewForSectionObject:atSection:)]) {
        id<FPTableViewDataSource> dataSource = (id<FPTableViewDataSource>)tableView.dataSource;
        FPTableViewSectionObject *sectionObject = [((FPTableViewDataSource *)dataSource).sections objectAtIndex:section];
        
        return [self.fpDelegate headerViewForSectionObject:sectionObject atSection:section];
    }
    else if ([self.fpDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.fpDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.fpDelegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.fpDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.fpDelegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.fpDelegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }

    return nil;
}

#pragma mark - 传递原生协议

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.fpDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.fpDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
