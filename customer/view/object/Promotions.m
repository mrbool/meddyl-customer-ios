#import "Promotions.h"


@interface Promotions ()

@end


@implementation Promotions

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.screen_title = @"PROMOTIONS";
    self.left_button = @"";
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

/* message delegate */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/* public methods */
-(void)Create_Layout
{
    [self Progress_Show:@"Loading"];
    
    [[contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.customer_controller Get_Valid_Promotions:^(void)
     {
         successful = self.customer_controller.successful;
         system_successful_obj = self.customer_controller.system_successful_obj;
         system_error_obj = self.customer_controller.system_error_obj;
         
         [self Progress_Close];
         
         if(successful)
         {
             NSInteger active_promotions = [self.customer_controller.promotion_activity_obj_array count];

             /* add deal image */
             GTLabel *lblPromo = [Coding Create_Label:[NSString stringWithFormat:@"%@%ld%@", @"You have ", (long)active_promotions, @" promotions"] width:self.screen_indent_width font:label_font_medium mult:NO];
             [lblPromo setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblPromo x:self.screen_indent_x height:[Utilities Get_Height:lblPromo] prev_frame:CGRectNull gap:(self.gap * 10)];
    
             NSString* use_promotions;
             if(active_promotions == 0)
                 use_promotions = @"Refer a friend and get free deals";
             else
                 use_promotions = @"Just find the deal you want and it will automatically be free during checkout";
             
             GTLabel *lblPromoDesc = [Coding Create_Label:use_promotions width:self.screen_indent_width font:label_font mult:YES];
             [lblPromoDesc setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblPromoDesc x:self.screen_indent_x height:[Utilities Get_Height:lblPromoDesc] prev_frame:lblPromo.frame gap:(self.gap * 2)];
    
             UIView *vwLine0 = [Coding Create_Straight_Line:self.screen_width];
             [Coding Add_View:contentView view:vwLine0 x:vwLine0.frame.origin.x height:1 prev_frame:lblPromoDesc.frame gap:(self.gap * 10)];
             
             GTLabel *lblDeal = [Coding Create_Label:@"Refer your friends with your promo code and if they use it, you get free deals" width:self.screen_indent_width font:label_font_medium mult:YES];
             [lblDeal setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblDeal x:self.screen_indent_x height:[Utilities Get_Height:lblDeal] prev_frame:vwLine0.frame gap:(self.gap * 10)];
    
             CGFloat button_width = (self.screen_width * .5);
             CGFloat button_x = (self.screen_width - button_width)/2;
             ACPButton* btnReferral = [Coding Create_Button:@"Refer Friends" font:button_font style:ACPButtonPink text_color:[UIColor darkGrayColor] width:button_width height:self.button_height];
             [btnReferral addTarget:self action:@selector(btnReferral_Click:) forControlEvents:UIControlEventTouchUpInside];
             [Coding Add_View:contentView view:btnReferral x:button_x height:btnReferral.frame.size.height prev_frame:lblDeal.frame gap:(self.gap * 5)];
    
             
             GTLabel *lblPromoCode = [Coding Create_Label:[NSString stringWithFormat:@"%@%@", @"Your promo code is ", self.customer_controller.customer_obj.promotion_obj.promotion_code] width:self.screen_indent_width font:label_font mult:YES];
             [lblPromoCode setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblPromoCode x:self.screen_indent_x height:[Utilities Get_Height:lblPromoCode] prev_frame:btnReferral.frame gap:(self.gap * 5)];
             

             [self Add_View:self.screen_width height:[self Get_Scroll_Height:lblDeal.frame scroll_lag:0] background_color:[UIColor whiteColor]];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
     }];
}

- (void)btnReferral_Click:(id)sender
{
    if(![MFMessageComposeViewController canSendText])
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = nil; //@[@"12345678", @"72345524"];
    NSString *message = self.customer_controller.customer_obj.promotion_obj.link;
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
