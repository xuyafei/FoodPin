//
//  RestaurantAboutViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/23.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "RestaurantAboutViewController.h"
#import "WebViewController.h"

@import SafariServices;
@interface RestaurantAboutViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_aboutTableView;
    UIImageView *_aboutHeadView;
    NSArray *_sectionTitle;
    NSArray *_secitonContentOne;
    NSArray *_secitonContentTwo;
    NSArray *_links;
}
@end

@implementation RestaurantAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"About";
    [self initArrays];
    [self initAboutTableView];
    [self initAboutTableHeadView];
}

- (void)initAboutTableView {
    _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _aboutTableView.delegate = self;
    _aboutTableView.dataSource = self;
    _aboutTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _aboutTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//UIView(frame: CGRectZero)
    [self.view addSubview:_aboutTableView];
}

- (void)initAboutTableHeadView {
    _aboutHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 170)];
    _aboutHeadView.image = [UIImage imageNamed:@"about-logo"];
    _aboutTableView.tableHeaderView = _aboutHeadView;
}

- (void)initArrays {
    _sectionTitle = @[@"Leave Feedback", @"Follow Us"];
    _secitonContentOne = @[@"Rate us on App Store", @"Tell us your feedback"];
    _secitonContentTwo = @[@"Twitter", @"Facebook", @"Pinterest"];
    _links = @[@"https://twitter.com/appcodamobile",
               @"https://facebook.com/appcodamobile", @"https://www.pinterest.com/appcoda/"];
}

#pragma mark UITableViewDelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * orderCellIdentifier = @"ordercell";
        UITableViewCell * orderCell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
        if (!orderCell) {
            orderCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            orderCell.textLabel.text = _secitonContentOne[indexPath.row];
        }
        return orderCell;
    } else {
        static NSString * myIdentifier = @"mycell";
        UITableViewCell * myCell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (!myCell) {
            myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
            myCell.selectionStyle = UITableViewCellSelectionStyleNone;
            myCell.textLabel.text = _secitonContentTwo[indexPath.row];
        }
        return myCell;
    }    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionTitle[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0) {
        return 2;
    } else {
        return 3;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            NSURL *url = [NSURL URLWithString:@"http://www.apple.com/itunes/charts/paid-apps/"];
            [[UIApplication sharedApplication] openURL:url];
        } else {
            WebViewController *webViewController = [[WebViewController alloc] init];
            [self.navigationController pushViewController:webViewController animated:YES];
        }
    } else if(indexPath.section == 1) {
        NSURL *url = [NSURL URLWithString:_links[indexPath.row]];
        SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:url entersReaderIfAvailable:NO];
        //safariVC.delegate = self;
        [self presentViewController:safariVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
