//
//  FPDetailTableViewItem.h
//  FoodPin
//
//  Created by polycom on 2017/3/29.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPTableViewBaseItem.h"

@interface FPDetailTableViewItem : FPTableViewBaseItem

@property (nonatomic, strong) NSString *fieldText;
@property (nonatomic, strong) NSString *nameText;

- (instancetype)initWithFieldText:(NSString *)fieldText withNameText:(NSString *)nameText;

@end
