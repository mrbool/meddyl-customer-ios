#import "Deal_Purchase.h"


@interface Deal_Purchase ()
{
    GTTextField* txtPromotion;
    ACPButton *btnBuy;
    
    Credit_Card* credit_card_obj;
    
    BOOL keyboardIsShown;
}
@end


@implementation Deal_Purchase

@synthesize purchased;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screen_title = @"PURCHASE";
    self.left_button = @"close";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
    
    purchased = false;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    keyboardIsShown = NO;
    
    [self Progress_Show:@"Loading"];
    
    [self Get_Payment];
    
    [self Progress_Close];
    
    /* not sure why need this code, but will lock up nav bar if not here */
    self.navigationController.navigationBar.topItem.leftBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.backBarButtonItem.enabled = YES;
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

- (void)statusFrameChanged:(NSNotification*)note
{
    CGRect status_frame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    CGFloat status_bar_height = status_frame.size.height;
    
    CGFloat button_y;
    if(status_bar_height == 20)
        button_y = 448;
    else
        button_y = 428;
    
    btnBuy.frame = CGRectMake(0, button_y, self.screen_width, self.button_height);
}

-(void)Get_Payment
{
    self.deal_controller.customer_obj = self.customer_controller.customer_obj;
    [self.deal_controller Get_Payment:^(void)
     {
         successful = self.deal_controller.successful;
         system_successful_obj = self.deal_controller.system_successful_obj;
         system_error_obj = self.deal_controller.system_error_obj;
         
         if(successful)
         {
             [self Create_Layout];
         }
     }];
}

