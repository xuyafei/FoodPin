//
//  AddRestaurantViewController.m
//  FoodPin
//
//  Created by 永康范 on 16/11/21.
//  Copyright © 2016年 永康范. All rights reserved.
//

#import "AddRestaurantViewController.h"
#import "AddRestaurantInfoTableViewCell.h"
#import "AddPhotoTableViewCell.h"
#import "Restaurant.h"

@interface AddRestaurantViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,AddRestaurantInfoTableViewCellDelegate> {
    UINavigationBar *_navigationBar;
    UITableView *_addRestaurantTableView;
    NSIndexPath *_currentIndexPath;
    NSIndexPath *_titleTextIndexPath;
    NSString *_name;
    NSString *_location;
    NSString *_type;
    NSString *_phoneNumber;
    UIImage *_image;
    NSNumber *_isVisited;
}

@end

@implementation AddRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTitleView];
    [self initTableView];
    [self initSaveString];
}

- (void)initTitleView {
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    UINavigationItem *leftItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissModelView:)];
    leftItem.leftBarButtonItem = leftBarButtonItem;
    [_navigationBar pushNavigationItem:leftItem animated:NO];
    
    UINavigationItem *rightItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveRestaurant:)];
    rightItem.rightBarButtonItem = rightBarButtonItem;
    [_navigationBar pushNavigationItem:rightItem animated:NO];
    
    [self.view addSubview:_navigationBar];
}

- (void)initTableView {
    _addRestaurantTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64)];
    _addRestaurantTableView.delegate = self;
    _addRestaurantTableView.dataSource = self;
    [self.view addSubview:_addRestaurantTableView];
}

- (void)initSaveString {
    _name = @"";
    _type = @"";
    _location = @"";
    _phoneNumber = @"";
}

#pragma mark -UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 250;
    } else {
        return 72;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        _currentIndexPath = indexPath;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.allowsEditing = YES;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
}

#pragma mark -UITableViewDataSource-
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"addRestaurantPhotoCell";
        AddPhotoTableViewCell *addRestaurantPhotoCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
       
        if (!addRestaurantPhotoCell) {
            addRestaurantPhotoCell = [[AddPhotoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            addRestaurantPhotoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            addRestaurantPhotoCell.photoImageView.image = [UIImage imageNamed:@"photoalbum"];
            addRestaurantPhotoCell.backgroundColor = [UIColor lightGrayColor];
        }
        return addRestaurantPhotoCell;
    } else {
        static NSString * addRestaurantIdentifier = @"addRestaurantInfoCell";
        AddRestaurantInfoTableViewCell * infoTableViewCell = [tableView dequeueReusableCellWithIdentifier:addRestaurantIdentifier];
        
        if (!infoTableViewCell) {
            infoTableViewCell = [[AddRestaurantInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addRestaurantIdentifier];
            infoTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
            infoTableViewCell.delegate = self;
           
            if(indexPath.row == 1) {
                infoTableViewCell.titleLable.text = @"NAME";
                infoTableViewCell.detailTextField.placeholder = @"Restaurant name";
            } else if(indexPath.row == 2) {
                infoTableViewCell.titleLable.text = @"TYPE";
                infoTableViewCell.detailTextField.placeholder = @"Restaurant type";
            } else if(indexPath.row == 3) {
                infoTableViewCell.titleLable.text = @"LOCATION";
                infoTableViewCell.detailTextField.placeholder = @"Restaurant location";
            } else if(indexPath.row == 4) {
                infoTableViewCell.titleLable.text = @"PHONE NUMBER";
                infoTableViewCell.detailTextField.placeholder = @"Restaurant Phone Number";
            } else if(indexPath.row == 5) {
                infoTableViewCell.titleLable.text = @"HAVE YOU BEEN HERE";
            }
            infoTableViewCell.currentIndexPath = indexPath;
            
            if(indexPath.row != 5) {
                infoTableViewCell.yesButton.hidden = YES;
                infoTableViewCell.noButton.hidden = YES;
                infoTableViewCell.detailTextField.hidden = NO;
            } else {
                infoTableViewCell.yesButton.hidden = NO;
                infoTableViewCell.noButton.hidden = NO;
                infoTableViewCell.detailTextField.hidden = YES;
            }
        }
        _titleTextIndexPath = indexPath;
        return infoTableViewCell;
    }
}

#pragma mark -UIImagePickerControllerDelegate-
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    AddPhotoTableViewCell *cell = [_addRestaurantTableView cellForRowAtIndexPath:_currentIndexPath];
    cell.photoImageView.image = image;
    _image = image;
    [cell updateContentViewConstraints];
}

#pragma mark -AddRestaurantInfoTableViewCellDelegate-
- (void)setTextFieldText:(NSIndexPath *)indexPath withTextTextString:(NSString *)textString {
    if(indexPath.row == 1) {
        _name = textString;
    } else if(indexPath.row == 2) {
        _type = textString;
    } else if(indexPath.row == 3) {
        _location = textString;
    } else if(indexPath.row == 4) {
        _phoneNumber = textString;
    }
}

- (void)setButtonToggle:(BOOL)isHaveBeenThere {
    _isVisited = [NSNumber numberWithBool:isHaveBeenThere];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"print something");
}

- (void)dismissModelView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveRestaurant:(UIButton *)sender {
    NSLog(@"save restaurant");
    NSLog(@"%@", _name);
    NSLog(@"%@", _type);
    NSLog(@"%@", _location);
    NSLog(@"%@", _phoneNumber);

    if([_name isEqualToString:@""] || [_type isEqualToString:@""] || [_location isEqualToString:@""] || [_phoneNumber isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"We can't proceed because one of the fields is blank. Please note that all fields are required." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    Restaurant *addRestaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:self.restaurantMOC];
    
    addRestaurant.location = _location;
    addRestaurant.type = _type;
    addRestaurant.name = _name;
    addRestaurant.phoneNumber = _phoneNumber;
    addRestaurant.isVisited = _isVisited;
    addRestaurant.image = UIImagePNGRepresentation(_image);
    
    NSError *error = nil;
    if (self.restaurantMOC.hasChanges) {
        [self.restaurantMOC save:&error];
    }
    
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
