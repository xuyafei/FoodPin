//
//  FoodPinSegmentControl.m
//  FoodPin
//
//  Created by polycom on 2017/4/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "FoodPinSegmentControl.h"

@interface FoodPinSegmentControl()

@property (nonatomic, weak) UISegmentedControl *segmentControl;
@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSArray *segmentArray;

@end

@implementation FoodPinSegmentControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self configImageArray];
        [self configView];
    }
    
    return self;
}

- (void)configImageArray {
    NSArray *array = @[@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg", @"cafeloisl.jpg", @"petiteoyster.jpg"];
    self.imageArray = [NSMutableArray array];
    for(NSString *imageString in array) {
        UIImage *image = [UIImage imageNamed:imageString];
        [self.imageArray addObject:image];
    }
    
    self.segmentArray = @[@"HOST", @"EVENT", @"LOCATION"];
}

- (UISegmentedControl *)segmentControl {
    if(!_segmentControl) {
        UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:self.segmentArray];
        segmentControl.frame = CGRectMake(0, 0, ScreenWidth, 45);
        segmentControl.tintColor = [UIColor clearColor];
        [segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
        [segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(244.0, 136.0, 139.0, 1.0)} forState:UIControlStateSelected];
        segmentControl.selectedSegmentIndex = 0;
        _segmentControl = segmentControl;
        [self addSubview:segmentControl];
    }
    
    return _segmentControl;
}

- (UIView *)lineView {
    if(!_lineView) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth / 3, 2)];
        [self addSubview:lineView];
        _lineView = lineView;
    }
    
    return _lineView;
}

- (void)configView {
    [self.segmentControl addTarget:self action:@selector(controllerPressed:) forControlEvents:UIControlEventValueChanged];
    self.lineView.backgroundColor = RGB(244.0, 136.0, 139.0, 1.0);
}

- (void)controllerPressed:(UISegmentedControl *)sender {
    [self lineViewAnimation:[sender selectedSegmentIndex]];
}

- (void)lineViewAnimation:(NSInteger)segmentIndex {
    CGRect lineFrame = self.lineView.frame;
    lineFrame.origin.x = ScreenWidth / 3 * segmentIndex;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.frame = lineFrame;
    }];
}
@end
