#import "Register.h"


@interface Register ()
{
    ACPButton *btnFacebookLogin;
    GTTextField *txtFacebookZipCode;
    GTTextField *txtFirstName;
    GTTextField *txtLastName;
    GTTextField *txtEmail;
    GTTextField *txtPassword;
    GTTextField *txtZipCode;
    ACPButton *btnRegister;
    
    FBSDKLoginManager *facebook_login_manager;
}
@end


@implementation Register

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.screen_title = @"REGISTER";
    self.left_button = @"back";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
    
    [self Create_Layout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if([self debug])
        [self Debug];
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

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url

{
    Terms_Of_Service *vc_terms_of_service = [[Terms_Of_Service alloc]init];
    vc_terms_of_service.system_controller = self.system_controller;
    vc_terms_of_service.customer_controller = self.customer_controller;
    vc_terms_of_service.deal_controller = self.deal_controller;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:vc_terms_of_service animated:YES];
}

- (void)attributedLabel:(__unused TTTAttributedLabel *)label didLongPressLinkWithURL:(__unused NSURL *)url atPoint:(__unused CGPoint)point {
    [[[UIAlertView alloc] initWithTitle:@"URL Long Pressed"
                                message:@"You long-pressed a URL. Well done!"
                               delegate:nil
                      cancelButtonTitle:@"Woohoo!"
                      otherButtonTitles:nil] show];
}


