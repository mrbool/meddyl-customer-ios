//
//  GTPickerView_TextField.m
//  merchant
//
//  Created by George Triarhos on 1/9/16.
//  Copyright © 2016 gtsoft. All rights reserved.
//

#import "GTPickerView_TextField.h"

@implementation GTPickerView_TextField

@synthesize column_id;
@synthesize column_text;
@synthesize input_array;
@synthesize selected_id;
@synthesize pv;

@synthesize default_id;
@synthesize default_row;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
//        pv = [[UIPickerView alloc]init];
//        pv.delegate = self;
//        pv.dataSource = self;
//        pv.showsSelectionIndicator = YES;
//        self.inputView = pv;
//        
//        UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap)];
//        [pv addGestureRecognizer:gestureRecognizer];
//        gestureRecognizer.delegate = self;
    }
    
    return self;
}


-(void)Initialize
{
    [super Initialize];
        
    pv = [[UIPickerView alloc]init];
    pv.delegate = self;
    pv.dataSource = self;
    pv.showsSelectionIndicator = YES;
    self.inputView = pv;
    
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap)];
    [pv addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.delegate = self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

- (void)Tap
{
    NSInteger row = [pv selectedRowInComponent:0];
    self.text = [[input_array objectAtIndex:row] valueForKey:column_text];
    selected_id = [[input_array objectAtIndex:row] valueForKey:column_id];
}

- (void)Set_Selected
{
    selected_id = default_id;
}

- (void)Set_Default
{
    [pv selectRow:(int)default_row inComponent:0 animated:YES];
    //self.text = [[input_array objectAtIndex:default_row] valueForKey:column_text];
    //selected_id = [[input_array objectAtIndex:default_row] valueForKey:column_id];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return input_array.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSNumber *current_id = [[input_array objectAtIndex:row] valueForKey:column_id];
    if([selected_id isEqual:current_id])
    {
        default_row = row;
        
        [self Set_Default];
    }
    
    return  [[input_array objectAtIndex:row] valueForKey:column_text];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.text = [[input_array objectAtIndex:row] valueForKey:column_text];
    selected_id = [[input_array objectAtIndex:row] valueForKey:column_id];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    selected_id = 0;
    
    return YES;
}

@end
