#import "Credit_Card_Add.h"


@interface Credit_Card_Add ()
{
    GTTextField* txtName;
    GTTextField* txtCardNumber;
    GTTextField* txtExpirationDate;
    GTTextField* txtBillingZipCode;
    GTTextField* txtSecurityCode;
}
@end


@implementation Credit_Card_Add

@synthesize pop_to_root;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.screen_title = @"ADD CARD";
    self.left_button = @"";
    self.right_button = @"";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self Set_Controller_Properties];
    
    [self Create_Layout];
    
    if(self.debug)
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


/* public methods */
-(void) Create_Layout
{
    txtName = [Coding Create_Text_Field:@"Card Holder Name" format_type:@"name" characters:@100 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtName x:self.screen_indent_x height:txtName.frame.size.height prev_frame:CGRectNull gap:(self.gap * 5)];

    txtCardNumber = [Coding Create_Text_Field:@"Card Number" format_type:@"credit_card" characters:@20 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtCardNumber x:self.screen_indent_x height:txtCardNumber.frame.size.height prev_frame:txtName.frame gap:self.gap];
    
    txtExpirationDate = [Coding Create_Text_Field:@"Exp. (mm/yy)" format_type:@"credit_card_expiration" characters:@4 width:(self.screen_indent_width/2)-self.screen_indent_x height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtExpirationDate x:self.screen_indent_x height:txtExpirationDate.frame.size.height prev_frame:txtCardNumber.frame gap:self.gap];
    
    txtSecurityCode = [Coding Create_Text_Field:@"CVV2" format_type:@"credit_card_security" characters:@4 width:(self.screen_indent_width/2)-self.screen_indent_x height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtSecurityCode x:(self.screen_indent_x * 2) + (self.screen_indent_width/2) height:txtSecurityCode.frame.size.height prev_frame:txtCardNumber.frame gap:self.gap];
    
    txtBillingZipCode = [Coding Create_Text_Field:@"Zip Code" format_type:@"zipcode" characters:@5 width:self.screen_indent_width height:self.text_field_height font:text_field_font];
    [Coding Add_View:contentView view:txtBillingZipCode x:self.screen_indent_x height:txtBillingZipCode.frame.size.height prev_frame:txtSecurityCode.frame gap:self.gap];
    
    ACPButton *btnAdd = [Coding Create_Button:@"Add Card" font:button_font style:ACPButtonDarkGrey text_color:[UIColor whiteColor] width:self.screen_indent_width height:self.button_height];
    [btnAdd addTarget:self action:@selector(btnAdd_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnAdd x:self.screen_indent_x height:btnAdd.frame.size.height prev_frame:txtBillingZipCode.frame gap:(self.gap * 5)];

    [self Add_View:self.screen_width height:[self Get_Scroll_Height:btnAdd.frame scroll_lag:self.button_height] background_color:[UIColor clearColor]];
}

-(void)btnAdd_Click:(id)sender
{
    NSString *card_holder_name = [txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *card_number = [[txtCardNumber.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *expiration_date = [[txtExpirationDate.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *billing_zip_code = [[txtBillingZipCode.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSString *security_code = [[txtSecurityCode.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    
    Credit_Card *credit_card_obj = [[Credit_Card alloc] init];
    credit_card_obj.card_holder_name = card_holder_name;
    credit_card_obj.card_number = card_number;
    credit_card_obj.expiration_date = expiration_date;
    credit_card_obj.billing_zip_code = billing_zip_code;
    
    if(card_holder_name.length == [@0 longLongValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name" message:@"You must enter a card holder name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtName becomeFirstResponder];
    }
    else if((card_number.length != [@15 longLongValue]) && (card_number.length != [@16 longLongValue]))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card Number" message:@"Card number is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtCardNumber becomeFirstResponder];
    }
    else if(expiration_date.length != [@4 longLongValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expiration Date" message:@"Expiration date is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtExpirationDate becomeFirstResponder];
    }
    else if(billing_zip_code.length != [@5 longLongValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Billing Zip Code" message:@"Zip code is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtBillingZipCode becomeFirstResponder];
    }
    else if((security_code.length != [@3 longLongValue]) && (security_code.length != [@4 longLongValue]))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Security Code" message:@"Security code is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [txtSecurityCode  becomeFirstResponder];
    }
    else
    {
        [self.view endEditing:YES];
        
        [self Progress_Show:@"Adding Card"];
        
        self.customer_controller.credit_card_obj = credit_card_obj;
        [self.customer_controller Add_Credit_Card:^(void)
         {
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
                         if(pop_to_root)
                             [self.navigationController popToRootViewControllerAnimated:TRUE];
                         else
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
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)Close_Click
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)Debug
{
    txtName.text = @"George Triarhos";
    txtCardNumber.text = @"373999696015009";
    txtExpirationDate.text = @"0417";
    txtSecurityCode.text = @"3940";
    txtBillingZipCode.text = @"92037";
}

@end
