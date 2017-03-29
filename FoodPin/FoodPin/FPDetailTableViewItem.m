//
//  FPDetailTableViewItem.m
//  FoodPin
//
//  Created by polycom on 2017/3/29.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPDetailTableViewItem.h"

@implementation FPDetailTableViewItem

- (instancetype)initWithFieldText:(NSString *)fieldText withNameText:(NSString *)nameText {
    self = [super init];
    
    if(self) {
        _fieldText = fieldText;
        _nameText = nameText;
    }
    return self;
}

@end
