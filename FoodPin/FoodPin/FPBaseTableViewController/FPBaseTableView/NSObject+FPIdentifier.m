//
//  NSObject+FPIdentifie.m
//  FoodPin
//
//  Created by polycom on 2017/3/8.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "NSObject+FPIdentifier.h"

@implementation NSObject (FPIdentifie)

+ (nonnull NSString *)fp_identifier {
    return NSStringFromClass(self.class);
}

+ (nonnull NSString *)fp_identifier2 {
    return [NSString stringWithFormat:@"%@2222", NSStringFromClass(self.class)];
}

@end