/* public methods */
-(void)Create_Layout
{
    CGRect prev_frame;
    
    GTLabel *lblFacebookLabel = [Coding Create_Label:@"Quickly log in with:" width:self.screen_indent_width font:label_font mult:NO];
    [Coding Add_View:contentView view:lblFacebookLabel x:self.screen_indent_x height:[Utilities Get_Height:lblFacebookLabel] prev_frame:CGRectNull gap:(self.gap * 3)];
    
    if([self.customer_controller.contact_gps_log_obj.latitude isEqual:@0])
    {
        txtFacebookZipCode = [Coding Create_Text_Field:@"Zip Code " format_type:@"zipcode" characters:nil width:self.screen_indent_width height:self.text_field_height font:text_field_font];
        [txtFacebookZipCode addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
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
    
    txtFirstName = [Coding Create_Text_Field:@"First Name" format_type:@"name" characters:@100 width:self.screen_indent_width_half height:self.text_field_height font:text_field_font];
    [txtFirstName addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
   [Coding Add_View:contentView view:txtFirstName x:self.screen_indent_x height:txtFirstName.frame.size.height prev_frame:lblLoginLabel.frame gap:(self.gap * 2)];
    
    txtLastName = [Coding Create_Text_Field:@"Last Name" format_type:@"name" characters:@100 width:self.screen_indent_width_half height:self.text_field_height font:text_field_font];
    [txtLastName addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
    [Coding Add_View:contentView view:txtLastName x:self.screen_indent_x_right height:txtLastName.frame.size.height prev_frame:lblLoginLabel.frame gap:(self.gap * 2)];
    
    txtEmail = [Coding Create_Text_Field:@"Email" format_type:@"email" characters:@200 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [txtEmail addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
    txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [Coding Add_View:contentView view:txtEmail x:self.screen_indent_x height:txtEmail.frame.size.height prev_frame:txtLastName.frame gap:(self.gap)];
    
    txtPassword = [Coding Create_Text_Field:@"Password" format_type:@"password" characters:@50 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    txtPassword.secure_entry = YES;
    [txtPassword addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
    [Coding Add_View:contentView view:txtPassword x:self.screen_indent_x height:txtPassword.frame.size.height prev_frame:txtEmail.frame gap:(self.gap)];
    
    if([self.customer_controller.contact_gps_log_obj.latitude isEqual:@0])
    {
        txtZipCode = [Coding Create_Text_Field:@"Zip Code" format_type:@"zipcode" characters:nil width:self.screen_indent_width height:self.text_field_height font:text_field_font];
        [txtZipCode addTarget:self action:@selector(Flag_Screen_Up:) forControlEvents:UIControlEventEditingDidBegin];
        [Coding Add_View:contentView view:txtZipCode x:self.screen_indent_x height:txtZipCode.frame.size.height prev_frame:txtPassword.frame gap:(self.gap)];
        prev_frame = txtZipCode.frame;
    }
    else
    {
        prev_frame = txtPassword.frame;
    }
    
    btnRegister = [Coding Create_Button:@"Register" font:button_font style:ACPButtonDarkGrey text_color:[UIColor whiteColor] width:self.screen_indent_width height:self.button_height];
    [btnRegister addTarget:self action:@selector(btnRegister_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnRegister x:self.screen_indent_x height:btnRegister.frame.size.height prev_frame:prev_frame gap:(self.gap * 2)];

    /* terms of service */
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor darkGrayColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
    label.delegate = self; // Delegate methods are called when the user taps on a link (see `TTTAttributedLabelDelegate` protocol)
    label.text = @"By signing up, I agree to Meddyl's Terms of Service"; // Repository URL will be automatically detected and linked
    NSRange range = [label.text rangeOfString:@"Terms of Service"];
    [label addLinkToURL:[NSURL URLWithString:@"http://github.com/mattt/"] withRange:range]; // Embedding a custom link in a substring
    [Coding Add_View:contentView view:label x:self.screen_indent_x height:label.frame.size.height prev_frame:btnRegister.frame gap:(self.gap * 4)];
    
    [self Add_View:self.screen_width height:[self Get_Scroll_Height:label.frame scroll_lag:0] background_color:[UIColor clearColor]];
}

- (void)btnRegister_Click:(id)sender
{
    NSString *first_name = [txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *last_name = [txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *email = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* zip_code;
    
    if(txtZipCode == nil)
        zip_code = @"";
    else
        zip_code = [txtZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(first_name.length == [@0 longLongValue])
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Need First Name" message:@"You must enter your first" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (cancelled)
            {
                [txtFirstName becomeFirstResponder];
            }
        };
        
        [alert show];
    }
    else if(last_name.length == [@0 longLongValue])
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Need Last Name" message:@"You must enter your last name" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (cancelled)
            {
                [txtLastName becomeFirstResponder];
            }
        };
        
        [alert show];
    }
    else if(![Utilities IsValidEmail:email])
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Need Email" message:@"You must a valid email address" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (cancelled)
            {
                [txtEmail becomeFirstResponder];
            }
        };
        
        [alert show];
    }
    else if(password.length < [@5 longLongValue])
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Password Incorrect" message:@"Your password must be at least 5 characters" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (cancelled)
            {
                [txtPassword becomeFirstResponder];
            }
        };
        
        [alert show];
    }
    else if([self.customer_controller.contact_gps_log_obj.latitude isEqual:@0] && zip_code.length < [@5 longLongValue])
    {
        GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Zip Code" message:@"Your zip code is incorrect" cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
        {
            if (cancelled)
            {
                [txtZipCode becomeFirstResponder];
            }
        };
        
        [alert show];
    }
    else
    {
        btnRegister.enabled = NO;
        [self Progress_Show:@"Registering"];

        Zip_Code* zip_code_obj = [[Zip_Code alloc]init];
        zip_code_obj.zip_code = zip_code;
        
        Contact* contact_obj = [[Contact alloc]init];
        contact_obj.first_name = txtFirstName.text;
        contact_obj.last_name = txtLastName.text;
        contact_obj.email = txtEmail.text;
        contact_obj.password = txtPassword.text;
        
        self.customer_controller.zip_code_obj = zip_code_obj;
        self.customer_controller.contact_obj = contact_obj;
        [self.customer_controller Register:^(void)
         {
             successful = self.customer_controller.successful;
             system_successful_obj = self.customer_controller.system_successful_obj;
             system_error_obj = self.customer_controller.system_error_obj;
             
             [self Progress_Close];
             btnRegister.enabled = YES;
             
             if(successful)
             {
                 [Utilities Clear_NSDefaults];
                 
                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                 [defaults setObject:email forKey:@"user_name"];
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
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
                 btnRegister.enabled = NO;
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
                      btnRegister.enabled = YES;
                      
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

-(void)Flag_Screen_Up:(id)sender
{
    self.screen_up_y = 160;
    
    GTTextField* txt = (GTTextField*)sender;
    if([txt.placeholder isEqualToString:@"First Name"])
        self.move_keyboard_up = YES;
    else if([txt.placeholder isEqualToString:@"Last Name"])
        self.move_keyboard_up = YES;
    else if([txt.placeholder isEqualToString:@"Email"])
        self.move_keyboard_up = YES;
    else if([txt.placeholder isEqualToString:@"Password"])
        self.move_keyboard_up = YES;
    else if([txt.placeholder isEqualToString:@"Zip Code"])
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
    txtPassword.text = @"test12";
    txtFirstName.text = @"George";
    txtLastName.text = @"Triarhos";
    txtZipCode.text = @"92037";
    txtEmail.text = @"gtriarhos@yahoo.com";
}





@end
