//
//  GTPickerView_TextField.h
//  merchant
//
//  Created by George Triarhos on 1/9/16.
//  Copyright © 2016 gtsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTextField.h"

@interface GTPickerView_TextField : GTTextField <UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString *column_id;
@property (nonatomic, strong) NSString *column_text;
@property (nonatomic, retain) NSNumber *selected_id;
@property (nonatomic, copy) NSMutableArray *input_array;
@property (strong, nonatomic) IBOutlet UIPickerView *pv;

@property (nonatomic, assign)  NSInteger default_row;
@property (nonatomic, retain) NSNumber *default_id;

- (void)Set_Default;
- (void)Set_Selected;

@end
