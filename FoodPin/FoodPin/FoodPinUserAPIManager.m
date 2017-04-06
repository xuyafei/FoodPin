//
//  FoodPinUserAPIManager.m
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FoodPinUserAPIManager.h"
#import <CloudKit/CloudKit.h>

@implementation FoodPinUserAPIManager

- (void)fetchWithPage:(NSInteger)page withRequireArray:(NSArray *)array CompletionHandler:(CloudworkCompletionHandler)completionHandler {
    [self refreshWithPage:page withRequireArray:array completionHandler:completionHandler];
}

- (void)refreshWithPage:(NSInteger)page withRequireArray:(NSArray *)array completionHandler:(CloudworkCompletionHandler)completionHandler {
    CKContainer *defaultContainer = [CKContainer defaultContainer];
    CKDatabase *publicDatabase = [defaultContainer publicCloudDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Restaurant" predicate:predicate];
    query.sortDescriptors = @ [[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    CKQueryOperation *queryOperation = [[CKQueryOperation alloc] initWithQuery:query];
    queryOperation.desiredKeys = array;
    queryOperation.queuePriority = NSOperationQueuePriorityVeryHigh;
    queryOperation.qualityOfService = NSQualityOfServiceUserInteractive;
    queryOperation.resultsLimit = page;
    
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
