#import "Main_View.h"


@interface Main_View ()
{
    UIImageView* imvMain;
    ACPButton *btnLogIn;
    ACPButton *btnRegister;
    
    Contact_GPS_Log* contact_gps_log_obj;
    NSString* next_screen;
}

@property (assign, nonatomic) INTULocationRequestID locationRequestID;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) NSString *status_text;

@end


@implementation Main_View

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self Create_Layout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self Progress_Show:@"Loading"];
    
    contact_gps_log_obj = [[Contact_GPS_Log alloc]init];
    self.customer_controller.contact_gps_log_obj = contact_gps_log_obj;
    contact_gps_log_obj.latitude = @0;
    contact_gps_log_obj.longitude = @0;

    [self Load_System_Settings];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)statusFrameChanged:(NSNotification*)note
{
    CGRect status_frame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    CGFloat status_bar_height = status_frame.size.height;
    
    CGFloat button_width = (self.screen_width/2) - (self.screen_indent_x * 1.5);
    CGFloat button_height = self.screen_height/11;
    CGFloat button_y = self.screen_height - self.screen_indent_x - btnLogIn.frame.size.height;
    
    if(status_bar_height != 20)
        button_y = button_y - 30;
    
    btnLogIn.frame = CGRectMake(self.screen_indent_x, button_y, button_width, button_height);
    
    CGFloat button_x = (self.screen_width/2) + (self.screen_indent_x * .5);
    btnRegister.frame = CGRectMake(button_x, button_y, button_width, button_height);
}

- (NSString *)getErrorDescription:(INTULocationStatus)status
{
    if (status == INTULocationStatusServicesNotDetermined) {
        return @"Error: User has not responded to the permissions alert.";
    }
    if (status == INTULocationStatusServicesDenied) {
        return @"Error: User has denied this app permissions to access device location.";
    }
    if (status == INTULocationStatusServicesRestricted) {
        return @"Error: User is restricted from using location services by a usage policy.";
    }
    if (status == INTULocationStatusServicesDisabled) {
        return @"Error: Location services are turned off for all apps on this device.";
    }
    return @"An unknown error occurred.\n(Are you using iOS Simulator with location set to 'None'?)";
}


/* public methods */
-(void) Create_Layout
{
    UIImage *image = [UIImage imageNamed:@"wine.png"];
    
    imvMain = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height)];
    imvMain.clipsToBounds = YES;
    imvMain.image = image;
    [Coding Add_View:self.view view:imvMain x:0 height:imvMain.frame.size.height prev_frame:CGRectNull gap:0];
    
    CGFloat image_width = (self.screen_width * .85);
    CGFloat image_height = 165 * (image_width/630);
    CGFloat image_x = (self.screen_width - image_width)/2;
    UIImageView* imvLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image_width, image_height)];
    imvLogo.image = [UIImage imageNamed:@"logo.png"];
    imvLogo.clipsToBounds = YES;
    [Coding Add_View:self.view view:imvLogo x:image_x height:imvLogo.frame.size.height prev_frame:CGRectNull gap:self.screen_height/3];
    
    btnLogIn = [[ACPButton alloc]init];
    [btnLogIn setStyleType:ACPButtonWhite];
    [btnLogIn setLabelTextColor:[UIColor redColor] highlightedColor:[UIColor redColor] disableColor:nil];
    [btnLogIn addTarget:self action:@selector(btnLogIn_Click:) forControlEvents:UIControlEventTouchUpInside];
    [btnLogIn setTitle:@"Log In" forState:UIControlStateNormal];
    [btnLogIn setLabelFont:button_font];
    CGFloat button_width = (self.screen_width/2) - (self.screen_indent_x * 1.5);
    CGFloat button_height = self.screen_height/11;
    btnLogIn.frame = CGRectMake(0, 0, button_width, button_height);
    CGFloat button_y = self.screen_height - self.screen_indent_x - btnLogIn.frame.size.height;
    [Coding Add_View:self.view view:btnLogIn x:self.screen_indent_x height:btnLogIn.frame.size.height prev_frame:CGRectNull gap:button_y];
    
    btnRegister = [[ACPButton alloc]init];
    [btnRegister setStyleType:ACPButtonBlue];
    [btnRegister setLabelTextColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] disableColor:nil];
    [btnRegister addTarget:self action:@selector(btnRegister_Click:) forControlEvents:UIControlEventTouchUpInside];
    [btnRegister setTitle:@"Register" forState:UIControlStateNormal];
    [btnRegister setLabelFont:button_font];
    btnRegister.frame = CGRectMake(0, 0, button_width, button_height);
    CGFloat button_x = (self.screen_width/2) + (self.screen_indent_x * .5);
    [Coding Add_View:self.view view:btnRegister x:button_x height:btnRegister.frame.size.height prev_frame:CGRectNull gap:button_y];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)Load_System_Settings
{
    [self.system_controller Get_System_Settings:^(void)
     {
         successful = self.system_controller.successful;
         system_successful_obj = self.system_controller.system_successful_obj;
         system_error_obj = self.system_controller.system_error_obj;

         if(successful)
         {
             
             [self Auto_Login];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
     }];
}

-(void)Auto_Login
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user_name = [defaults objectForKey:@"user_name"];
    NSString *password = [defaults objectForKey:@"password"];
    NSString *auth_token = [defaults objectForKey:@"auth_token"];
    
    //    NSString *user_name = [SSKeychain passwordForService:@"user_name" account:@"app"];
    //    NSString *password = [SSKeychain passwordForService:@"password" account:@"app"];
    
    if(user_name != nil)
    {
        Contact *contact_obj = [[Contact alloc]init];
        contact_obj.user_name = user_name;
        contact_obj.password = password;
        
        self.customer_controller.login_log_obj.auto_login = [NSNumber numberWithBool:YES];
        self.customer_controller.contact_obj = contact_obj;
        [self.customer_controller Login:^(void)
         {
             [self Progress_Close];
             
             if(self.customer_controller.successful)
             {
                 if(self.customer_controller.customer_obj.customer_id != nil)
                 {
                     next_screen = @"auto";
                     
                     [self Get_Location];
                 }
             }
             else
             {
                 [Utilities Clear_NSDefaults];
                 
                 //    [SSKeychain deletePasswordForService:@"user_name" account:@"app"];
                 //    [SSKeychain deletePasswordForService:@"password" account:@"app"];
             }
         }];
    }
    else if(auth_token != nil)
    {
        self.customer_controller.login_log_obj.auth_token = auth_token;
        [self.customer_controller Login_With_Facebook:^(void)
         {
             successful = self.customer_controller.successful;
             system_successful_obj = self.customer_controller.system_successful_obj;
             system_error_obj = self.customer_controller.system_error_obj;
             
             [self Progress_Close];
             
             if(successful)
             {
                 if(self.customer_controller.customer_obj.customer_id != nil)
                 {
                     next_screen = @"auto";
                     
                     [self Get_Location];
                 }
             }
             else
             {
                 [Utilities Clear_NSDefaults];
                 
                 //    [SSKeychain deletePasswordForService:@"user_name" account:@"app"];
                 //    [SSKeychain deletePasswordForService:@"password" account:@"app"];
             }
         }];
    }
    else
    {
        [self Progress_Close];
    }
}

