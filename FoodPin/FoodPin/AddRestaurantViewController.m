//
//  AddRestaurantViewController.m
//  FoodPin
//
//  Created by xuyafei on 16/11/21.
//  Copyright © 2016年 xuyafei. All rights reserved.
//
#import <CloudKit/CloudKit.h>
#import "AddRestaurantViewController.h"
#import "AddRestaurantInfoTableViewCell.h"
#import "AddPhotoTableViewCell.h"
#import "Restaurant.h"

typedef NS_ENUM(NSInteger, NavBarItemType) {
    NavBarItemCancel,
    NavBarItemSave
};

@interface AddRestaurantViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,AddRestaurantInfoTableViewCellDelegate,UINavigationControllerDelegate> {
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
    self.navigationItem.backBarButtonItem.customView.hidden = YES;
    [self initTitleView];
    [self initTableView];
    [self initSaveString];
}

- (void)initTitleView {
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancle" style:UIBarButtonItemStylePlain target:self action:@selector(navBarButtonItemDidClick:)];
    cancelItem.tag = NavBarItemCancel;
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(navBarButtonItemDidClick:)];
    saveItem.tag = NavBarItemSave;

    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@""];
    navItem.leftBarButtonItem = cancelItem;
    navItem.rightBarButtonItem = saveItem;
    [_navigationBar pushNavigationItem:navItem animated:false];
    [self.view addSubview:_navigationBar];
}

-(void)navBarButtonItemDidClick: (UIBarButtonItem*)sender{
    switch (sender.tag) {
        case NavBarItemCancel:
            [self dismissModelView];
            break;
        case NavBarItemSave:
            [self saveRestaurant];
            break;
        default:
            break;
    }
}

- (void)initTableView {
    _addRestaurantTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64)];
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

- (void)dismissModelView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveRestaurant {
    NSLog(@"save restaurant");

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
    
    [self saveRecordToCloud:addRestaurant];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -CloudKit Methods-
- (void) saveRecordToCloud:(Restaurant *)restaurant {
    CKRecord *record = [[CKRecord alloc] initWithRecordType:@"Restaurant"];
    [record setValue:restaurant.name forKey:@"name"];
    [record setValue:restaurant.type forKey:@"type"];
    [record setValue:restaurant.location forKey:@"location"];
    [record setValue:restaurant.phoneNumber forKey:@"phone"];
    
    UIImage *originalImage = [UIImage imageWithData:restaurant.image];
    CGFloat scalingFactor = originalImage.size.width > 1024 ? 1024 / originalImage.size.width : 1.0;
    UIImage *scaledImage = [UIImage imageWithData:restaurant.image scale:scalingFactor];

    NSString *imageFilePath = [NSTemporaryDirectory() stringByAppendingString:restaurant.name];
    [UIImageJPEGRepresentation(scaledImage, 0.8) writeToFile:imageFilePath atomically:YES];
    NSURL *imageFileURL = [NSURL fileURLWithPath:imageFilePath];
    CKAsset *imageAsset = [[CKAsset alloc] initWithFileURL:imageFileURL];
    [record setValue:imageAsset forKey:@"image"];
    
    CKContainer *defaultContainer = [CKContainer defaultContainer];
    CKDatabase *publicDatabase = [defaultContainer publicCloudDatabase];
    [publicDatabase saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if(error) {
            NSLog(@"%@", error);
            return;
        } else {
            [[NSFileManager defaultManager] removeItemAtPath:imageFilePath error:nil];
        }
    }];
}


@end
