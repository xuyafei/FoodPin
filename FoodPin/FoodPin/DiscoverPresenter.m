//
//  DiscoverPresenter.m
//  FoodPin
//
//  Created by polycom on 2017/3/31.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "DiscoverPresenter.h"
#import <CloudKit/CloudKit.h>

@interface DiscoverPresenter()

@property (assign, nonatomic) NSUInteger userID;
@property (strong, nonatomic) FoodPinUserAPIManager *apiManager;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<DiscoverCellPresenter *> *drafts;

@end

@implementation DiscoverPresenter

+ (instancetype)presentWithUserId:(NSUInteger)userId {
    return [[DiscoverPresenter alloc] initWithUserId: userId];
}

- (instancetype)initWithUserId:(NSInteger)userId {
    if(self = [super init]) {
        self.userID = userId;
        self.drafts = [NSMutableArray array];
        self.apiManager = [FoodPinUserAPIManager new];
    }
    
    return self;
}

- (NSArray *)allDatas {
    return self.drafts;
}

- (void)refreshDataPage:(NSInteger)page withRequireArray:(NSArray *)array WithCompletionHandler:(CloudworkCompletionHandler)completionHander {
    [self.apiManager refreshWithPage:page withRequireArray:array completionHandler:^(NSError *error, id result) {
        if(!error) {
            [self.drafts removeAllObjects];
            [self formatResult:result];
        } else {
            NSLog(@"print someThing");
        }
        
        !completionHander ?: completionHander(error, result);
    }];

}

- (void)formatResult:(NSArray *)drafts {
    for (CKRecord *draft in drafts) {
        [self.drafts addObject:[DiscoverCellPresenter presenterWithPorperty:draft]];
    }
    NSLog(@"%@", drafts);
}
@end
