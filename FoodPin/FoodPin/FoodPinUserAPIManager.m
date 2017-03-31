//
//  FoodPinUserAPIManager.m
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 永康范. All rights reserved.
//

#import "FoodPinUserAPIManager.h"
#import <CloudKit/CloudKit.h>

@implementation FoodPinUserAPIManager

- (void)fetchUserInfoWithUserID:(NSUInteger)userID CompletionHandler:(CloudworkCompletionHandler)completionHandler {
    CKContainer *defaultContainer = [CKContainer defaultContainer];
    CKDatabase *publicDatabase = [defaultContainer publicCloudDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Restaurant" predicate:predicate];
    query.sortDescriptors = @ [[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    CKQueryOperation *queryOperation = [[CKQueryOperation alloc] initWithQuery:query];
    queryOperation.desiredKeys = @[@"name", @"type", @"location"];
    queryOperation.queuePriority = NSOperationQueuePriorityVeryHigh;
    queryOperation.qualityOfService = NSQualityOfServiceUserInteractive;
    queryOperation.resultsLimit = 50;
    
    NSMutableArray *restaurants = [NSMutableArray array];
    
    queryOperation.recordFetchedBlock = ^(CKRecord *record) {
        [restaurants addObject:record];
    };
    
    queryOperation.queryCompletionBlock = ^(CKQueryCursor * _Nullable cursor, NSError * _Nullable operationError) {
        if(operationError) {
            NSLog(@"%@", operationError);
            dispatch_sync(dispatch_get_main_queue(), ^{
                !completionHandler ?: completionHandler(operationError, nil);
            });
            
            return;
        }
        
        NSLog(@"Successfully retrieve the data from iCloud");
       
        dispatch_sync(dispatch_get_main_queue(), ^{
            !completionHandler ?: completionHandler(nil, restaurants);
        });
    };
    [publicDatabase addOperation:queryOperation];
}
@end
