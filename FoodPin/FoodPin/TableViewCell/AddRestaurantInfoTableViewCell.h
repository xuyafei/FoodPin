//
//  AddRestaurantInfoTableViewCell.h
//  FoodPin
//
//  Created by xuyafei on 16/11/21.
//  Copyright © 2016年 xuyafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddRestaurantInfoTableViewCellDelegate <NSObject>
- (void)setTextFieldText:(NSIndexPath *)indexPath withTextTextString:(NSString *)textString;
- (void)setButtonToggle:(BOOL)isHaveBeenThere;
@end

@interface AddRestaurantInfoTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *titleLable;
@property(nonatomic, strong)UITextField *detailTextField;
@property(nonatomic, strong)UIButton *yesButton;
@property(nonatomic, strong)UIButton *noButton;
@property(nonatomic, strong)NSIndexPath *currentIndexPath;
@property(nonatomic, weak)id<AddRestaurantInfoTableViewCellDelegate> delegate;
@end
