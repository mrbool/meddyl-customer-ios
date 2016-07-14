#import "Forgot_Password.h"


@interface Forgot_Password ()
{
    ACPButton *btnResetPassword;
    GTTextField *txtEmail;
}
@end


@implementation Forgot_Password

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.screen_title = @"FORGOT PASSWORD";
    self.left_button = @"back";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
    
    [self Create_Layout];
    
    if([self debug])
        [self Debug];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* not sure why need this code, but will lock up nav bar if not here */
    self.navigationController.navigationBar.topItem.leftBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.backBarButtonItem.enabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* public methods */
-(void)Create_Layout
{
    GTLabel *lblHeader = [Coding Create_Label:@"Enter your email address and we'll send you a link to reset your password" width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:self.view view:lblHeader x:self.screen_indent_x height:[Utilities Get_Height:lblHeader] prev_frame:CGRectNull gap:(self.gap * 4)];
    
    txtEmail = [Coding Create_Text_Field:@"Email" format_type:@"email" characters:@200 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [Coding Add_View:self.view view:txtEmail x:self.screen_indent_x height:txtEmail.frame.size.height prev_frame:lblHeader.frame gap:(self.gap * 5)];
    
    btnResetPassword = [Coding Create_Button:@"Reset Password" font:button_font style:ACPButtonDarkGrey text_color:[UIColor whiteColor] width:self.screen_indent_width height:self.button_height];
    [btnResetPassword addTarget:self action:@selector(btnResetPassword_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:self.view view:btnResetPassword x:self.screen_indent_x height:btnResetPassword.frame.size.height prev_frame:txtEmail.frame gap:(self.gap * 5)];
}

- (void)btnResetPassword_Click:(id)sender
{
    NSString *user_name = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([user_name isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Need Email" message:@"Please enter an email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self.view endEditing:YES];
        
        Contact *contact_obj = [[Contact alloc]init];
        contact_obj.user_name = user_name;
        
        self.customer_controller.contact_obj = contact_obj;
        
        btnResetPassword.enabled = NO;
        [self Progress_Show:@"Sending Email"];
        
        [self.customer_controller Forgot_Password:^(void)
         {
             successful = self.customer_controller.successful;
             system_successful_obj = self.customer_controller.system_successful_obj;
             system_error_obj = self.customer_controller.system_error_obj;
             
             [self Progress_Close];
             btnResetPassword.enabled = YES;
             
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
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) Debug
{
    txtEmail.text = @"gtriarhos@yahoo.com";
}

@end
