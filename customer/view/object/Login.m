#import "Login.h"
#import "Forgot_Password.h"


@interface Login ()
{
    GTTextField *txtFacebookZipCode;
    GTTextField *txtEmail;
    GTTextField *txtPassword;
    UIButton *btnForgotPassword;
    ACPButton *btnLogIn;
    ACPButton *btnFacebookLogin;
    
    FBSDKLoginManager *facebook_login_manager;
    Forgot_Password *vc_forgot_password;
}

@end


@implementation Login

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.screen_title = @"LOGIN";
    self.left_button = @"back";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self Create_Layout];
    
    if([self debug])
        [self Debug];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    facebook_login_manager = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* public methods */
-(void)Create_Layout
{
    CGRect prev_frame;
    
    GTLabel *lblFacebookLabel = [Coding Create_Label:@"Quickly log in with:" width:self.screen_indent_width font:label_font mult:NO];
    [Coding Add_View:contentView view:lblFacebookLabel x:self.screen_indent_x height:[Utilities Get_Height:lblFacebookLabel] prev_frame:CGRectNull gap:(self.gap * 3)];
    
    if([self.customer_controller.contact_gps_log_obj.latitude isEqual:@0])
    {
        txtFacebookZipCode = [Coding Create_Text_Field:@"Zip Code" format_type:@"zipcode" characters:nil width:self.screen_indent_width height:self.text_field_height font:text_field_font];
        [Coding Add_View:contentView view:txtFacebookZipCode x:self.screen_indent_x height:txtFacebookZipCode.frame.size.height prev_frame:lblFacebookLabel.frame gap:(self.gap)];
        prev_frame = txtFacebookZipCode.frame;
    }
    else
    {
        prev_frame = lblFacebookLabel.frame;
    }
    
    btnFacebookLogin = [Coding Create_Button:@"Facebook" font:button_font style:ACPButtonFacebookBlue text_color:[UIColor whiteColor] width:self.screen_indent_width height:self.button_height];
    [btnFacebookLogin addTarget:self action:@selector(btnFacebookLogin_Click) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnFacebookLogin x:self.screen_indent_x height:btnFacebookLogin.frame.size.height prev_frame:prev_frame gap:(self.gap * 2)];
    
    GTLabel *lblLoginLabel = [Coding Create_Label:@"Or use your email:" width:self.screen_indent_width font:label_font mult:NO];
    [Coding Add_View:contentView view:lblLoginLabel x:self.screen_indent_x height:[Utilities Get_Height:lblLoginLabel] prev_frame:btnFacebookLogin.frame gap:(self.gap * 10)];
    
    txtEmail = [Coding Create_Text_Field:@"Email" format_type:@"email" characters:@200 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [txtEmail addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
    [Coding Add_View:contentView view:txtEmail x:self.screen_indent_x height:txtEmail.frame.size.height prev_frame:lblLoginLabel.frame gap:(self.gap * 2)];
    
    txtPassword = [Coding Create_Text_Field:@"Password" format_type:@"password" characters:@200 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    txtPassword.secure_entry = YES;
    [txtPassword addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
    [Coding Add_View:contentView view:txtPassword x:self.screen_indent_x height:txtPassword.frame.size.height prev_frame:txtEmail.frame gap:self.gap];
    
    btnLogIn = [Coding Create_Button:@"Log In" font:button_font style:ACPButtonDarkGrey text_color:[UIColor whiteColor] width:self.screen_indent_width height:self.button_height];
    [btnLogIn addTarget:self action:@selector(btnLogIn_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnLogIn x:self.screen_indent_x height:btnLogIn.frame.size.height prev_frame:txtPassword.frame gap:(self.gap * 2)];
    
    btnForgotPassword = [Coding Create_Link_Button:@"I forgot my password" font:link_button_font];
    [btnForgotPassword addTarget:self action:@selector(btnForgotPassword_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnForgotPassword x:self.screen_indent_x height:btnForgotPassword.frame.size.height prev_frame:btnLogIn.frame gap:(self.gap * 3)];
    
    [self Add_View:self.screen_width height:[self Get_Scroll_Height:btnForgotPassword.frame scroll_lag:0] background_color:[UIColor clearColor]];
}

- (void)btnLogIn_Click:(id)sender
{
    NSString *user_name = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([user_name isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Need Email" message:@"Please enter an email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([password isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Need Password" message:@"Please enter a password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self.view endEditing:YES];
        
        Contact *contact_obj = [[Contact alloc]init];
        contact_obj.user_name = user_name;
        contact_obj.password = password;
        
        self.customer_controller.login_log_obj.auto_login = [NSNumber numberWithBool:NO];
        self.customer_controller.contact_obj = contact_obj;
        
        btnLogIn.enabled = NO;
        btnForgotPassword.enabled = NO;
        [self Progress_Show:@"Logging In"];
        
        [self.customer_controller Login:^(void)
         {
             successful = self.customer_controller.successful;
             system_successful_obj = self.customer_controller.system_successful_obj;
             system_error_obj = self.customer_controller.system_error_obj;
             
             [self Progress_Close];
             btnLogIn.enabled = YES;
             btnForgotPassword.enabled = YES;
             
             if(successful)
             {
                 if(self.customer_controller.customer_obj.customer_id != nil)
                 {
                     [Utilities Clear_NSDefaults];
                     
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                     [defaults setObject:user_name forKey:@"user_name"];
                     [defaults setObject:password forKey:@"password"];
                     [defaults synchronize];
//
//                     [SSKeychain setPassword:user_name forService:@"user_name" account:@"app"];
//                     [SSKeychain setPassword:password forService:@"password" account:@"app"];
                     
                     self.deal_controller.login_log_obj.customer_id = self.customer_controller.customer_obj.customer_id;
                     self.customer_controller.login_log_obj.customer_id = self.customer_controller.customer_obj.customer_id;
                     self.system_controller.login_log_obj.customer_id = self.customer_controller.customer_obj.customer_id;
                     
                     TabBar_Controller *tc = [[TabBar_Controller alloc] init];
                     tc.deal_controller = self.deal_controller;
                     tc.customer_controller = self.customer_controller;
                     tc.system_controller = self.system_controller;
                     [tc Set_Properties];
                     
                     [self presentViewController:tc animated:YES completion:nil];
                 }
             }
             else
             {
                 GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
                 {
                     if (cancelled)
                     {
                         [txtEmail becomeFirstResponder];
                     }
                 };
                 
                 [alert show];
             }
         }];
    }
}

-(void)btnFacebookLogin_Click
{
    NSString* zip_code;
    
    if(txtFacebookZipCode == nil)
        zip_code = @"";
    else
        zip_code = [txtFacebookZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([self.customer_controller.contact_gps_log_obj.latitude isEqual:@0] && zip_code.length < [@5 longLongValue])
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Zip Code" message:@"Your zip code is incorrect" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (cancelled)
            {
                [txtFacebookZipCode becomeFirstResponder];
            }
        };
        
        [alert show];
    }
    else
    {
        Zip_Code* zip_code_obj = [[Zip_Code alloc]init];
        zip_code_obj.zip_code = zip_code;
        
        facebook_login_manager = [[FBSDKLoginManager alloc] init];
        [facebook_login_manager logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"] fromViewController:self
                                                 handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Process error");
             }
             else if (result.isCancelled)
             {
                 NSLog(@"Cancelled");
             }
             else
             {
                 btnLogIn.enabled = NO;
                 [self Progress_Show:@"Logging In"];
                 
                 NSString *auth_token = [FBSDKAccessToken currentAccessToken].tokenString;
                 
                 self.customer_controller.zip_code_obj = zip_code_obj;
                 self.customer_controller.login_log_obj.auth_token = auth_token;
                 [self.customer_controller Login_With_Facebook:^(void)
                  {
                      successful = self.customer_controller.successful;
                      system_successful_obj = self.customer_controller.system_successful_obj;
                      system_error_obj = self.customer_controller.system_error_obj;
                      
                      [self Progress_Close];
                      btnLogIn.enabled = YES;
                      
                      if(successful)
                      {
                          if(self.customer_controller.customer_obj.customer_id != nil)
                          {
                              [Utilities Clear_NSDefaults];
                              
                              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                              [defaults setObject:auth_token forKey:@"auth_token"];
                              [defaults synchronize];
                              
                              //                         [SSKeychain setPassword:user_name forService:@"user_name" account:@"app"];
                              //                         [SSKeychain setPassword:password forService:@"password" account:@"app"];
                              
                              self.deal_controller.login_log_obj.customer_id = self.customer_controller.customer_obj.customer_id;
                              self.customer_controller.login_log_obj.customer_id = self.customer_controller.customer_obj.customer_id;
                              self.system_controller.login_log_obj.customer_id = self.customer_controller.customer_obj.customer_id;
                              
                              TabBar_Controller *tc = [[TabBar_Controller alloc] init];
                              tc.deal_controller = self.deal_controller;
                              tc.customer_controller = self.customer_controller;
                              tc.system_controller = self.system_controller;
                              [tc Set_Properties];
                              
                              [self presentViewController:tc animated:YES completion:nil];
                          }
                      }
                      else
                      {
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                          [alert show];
                      }
                  }];
                 
                 NSLog( @"%@", auth_token);
                 NSLog(@"Logged in");
             }
         }];
    }
}

- (void)btnForgotPassword_Click:(id)sender
{
    vc_forgot_password = [[Forgot_Password alloc]init];
    vc_forgot_password.customer_controller = self.customer_controller;
    [self.navigationController pushViewController:vc_forgot_password animated:YES];
}

-(void)Flag_Screen_Up:(id)sender
{
    self.screen_up_y = 160;

    GTTextField* txt = (GTTextField*)sender;
    if([txt.placeholder isEqualToString:@"Email"])
        self.move_keyboard_up = YES;
    else if([txt.placeholder isEqualToString:@"Password"])
        self.move_keyboard_up = YES;
    else
        self.move_keyboard_up = NO;
}

-(void)Back_Click
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) Debug
{
    txtEmail.text = @"gtriarhos@yahoo.com";
    //txtEmail.text = @"george.triarhos@lexisnexis.com";
    txtPassword.text = @"test12";
}

@end
