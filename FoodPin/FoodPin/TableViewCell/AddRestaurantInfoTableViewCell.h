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

@property(nonatomic, weak)UILabel *titleLable;
@property(nonatomic, weak)UITextField *detailTextField;
@property(nonatomic, weak)UIButton *yesButton;
@property(nonatomic, weak)UIButton *noButton;
@property(nonatomic, strong)NSIndexPath *currentIndexPath;
@property(nonatomic, weak)id<AddRestaurantInfoTableViewCellDelegate> delegate;
@end