-(void)Get_Location
{
    __weak __typeof(self) weakSelf = self;
    
    INTULocationAccuracy desiredAccuracy = INTULocationAccuracyCity;
    if([self.system_controller.system_settings_obj.gps_accuracy isEqualToString:@"room"])
    {
        desiredAccuracy = INTULocationAccuracyRoom;
    }
    else if([self.system_controller.system_settings_obj.gps_accuracy isEqualToString:@"house"])
    {
        desiredAccuracy = INTULocationAccuracyHouse;
    }
    else if([self.system_controller.system_settings_obj.gps_accuracy isEqualToString:@"block"])
    {
        desiredAccuracy = INTULocationAccuracyBlock;
    }
    else if([self.system_controller.system_settings_obj.gps_accuracy isEqualToString:@"neighborhood"])
    {
        desiredAccuracy = INTULocationAccuracyNeighborhood;
    }
    else if([self.system_controller.system_settings_obj.gps_accuracy isEqualToString:@"city"])
    {
        desiredAccuracy = INTULocationAccuracyCity;
    }
    desiredAccuracy = INTULocationAccuracyCity;

    NSTimeInterval timeout = [self.system_controller.system_settings_obj.gps_timeout doubleValue];
    
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    self.locationRequestID = [locMgr requestLocationWithDesiredAccuracy:desiredAccuracy
                                                                timeout:timeout
                                                   delayUntilAuthorized:YES
                                                                  block:
                              ^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                  __typeof(weakSelf) strongSelf = weakSelf;
                                  
                                  if (status == INTULocationStatusSuccess)
                                  {
                                      // achievedAccuracy is at least the desired accuracy (potentially better)
                                      strongSelf.status_text = [NSString stringWithFormat:@"Location request successful! Current Location:\n%@", currentLocation];
                                      
                                      contact_gps_log_obj.latitude = @(currentLocation.coordinate.latitude);
                                      contact_gps_log_obj.longitude = @(currentLocation.coordinate.longitude);
                                  }
                                  else if (status == INTULocationStatusTimedOut)
                                  {
                                      // You may wish to inspect achievedAccuracy here to see if it is acceptable, if you plan to use currentLocation
                                      strongSelf.status_text = [NSString stringWithFormat:@"Location request timed out. Current Location:\n%@", currentLocation];
                                  }
                                  else
                                  {
                                      // An error occurred
                                      strongSelf.status_text = [strongSelf getErrorDescription:status];
                                  }
                                  strongSelf.locationRequestID = NSNotFound;
                                  
                                  self.customer_controller.contact_gps_log_obj = contact_gps_log_obj;

                                  if([next_screen isEqualToString:@"login"])
                                  {
                                        Login *vc_login=[[Login alloc]init];
                                        vc_login.customer_controller = self.customer_controller;
                                        vc_login.system_controller = self.system_controller;

                                        [self.navigationController setNavigationBarHidden:NO animated:YES];
                                        [self.navigationController pushViewController:vc_login animated:YES];
                                  }
                                  else if([next_screen isEqualToString:@"register"])
                                  {
                                        Register *vc_register=[[Register alloc]init];
                                        vc_register.customer_controller = self.customer_controller;
                                        vc_register.system_controller = self.system_controller;
                                      
                                        [self.navigationController setNavigationBarHidden:NO animated:YES];
                                        [self.navigationController pushViewController:vc_register animated:YES];
                                  }
                                  else if([next_screen isEqualToString:@"auto"])
                                  {
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
                              }];
}

- (void)btnLogIn_Click:(id)sender
{
    next_screen = @"login";
    
    [self Get_Location];
}

- (void)btnRegister_Click:(id)sender
{
    next_screen = @"register";
    
    [self Get_Location];
}


@end