-(void)Create_Layout
{
    [[contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

     Deal* deal_obj = self.deal_controller.deal_obj;
     Merchant* merchant_obj = deal_obj.merchant_contact_obj.merchant_obj;
     Certificate_Payment* certificate_payment_obj = self.deal_controller.certificate_payment_obj;
     credit_card_obj = certificate_payment_obj.credit_card_obj;
     Promotion* promotion_obj = certificate_payment_obj.promotion_activity_obj.promotion_obj;
    
     GTLabel *lblOrderSummary = [Coding Create_Label:@"Order Summary" width:self.screen_indent_width font:label_font_medium_medium mult:NO];
     [Coding Add_View:contentView view:lblOrderSummary x:self.screen_indent_x height:[Utilities Get_Height:lblOrderSummary] prev_frame:CGRectNull gap:(self.gap * 7)];
    
     CGFloat logo_image_height = self.screen_height * .11;
     UIImageView *imvLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, logo_image_height, logo_image_height)];
     imvLogo.layer.cornerRadius = 6;
     imvLogo.clipsToBounds = YES;
     imvLogo.layer.borderWidth = 1.0f;
     imvLogo.layer.borderColor = [[UIColor lightGrayColor] CGColor];
     [imvLogo sd_setImageWithURL:[NSURL URLWithString:merchant_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
     [Coding Add_View:contentView view:imvLogo x:self.screen_indent_x height:imvLogo.frame.size.height prev_frame:lblOrderSummary.frame gap:9];
     
     CGFloat company_info_x = imvLogo.frame.origin.x + imvLogo.frame.size.width + (self.gap * 2);
     GTLabel *lblCompanyName = [Coding Create_Label:merchant_obj.company_name width:(self.screen_indent_width - logo_image_height) font:label_font_medium mult:NO];
     [Coding Add_View:contentView view:lblCompanyName x:company_info_x height:lblCompanyName.frame.size.height prev_frame:lblOrderSummary.frame gap:(self.gap * 2)];
    
     GTLabel *lblDeal = [Coding Create_Label:deal_obj.deal width:(self.screen_indent_width - logo_image_height) font:label_font mult:NO];
     [Coding Add_View:contentView view:lblDeal x:company_info_x height:[Utilities Get_Height:lblDeal] prev_frame:lblCompanyName.frame gap:(self.gap * 1)];
    
     UIView *vwLine0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_indent_width, 1)];
     vwLine0.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
     [Coding Add_View:contentView view:vwLine0 x:self.screen_indent_x height:1 prev_frame:lblDeal.frame gap:(self.gap * 6)];

     GTLabel *lblPaymentDetails = [Coding Create_Label:@"Payment Details" width:self.screen_indent_width font:label_font_medium_medium mult:NO];
     [Coding Add_View:contentView view:lblPaymentDetails x:self.screen_indent_x height:[Utilities Get_Height:lblPaymentDetails] prev_frame:vwLine0.frame gap:(self.gap * 6)];
     
     CGRect last_frame;
     
     if(promotion_obj.promotion_id != 0)
     {
         GTLabel *lblPromotion = [Coding Create_Label:[NSString stringWithFormat:@"%@%@", @"Your promotion code is:  ", promotion_obj.promotion_code] width:self.screen_indent_width font:label_font mult:NO];
         [Coding Add_View:contentView view:lblPromotion x:self.screen_indent_x height:[Utilities Get_Height:lblPromotion] prev_frame:lblPaymentDetails.frame gap:(self.gap * 2)];

         last_frame = lblPromotion.frame;
     }
     else
     {
         txtPromotion = [Coding Create_Text_Field:@"Promotion Code" format_type:nil characters:@20 width:(self.screen_indent_width * .6) height:self.text_field_height font:text_field_font];
         [txtPromotion setBackgroundColor:[UIColor whiteColor]];
         [txtPromotion.layer setBorderColor:[UIColor grayColor].CGColor];
         [txtPromotion.layer setBorderWidth:1.0];
         [txtPromotion.layer setCornerRadius:5.0f];
         [Coding Add_View:contentView view:txtPromotion x:self.screen_indent_x height:txtPromotion.frame.size.height prev_frame:lblPaymentDetails.frame gap:(self.gap * 2)];
         
         ACPButton* btnApplyPromo = [Coding Create_Button:@"Apply" font:button_font_small style:ACPButtonRed text_color:[UIColor whiteColor] width:(self.screen_indent_width * .3) height:self.text_field_height];
         [btnApplyPromo addTarget:self action:@selector(btnApplyPromo_Click:) forControlEvents:UIControlEventTouchUpInside];
         [Coding Add_View:contentView view:btnApplyPromo x:(txtPromotion.frame.origin.x + txtPromotion.frame.size.width + (self.gap * 2)) height:btnApplyPromo.frame.size.height prev_frame:lblPaymentDetails.frame gap:(self.gap * 2)];
         
         last_frame = btnApplyPromo.frame;
     }
    
    GTLabel *lblPrice = [Coding Create_Label:[NSString stringWithFormat:@"%@%@", @"Total Price:     ", [Utilities DecimalNumber_To_String:certificate_payment_obj.payment_amount]] width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:contentView view:lblPrice x:self.screen_indent_x height:[Utilities Get_Height:lblPrice] prev_frame:last_frame gap:(self.gap * 3)];
    
     /* add credit card */
     if(credit_card_obj.credit_card_id == nil)
     {
         UIButton* btnAddCard = [Coding Create_Link_Button:@"Add a Credit Card" font:link_button_font];
         [btnAddCard addTarget:self action:@selector(btnAddCard_Click:) forControlEvents:UIControlEventTouchUpInside];
         [Coding Add_View:contentView view:btnAddCard x:self.screen_indent_x height:btnAddCard.frame.size.height prev_frame:lblPrice.frame gap:(self.gap * 2)];
         
         last_frame = btnAddCard.frame;
     }
     else
     {
         CGFloat image_height = self.screen_height * .11;
         UIImageView *imgCardType = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image_height, image_height)];
         [imgCardType setImage:[UIImage imageNamed:credit_card_obj.credit_card_type_obj.image]];
         [Coding Add_View:contentView view:imgCardType x:self.screen_indent_x height:imgCardType.frame.size.height prev_frame:lblPrice.frame gap:0];
         
         GTLabel *lblCreditCard = [Coding Create_Label:credit_card_obj.card_number width:self.screen_indent_width font:label_font mult:YES];
         [Coding Add_View:contentView view:lblCreditCard x:imgCardType.frame.origin.x + imgCardType.frame.size.width + self.gap height:[Utilities Get_Height:lblCreditCard] prev_frame:lblPrice.frame gap:(self.gap * 4)];
         
         UIButton* btnSelectCard = [Coding Create_Link_Button:@"Use a different card" font:link_button_font];
         [btnSelectCard addTarget:self action:@selector(btnSelectCard_Click:) forControlEvents:UIControlEventTouchUpInside];
         [Coding Add_View:contentView view:btnSelectCard x:self.screen_indent_x height:btnSelectCard.frame.size.height prev_frame:imgCardType.frame gap:(self.gap * 2)];
         
         last_frame = btnSelectCard.frame;
     }
     
     UIView *vwLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_indent_width, 1)];
     vwLine1.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
     [Coding Add_View:contentView view:vwLine1 x:self.screen_indent_x height:1 prev_frame:last_frame gap:(self.gap * 6)];
    
     [self Add_View:self.screen_width height:[self Get_Scroll_Height:vwLine0.frame scroll_lag:self.button_height] background_color:[UIColor whiteColor]];

     /* add layer on top of view */
     CGFloat nav_bar_height = self.navigationController.navigationBar.frame.size.height;
     CGRect status_frame = [(AppDelegate*)[[UIApplication sharedApplication] delegate] currentStatusBarFrame];
     CGFloat status_bar_height = status_frame.size.height;
     CGFloat button_y = self.screen_height - self.button_height - nav_bar_height - status_bar_height;
    
     btnBuy = [Coding Create_Button:@"Confirm Purchase" font:button_font style:ACPButtonDarkGrey text_color:[UIColor whiteColor] width:self.screen_width height:self.button_height];
     [btnBuy addTarget:self action:@selector(btnBuy_Click:) forControlEvents:UIControlEventTouchUpInside];
     [Coding Add_View:self.view view:btnBuy x:0 height:btnBuy.frame.size.height prev_frame:CGRectNull gap:button_y];
}

