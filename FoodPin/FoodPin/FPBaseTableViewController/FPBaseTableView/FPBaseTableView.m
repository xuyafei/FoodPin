//
//  FPBaseTableView.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 永康范. All rights reserved.
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
    if(editingStyle == UITableViewCellEditingStyleDelete) {
       // [_restaurants removeObjectAtIndex:indexPath.row];
    }
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]  withRowAnimation:UITableViewRowAnimationFade];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //NSString *defaultText =[NSString stringWithFormat:@"Just checking in at%@",((Restaurant*)_restaurants[indexPath.row]).name];
        //UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObject:defaultText] applicationActivities:nil];
        //[self presentViewController:activityController animated:YES completion:nil];
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //        [_restaurants removeObjectAtIndex:indexPath.row];
        //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]]  withRowAnimation:UITableViewRowAnimationFade];
        
       /* Restaurant *restaurant = [self.fetchedResultController objectAtIndexPath:indexPath];
        [self.restaurantMOC deleteObject:restaurant];
        
        NSError *error = nil;
        if(![self.restaurantMOC save:&error]) {
            NSLog(@"tableView delete cell error : %@", error);
        }*/
    }];
    
    shareAction.backgroundColor = [UIColor colorWithRed: 28.0/255.0 green:165.0/255.0 blue:253.0/255.0 alpha:1.0];
    deleteAction.backgroundColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:203.0/255.0 alpha:1.0];
    
    return @[shareAction, deleteAction];
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
