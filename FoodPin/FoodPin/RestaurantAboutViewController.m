//
//  RestaurantAboutViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/23.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import "RestaurantAboutViewController.h"
#import "WebViewController.h"

@import SafariServices;
@interface RestaurantAboutViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *_sectionTitle;
    NSArray *_secitonContentOne;
    NSArray *_secitonContentTwo;
    NSArray *_links;
}
@property (nonatomic, copy) NSArray *sectionTitle;
@property (nonatomic, copy) NSArray *secitonContentOne;
@property (nonatomic, copy) NSArray *secitonContentTwo;
@property (nonatomic, copy) NSArray *links;
@property (nonatomic, weak) UITableView *aboutTableView;
@property (nonatomic, weak) UIImageView *aboutHeadView;;
@end

@implementation RestaurantAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"About";
    [self initArrays];

    self.aboutTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.aboutTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.aboutHeadView.image = [UIImage imageNamed:@"about-logo"];
}

- (UITableView *)aboutTableView {
    if(!_aboutTableView) {
        UITableView *aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        aboutTableView.delegate = self;
        aboutTableView.dataSource = self;
        _aboutTableView = aboutTableView;
        [self.view addSubview:aboutTableView];
    }
    return _aboutTableView;
}

- (UIImageView *)aboutHeadView {
    if(!_aboutHeadView) {
        UIImageView *aboutHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 170)];
        self.aboutTableView.tableHeaderView = aboutHeadView;
        _aboutHeadView = aboutHeadView;
    }
    return _aboutHeadView;
}

- (void)initArrays {
    _sectionTitle = [@[@"Leave Feedback", @"Follow Us"] copy];
    _secitonContentOne = [@[@"Rate us on App Store", @"Tell us your feedback"] copy];
    _secitonContentTwo = [@[@"Twitter", @"Facebook", @"Pinterest"] copy];
    _links = [@[@"https://twitter.com/appcodamobile",
               @"https://facebook.com/appcodamobile", @"https://www.pinterest.com/appcoda/"] copy];
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
