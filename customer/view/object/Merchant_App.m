#import "Merchant_App.h"


@interface Merchant_App ()

@end


@implementation Merchant_App

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screen_title = @"BECOME A MERCHANT";
    self.left_button = @"back";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
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
    [self.system_controller Get_System_Settings:^(void)
    {
        successful = self.system_controller.successful;
        system_successful_obj = self.system_controller.system_successful_obj;
        system_error_obj = self.system_controller.system_error_obj;

        if(successful)
        {
            GTLabel *lblGetApp1 = [Coding Create_Label:@"Get the Merchant App!" width:self.screen_indent_width font:label_font_medium mult:NO];
            [lblGetApp1 setTextAlignment:NSTextAlignmentCenter];
            [Coding Add_View:contentView view:lblGetApp1 x:self.screen_indent_x height:[Utilities Get_Height:lblGetApp1] prev_frame:CGRectNull gap:(self.gap * 10)];
            
            GTLabel *lblGetApp2 = [Coding Create_Label:@"You must be a valid business in your area.  Simply click the install button below and plac your deal." width:self.screen_indent_width font:label_font mult:YES];
            [lblGetApp2 setTextAlignment:NSTextAlignmentCenter];
            [Coding Add_View:contentView view:lblGetApp2 x:self.screen_indent_x height:[Utilities Get_Height:lblGetApp2] prev_frame:lblGetApp1.frame gap:(self.gap * 2)];
            
            CGFloat button_width = (self.screen_width * .5);
            CGFloat button_x = (self.screen_width - button_width)/2;
            ACPButton* btnGetApp = [Coding Create_Button:@"Install" font:button_font style:ACPButtonBlue text_color:[UIColor whiteColor] width:button_width height:self.button_height];
            [btnGetApp addTarget:self action:@selector(btnGetApp_Click:) forControlEvents:UIControlEventTouchUpInside];
            [Coding Add_View:contentView view:btnGetApp x:button_x height:btnGetApp.frame.size.height prev_frame:lblGetApp2.frame gap:(self.gap * 7)];
            
            [self Add_View:self.screen_width height:[self Get_Scroll_Height:btnGetApp.frame scroll_lag:0] background_color:[UIColor whiteColor]];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)btnGetApp_Click:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"itms-apps://itunes.apple.com/app/", self.system_controller.system_settings_obj.merchant_app_ios_id]]];
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
