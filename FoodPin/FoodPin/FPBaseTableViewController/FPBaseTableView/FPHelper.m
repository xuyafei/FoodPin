//
//  FPHelper.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FPHelper.h"

@implementation FPHelper

void validateInsertElementArgumentIndex(NSArray *arr, const NSInteger index, const void *file, const int line, const void *method) {
    if (arr.count <= index) {
        NSString *message = [NSString stringWithFormat:@"index %@ extends beyond bounds: %s:%@:%s",
                             @(index), file, @(line), method];
        NSLog(@"%@", message);
        [[NSException exceptionWithName:@"Index beyond boundary." reason:message userInfo:nil] raise];
    }
}

void validateNoneInsertElementArgumentIndex(NSArray *arr, const NSInteger index, const void *file, const int line, const void *method) {
    if (arr.count < index) {
        NSString *message = [NSString stringWithFormat:@"index %@ extends beyond bounds: %s:%@:%s",
                             @(index), file, @(line), method];
        NSLog(@"%@", message);
        [[NSException exceptionWithName:@"Index beyond boundary." reason:message userInfo:nil] raise];
    }
}

@end
