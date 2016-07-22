#import "Search_Settings.h"


@interface Search_Settings ()
{
    GTLabel* lblDistance;
    UISlider* sldDistance;
    GTTextField* txtZipCode;
    
    NSMutableArray* buttons;
    NSNumber* search_location_type_id;
    
    BOOL keyboardIsShown;
}
@end


@implementation Search_Settings

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.screen_title = @"SETTINGS";
    self.left_button = @"back";
    self.right_button = @"save";
    
    [self Set_Controller_Properties];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    keyboardIsShown = NO;

    [self Create_Layout];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* public methods */
-(void)Create_Layout
{
    [self Progress_Show:@"Loading"];
    
    [self.customer_controller Get_Customer_Profile:^(void)
     {
         successful = self.customer_controller.successful;
         system_successful_obj = self.customer_controller.system_successful_obj;
         system_error_obj = self.customer_controller.system_error_obj;
         
         [self Progress_Close];
         
         if(successful)
         {
             Customer* customer_obj = self.customer_controller.customer_obj;
             
             GTLabel* lblDistanceLabel = [Coding Create_Label:@"Distance" width:self.screen_indent_width_half font:label_font_medium mult:NO];
             [Coding Add_View:contentView view:lblDistanceLabel x:self.screen_indent_x height:[Utilities Get_Height:lblDistanceLabel] prev_frame:CGRectNull gap:(self.gap * 10)];

             lblDistance = [Coding Create_Label:@"" width:self.screen_indent_width_half font:label_font_medium mult:NO];
             CGFloat right_label_x = self.screen_width - (self.gap * 20);
             [Coding Add_View:contentView view:lblDistance x:right_label_x height:[Utilities Get_Height:lblDistance] prev_frame:CGRectNull gap:(self.gap * 10)];

             CGFloat slider_height = (self.screen_height * .0525);
             sldDistance = [[UISlider alloc] initWithFrame:CGRectMake(0.0, 0.0, self.screen_indent_width, slider_height)];
             sldDistance.minimumValue = [self.system_controller.system_settings_obj.customer_deal_range_min floatValue];
             sldDistance.maximumValue = [self.system_controller.system_settings_obj.customer_deal_range_max floatValue];
             sldDistance.value = [self.customer_controller.customer_obj.deal_range floatValue];
             sldDistance.minimumTrackTintColor = [UIColor redColor];
             sldDistance.maximumTrackTintColor = [UIColor lightGrayColor];
             [self sldDistance_Changed];

             [sldDistance addTarget:self action:@selector(sldDistance_Changed) forControlEvents:UIControlEventValueChanged];
             [Coding Add_View:contentView view:sldDistance x:self.screen_indent_x height:sldDistance.frame.size.height prev_frame:lblDistanceLabel.frame gap:(self.gap)];

             GTLabel *lblLocationType = [Coding Create_Label:@"Select a location search type" width:self.screen_indent_width font:label_font_medium mult:NO];
             [Coding Add_View:contentView view:lblLocationType x:self.screen_indent_x height:[Utilities Get_Height:lblLocationType] prev_frame:sldDistance.frame gap:(self.gap * 14)];

             CGRect previous_frame = lblLocationType.frame;

             buttons = [NSMutableArray arrayWithCapacity:2];
             CGRect btnRect = CGRectMake(25, 200, self.screen_width, 30);
             for (NSString* optionTitle in @[@"Current Location", @"Zip Code"])
             {
                 RadioButton* btn = [[RadioButton alloc] initWithFrame:btnRect];
                 [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
                 btnRect.origin.y += 30;
                 [btn setTitle:optionTitle forState:UIControlStateNormal];
                 [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                 btn.titleLabel.font = label_font;
                 [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                 [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                 btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                 btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
                
                 [Coding Add_View:contentView view:btn x:(self.screen_indent_x * 2) height:btn.frame.size.height prev_frame:previous_frame gap:(self.gap * 2)];
                 previous_frame = btn.frame;
                
                 [buttons addObject:btn];
             }
             [buttons[0] setGroupButtons:buttons]; // Setting buttons into the group
             
             if([customer_obj.customer_search_location_type_obj.search_location_type_id  isEqual: @1])
             {
                 [buttons[0] setSelected:YES];
                 search_location_type_id = @1;
             }
             else
             {
                 [buttons[1] setSelected:YES];
                 search_location_type_id = @2;
             }
             // Making the first button initially selected

             txtZipCode = [Coding Create_Text_Field:@"Zip Code" format_type:@"zipcode" characters:@20 width:(self.screen_indent_width * .4) height:self.text_field_height font:text_field_font];
             [txtZipCode setBackgroundColor:[UIColor whiteColor]];
             [txtZipCode.layer setBorderColor:[UIColor grayColor].CGColor];
             [txtZipCode.layer setBorderWidth:1.0];
             [txtZipCode.layer setCornerRadius:5.0f];
             txtZipCode.text = self.customer_controller.customer_obj.zip_code_obj.zip_code;
             [Coding Add_View:contentView view:txtZipCode x:(self.screen_indent_x * 2) height:txtZipCode.frame.size.height prev_frame:previous_frame gap:(self.gap * 2)];
             
             [self Add_View:self.screen_width height:[self Get_Scroll_Height:self.view.frame scroll_lag:0] background_color:[UIColor whiteColor]];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
     }];
}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    // Lets handle ValueChanged event only for selected button, and ignore for deselected
    if(sender.selected)
    {
        NSLog(@"Selected color: %@", sender.titleLabel.text);
        if([sender.titleLabel.text isEqualToString:@"Current Location"])
            search_location_type_id = @1;
        else
            search_location_type_id = @2;
    }
}

- (void)sldDistance_Changed
{
    [lblDistance setText:[NSString stringWithFormat:@"%d mi.",(int)sldDistance.value]];
}

-(void)Save_Click
{
    NSNumber* deal_range = [NSNumber numberWithInt:sldDistance.value];
    NSString *zip_code = [txtZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(zip_code.length != [@5 longLongValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"You must enter a job title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtZipCode becomeFirstResponder];
    }
    else
    {
        [self Progress_Show:@"Updating"];
        
        /* if fails, reset to this */
        Customer* customer_obj_update = [[Customer alloc]init];
        customer_obj_update = self.customer_controller.customer_obj;
        customer_obj_update.contact_obj = self.customer_controller.contact_obj;
        
        Zip_Code* zip_code_obj = [[Zip_Code alloc]init];
        zip_code_obj.zip_code = zip_code;
        
        Customer_Search_Location_Type* customer_search_location_type_obj = [[Customer_Search_Location_Type alloc]init];
        customer_search_location_type_obj.search_location_type_id = search_location_type_id;
    
        self.customer_controller.customer_obj.deal_range = deal_range;
        self.customer_controller.zip_code_obj = zip_code_obj;
        self.customer_controller.customer_search_location_type_obj = customer_search_location_type_obj;

        [self.customer_controller Update_Customer_Settings:^(void)
         {
             [self.view endEditing:YES];
             
             successful = self.customer_controller.successful;
             system_successful_obj = self.customer_controller.system_successful_obj;
             system_error_obj = self.customer_controller.system_error_obj;
             
             [self Progress_Close];
             
             if(successful)
             {
                 GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Successful" message:system_successful_obj.message cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
                 {
                     if (cancelled)
                     {
                         [self.navigationController popViewControllerAnimated:TRUE];
                     }
                 };
                 
                 [alert show];
             }
             else
             {
                 self.customer_controller.customer_obj = customer_obj_update;
                 self.customer_controller.contact_obj = customer_obj_update.contact_obj;
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }
}

-(void)Back_Click
{
    if(![self.customer_controller.customer_obj.deal_range isEqual:[NSNumber numberWithInt:sldDistance.value]])
    {
        self.edited = YES;
    }
    else if(![self.customer_controller.customer_obj.zip_code_obj.zip_code isEqualToString:txtZipCode.text])
    {
        self.edited = YES;
    }
    else if(![self.customer_controller.customer_obj.customer_search_location_type_obj.search_location_type_id isEqual:search_location_type_id])
    {
        self.edited = YES;
    }
    else
    {
        self.edited = NO;
    }
    
    if(self.edited)
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Cancel" message:@"You have unsaved changes, are you sure you want to cancel?" cancelButtonTitle:@"NO" otherButtonTitles:@[@"Yes"]];
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (!cancelled)
            {
                [self.view endEditing:YES];
                [self.navigationController popViewControllerAnimated:TRUE];
            }
        };
        
        [alert show];
    }
    else
    {
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}


- (void)keyboardWillHide:(NSNotification *)n
{
    //NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    //CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the scrollview
    CGRect viewFrame = scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    //    viewFrame.size.height += (keyboardSize.height - 50);
    viewFrame.size.height = self.screen_height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    //viewFrame.size.height -= (keyboardSize.height - 20);
    viewFrame.size.height = (keyboardSize.height - 20);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}


@end
