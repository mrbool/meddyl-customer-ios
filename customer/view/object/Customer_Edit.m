#import "Customer_Edit.h"


@interface Customer_Edit ()
{
    GTTextField* txtFirstName;
    GTTextField* txtLastName;
    GTTextField* txtEmail;
    GTTextField* txtZipCode;
}
@end


@implementation Customer_Edit

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screen_title = @"PROFILE";
    self.left_button = @"back";
    self.right_button = @"save";
    
    [self Set_Controller_Properties];
    
    [self Create_Layout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self Load_Data];
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
-(void) Create_Layout
{
    txtFirstName = [Coding Create_Text_Field:@"First Name" format_type:@"name" characters:@100 width:self.screen_indent_width_half height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtFirstName x:self.screen_indent_x height:txtFirstName.frame.size.height prev_frame:CGRectNull gap:(self.gap * 5)];
    
    txtLastName = [Coding Create_Text_Field:@"Last Name" format_type:@"name" characters:@100 width:self.screen_indent_width_half height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtLastName x:self.screen_indent_x_right height:txtLastName.frame.size.height prev_frame:CGRectNull gap:(self.gap * 5)];
    
    txtEmail = [Coding Create_Text_Field:@"Email" format_type:@"email" characters:@200 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtEmail x:self.screen_indent_x height:txtEmail.frame.size.height prev_frame:txtFirstName.frame gap:(self.gap * 5)];
    
    txtZipCode = [Coding Create_Text_Field:@"Zip Code" format_type:@"" characters:@100 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtZipCode x:self.screen_indent_x height:txtZipCode.frame.size.height prev_frame:txtEmail.frame gap:self.gap];
    
    [self Add_View:self.screen_width height:[self Get_Scroll_Height:txtZipCode.frame scroll_lag:0] background_color:[UIColor clearColor]];
}

-(void)Load_Data
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
             txtFirstName.text = self.customer_controller.customer_obj.contact_obj.first_name;
             txtLastName.text = self.customer_controller.customer_obj.contact_obj.last_name;
             txtEmail.text = self.customer_controller.customer_obj.contact_obj.email;
             txtZipCode.text = self.customer_controller.customer_obj.contact_obj.zip_code_obj.zip_code;
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
     }];
}

-(void)Save_Click
{
    NSString *first_name = [txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *last_name = [txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *zip_code = [txtZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(first_name.length == [@0 longLongValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"First Name" message:@"You must enter your first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtFirstName becomeFirstResponder];
    }
    else if(last_name.length == [@0 longLongValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Last Name" message:@"You must enter your last name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtLastName becomeFirstResponder];
    }
    else if(![Utilities IsValidEmail:email])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"You must a valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtEmail becomeFirstResponder];
    }
    else if(zip_code.length != [@5 longLongValue])
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
        
        Contact *contact_obj = [[Contact alloc] init];
        contact_obj.first_name = first_name;
        contact_obj.last_name = last_name;
        contact_obj.email = email;
        contact_obj.zip_code_obj = zip_code_obj;
        
        self.customer_controller.contact_obj = contact_obj;
        [self.customer_controller Update_Customer:^(void)
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
    if(![self.customer_controller.customer_obj.contact_obj.first_name isEqualToString:txtFirstName.text])
    {
        self.edited = YES;
    }
    else if(![self.customer_controller.customer_obj.contact_obj.last_name isEqualToString:txtLastName.text])
    {
        self.edited = YES;
    }
    else if(![self.customer_controller.customer_obj.contact_obj.email isEqualToString:txtEmail.text])
    {
        self.edited = YES;
    }
    else if(![self.customer_controller.customer_obj.contact_obj.zip_code_obj.zip_code isEqualToString:txtZipCode.text])
    {
        self.edited = YES;
    }
    else
    {
        self.edited = NO;
    }
    
    if(self.edited)
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Cancel" message:@"You have unsaved changes, are you sure you want to cancel?" cancelButtonTitle:@"Yes" otherButtonTitles:@[@"No"]];
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (cancelled)
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

-(void)Debug
{
    
}


@end