-(void)btnAddCard_Click:(id)sender
{
    Credit_Card_Add* vc_credit_card_add = [[Credit_Card_Add alloc]init];
    vc_credit_card_add.deal_controller = self.deal_controller;
    vc_credit_card_add.customer_controller = self.customer_controller;
    vc_credit_card_add.system_controller = self.system_controller;
    vc_credit_card_add.hidesBottomBarWhenPushed = YES;
    vc_credit_card_add.screen_type = @"present";
    vc_credit_card_add.left_button = @"close";
    
    if(![self.navigationController.topViewController isKindOfClass:[Credit_Card_Add class]])
    {
        [self.navigationController pushViewController:vc_credit_card_add animated:YES];
    }
    
//    UINavigationController *navigationController =
//    [[UINavigationController alloc] initWithRootViewController:vc_credit_card_add];
//    
//    [self presentViewController:navigationController animated:YES completion:^{}];
}

-(void)btnSelectCard_Click:(id)sender
{
    Credit_Cards* vc_credit_cards = [[Credit_Cards alloc]init];
    vc_credit_cards.deal_controller = self.deal_controller;
    vc_credit_cards.customer_controller = self.customer_controller;
    vc_credit_cards.system_controller = self.system_controller;
    vc_credit_cards.hidesBottomBarWhenPushed = YES;
    vc_credit_cards.screen_type = @"present";
    vc_credit_cards.calling_view = [[self class] description];
    
    if(![self.navigationController.topViewController isKindOfClass:[Credit_Cards class]])
    {
        [self.navigationController pushViewController:vc_credit_cards animated:YES];
    }
}

-(void)btnApplyPromo_Click:(id)sender
{
    if([txtPromotion.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Promotion" message:@"You must enter a promo code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self Progress_Show:@"Applying Promo"];
        
        Promotion* promotion_obj = [[Promotion alloc]init];
        promotion_obj.promotion_code = txtPromotion.text;
        
        self.deal_controller.customer_obj = self.customer_controller.customer_obj;
        self.deal_controller.promotion_obj = promotion_obj;
        [self.deal_controller Apply_Promotion:^(void)
         {
             successful = self.deal_controller.successful;
             system_successful_obj = self.deal_controller.system_successful_obj;
             system_error_obj = self.deal_controller.system_error_obj;
             
             [self Progress_Close];
             
             if(successful)
             {
                 GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Successful" message:system_successful_obj.message cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
                 {
                     if (cancelled)
                     {
                         [self Create_Layout];
                     }
                 };
                 
                 [alert show];
             }
             else
             {
                 //[txtPromotion setText:@""];
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }
}

-(void)btnBuy_Click:(id)sender
{
    if(credit_card_obj.credit_card_id == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Credit Card" message:@"You must add a credit card" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self Progress_Show:@"Purchasing"];

        self.deal_controller.customer_obj = self.customer_controller.customer_obj;
        [self.deal_controller Buy_Certificate:^(void)
         {
             successful = self.deal_controller.successful;
             system_successful_obj = self.deal_controller.system_successful_obj;
             system_error_obj = self.deal_controller.system_error_obj;
             
             [self Progress_Close];
             
             if(successful)
             {
                 GTAlertView *alert = [[GTAlertView alloc] initWithTitle:@"Successful" message:system_successful_obj.message cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 
                 alert.completion = ^(BOOL cancelled, NSInteger buttonIndex)
                 {
                     if (cancelled)
                     {
                         [self.view endEditing:YES];
                         
                         purchased = true;
                         
                         [self dismissViewControllerAnimated:NO completion:nil];
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

-(void)Close_Click
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
