//
//  FPBaseViewController.m
//  FoodPin
//
//  Created by polycom on 2017/3/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FPBaseViewController.h"

@interface FPBaseViewController ()

@end

@implementation FPBaseViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if(self = [super init]) {
        [self createDataSource];
    }
    
    return self;
}

- (void)createDataSource {
    @throw [NSException exceptionWithName:@"Cann't use this method"
                                   reason:@"You can only call this method in subclass"
                                 userInfo:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView {
    self.tableView.fpDelegate = self;
    self.tableView.fpDataSource = self.dataSource;
}

- (FPBaseTableView *)tableView {
    if (!_tableView) {
        FPBaseTableView *tableView = [[FPBaseTableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
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
