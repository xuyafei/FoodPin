//
//  RestaurantDiscoverViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/23.
//  Copyright © 2016年 永康范. All rights reserved.
//
#import <CloudKit/CloudKit.h>
#import "RestaurantDiscoverViewController.h"

@interface RestaurantDiscoverViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_recordID;
    NSCache *_imageCache;
}
@property(nonatomic, strong) UITableView *discoverTableView;
@end

@implementation RestaurantDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Discover";
    _recordID = [NSMutableArray array];
    _imageCache = [[NSCache alloc] init];
    [self layoutDiscoverTableView];
    [self getRecordsFormCloud];
}

- (void)layoutDiscoverTableView {
    self.discoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.discoverTableView.delegate = self;
    self.discoverTableView.dataSource = self;
    [self.view addSubview:self.discoverTableView];
}

- (void)getRecordsFormCloud {
    CKContainer *defaultContainer = [CKContainer defaultContainer];
    CKDatabase *publicDatabase = [defaultContainer publicCloudDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Restaurant" predicate:predicate];
    query.sortDescriptors = @ [[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    CKQueryOperation *queryOperation = [[CKQueryOperation alloc] initWithQuery:query];
    queryOperation.desiredKeys = @[@"name"];
    queryOperation.queuePriority = NSOperationQueuePriorityHigh;
    queryOperation.resultsLimit = 50;
    queryOperation.recordFetchedBlock = ^(CKRecord *record) {
        [_recordID addObject:record];
    };
    queryOperation.queryCompletionBlock = ^(CKQueryCursor * _Nullable cursor, NSError * _Nullable operationError) {
        if(operationError) {
            NSLog(@"%@", operationError);
            return;
        }
        
        NSLog(@"Successfully retrieve the data from iCloud");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.discoverTableView reloadData];
        });
    };
    [publicDatabase addOperation:queryOperation];
}

#pragma mark -UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _recordID.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -UITableViewDataSource-
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"discoverRestaurantCell";
    
    UITableViewCell *discoverRestaurantCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!discoverRestaurantCell) {
        discoverRestaurantCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        discoverRestaurantCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CKRecord *restaurantRecord = _recordID[indexPath.row];
    discoverRestaurantCell.textLabel.text = [restaurantRecord objectForKey:@"name"];
    discoverRestaurantCell.imageView.image = [UIImage imageNamed:@"photoalbum"];
    
    NSURL *imageFileURL = (NSURL *)[_imageCache objectForKey:restaurantRecord.recordID];
    if(imageFileURL) {
        NSLog(@"get image from cache");
        discoverRestaurantCell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageFileURL]];
    } else {
        CKFetchRecordsOperation *fetchRecordsImageOperation = [[CKFetchRecordsOperation alloc] initWithRecordIDs:@[restaurantRecord.recordID]];
        fetchRecordsImageOperation.desiredKeys = @[@"image"];
        fetchRecordsImageOperation.queuePriority = NSOperationQueuePriorityVeryHigh;
        fetchRecordsImageOperation.perRecordCompletionBlock = ^(CKRecord * _Nullable record, CKRecordID * _Nullable recordID, NSError * _Nullable error) {
            if(error) {
                NSLog(@"Failed to get restaurant image:%@",error.localizedDescription);
                return;
            }
            
            if(record) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    CKAsset *imageAsset = [record objectForKey:@"image"];
                    if(imageAsset != nil) {
                        NSLog(@"successfulley fetch the image");
                        discoverRestaurantCell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageAsset.fileURL]];
                        [_imageCache setObject:imageAsset.fileURL forKey:restaurantRecord.recordID];
                    } else {
                        NSLog(@"failure fetch the image");
                    }
                });
            }
        };
        fetchRecordsImageOperation.database = [[CKContainer defaultContainer] publicCloudDatabase];
        [fetchRecordsImageOperation start];
    }
    
    return discoverRestaurantCell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
