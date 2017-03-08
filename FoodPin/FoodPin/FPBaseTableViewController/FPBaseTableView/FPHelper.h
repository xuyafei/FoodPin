//
//  FPHelper.h
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPHelper : NSObject

void validateInsertElementArgumentIndex(NSArray *arr, const NSInteger index, const void *file, const int line, const void *method);
void validateNoneInsertElementArgumentIndex(NSArray *arr, const NSInteger index, const void *file, const int line, const void *method);
@end
