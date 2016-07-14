#import "Certificate_Detail.h"


@interface Certificate_Detail ()
{
    UIButton *btnPhone;
    
    NSString *url_merchant_address;
    NSString* website;
}
@end


@implementation Certificate_Detail

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screen_title = @"DETAILS";
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
    self.deal_controller.customer_obj = self.customer_controller.customer_obj;
    [self.deal_controller Get_Certificate_Detail:^(void)
     {
         successful = self.deal_controller.successful;
         system_successful_obj = self.deal_controller.system_successful_obj;
         system_error_obj = self.deal_controller.system_error_obj;
         
         if(successful)
         {
             Certificate* certificate_obj = self.deal_controller.certificate_obj;
             Deal* deal_obj = certificate_obj.deal_obj;
             Merchant* merchant_obj = certificate_obj.deal_obj.merchant_contact_obj.merchant_obj;
             Customer* customer_obj = certificate_obj.customer_obj;
             
             /* set this to view merchant info screen */
             self.deal_controller.deal_obj = deal_obj;
             
             /* add deal image */
             GTLabel *lblCertificateCodeLabel = [Coding Create_Label:@"Certificate Id" width:self.screen_indent_width font:label_font_medium mult:NO];
             [lblCertificateCodeLabel setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblCertificateCodeLabel x:self.screen_indent_x height:[Utilities Get_Height:lblCertificateCodeLabel] prev_frame:CGRectNull gap:(self.gap * 7)];
             
             GTLabel *lblCertificateCode = [Coding Create_Label:certificate_obj.certificate_code width:self.screen_indent_width font:label_font_large mult:NO];
             [lblCertificateCode setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblCertificateCode x:self.screen_indent_x height:[Utilities Get_Height:lblCertificateCode] prev_frame:lblCertificateCodeLabel.frame gap:(self.gap * .25)];
             
             GTLabel *lblStatus = [Coding Create_Label:certificate_obj.status_text_2 width:self.screen_indent_width font:label_font_medium mult:NO];
             [lblStatus setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblStatus x:self.screen_indent_x height:lblStatus.frame.size.height prev_frame:lblCertificateCode.frame gap:(self.gap * .25)];
             
             UIView *vwLine0 = [Coding Create_Straight_Line:self.screen_width];
             [Coding Add_View:contentView view:vwLine0 x:vwLine0.frame.origin.x height:1 prev_frame:lblStatus.frame gap:(self.gap * 7)];

             NSString* full_name = [NSString stringWithFormat: @"%@%@%@", customer_obj.contact_obj.first_name, @" ", customer_obj.contact_obj.last_name];
             GTLabel *lblIssuedTo = [Coding Create_Label:[NSString stringWithFormat: @"%@%@", @"Issued to ", full_name] width:self.screen_indent_width font:label_font_medium mult:NO];
             [lblIssuedTo setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblIssuedTo x:self.screen_indent_x height:[Utilities Get_Height:lblIssuedTo] prev_frame:vwLine0.frame gap:(self.gap * 7)];
             
             /* issued on info */
             NSString *time_zone = deal_obj.time_zone_obj.abbreviation;
             NSDate * assigned_date = certificate_obj.assigned_date;
             NSDateFormatter *assigned_date_format = [[NSDateFormatter alloc] init];
             [assigned_date_format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:time_zone]];
             [assigned_date_format setDateFormat:@"M/d/yyyy"];
             
             GTLabel *lblAssignedDate = [Coding Create_Label:[NSString stringWithFormat: @"%@%@", @"Purchased on ", [assigned_date_format stringFromDate:assigned_date]] width:self.screen_indent_width font:label_font_medium mult:NO];
             [lblAssignedDate setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblAssignedDate x:self.screen_indent_x height:[Utilities Get_Height:lblAssignedDate] prev_frame:lblIssuedTo.frame gap:(self.gap * 3)];
             
             UIView *vwLine1 = [Coding Create_Straight_Line:self.screen_width];
             [Coding Add_View:contentView view:vwLine1 x:vwLine1.frame.origin.x height:1 prev_frame:lblAssignedDate.frame gap:(self.gap * 7)];
             
             GTLabel *lblCompanyName = [Coding Create_Label:merchant_obj.company_name width:self.screen_indent_width font:label_font_large mult:NO];
             [lblCompanyName setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblCompanyName x:self.screen_indent_x height:[Utilities Get_Height:lblCompanyName] prev_frame:vwLine1.frame gap:(self.gap * 7)];
             
             GTLabel *lblDeal = [Coding Create_Label:deal_obj.deal width:self.screen_indent_width font:label_font_large mult:NO];
             [lblDeal setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblDeal x:self.screen_indent_x height:[Utilities Get_Height:lblDeal] prev_frame:lblCompanyName.frame gap:(self.gap * 3)];
 
             /* get date info */
             NSDate * expiration_date = certificate_obj.expiration_date;
             NSDateFormatter *expiration_date_format = [[NSDateFormatter alloc] init];
             [expiration_date_format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:time_zone]];
             [expiration_date_format setDateFormat:@"M/d/yyyy"];
 
             GTLabel *lblExpirationDate = [Coding Create_Label:[NSString stringWithFormat: @"%@%@", @"Expires on ", [expiration_date_format stringFromDate:expiration_date]] width:self.screen_indent_width font:label_font_medium mult:NO];
             [lblExpirationDate setTextAlignment:NSTextAlignmentCenter];
             [Coding Add_View:contentView view:lblExpirationDate x:self.screen_indent_x height:[Utilities Get_Height:lblExpirationDate] prev_frame:lblDeal.frame gap:(self.gap * 3)];
             
             /* add company logo */
             CGFloat logo_width = self.screen_width * .25;
             CGFloat logo_x = (self.screen_width - logo_width)/2;
             UIImageView *imvLogo = [[UIImageView alloc] initWithFrame:CGRectMake(logo_x, 0, logo_width, logo_width)];
             imvLogo.layer.cornerRadius = 6;
             imvLogo.clipsToBounds = YES;
             imvLogo.layer.borderWidth = 1.0f;
             imvLogo.layer.borderColor = [[UIColor lightGrayColor] CGColor];
             [imvLogo sd_setImageWithURL:[NSURL URLWithString:merchant_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
             [Coding Add_View:contentView view:imvLogo x:logo_x height:imvLogo.frame.size.height prev_frame:lblExpirationDate.frame gap:(self.gap * 7)];
             
             UITapGestureRecognizer *tapMerchant = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imvLogo_Click)];
             tapMerchant.numberOfTapsRequired = 1;
             [imvLogo setUserInteractionEnabled:YES];
             [imvLogo addGestureRecognizer:tapMerchant];

             UIView *vwLine2 = [Coding Create_Straight_Line:self.screen_width];
             [Coding Add_View:contentView view:vwLine2 x:vwLine2.frame.origin.x height:1 prev_frame:imvLogo.frame gap:(self.gap * 7)];

             /* get address info */
             NSString *address_1 = [NSString stringWithFormat: @"%@%@%@", merchant_obj.address_1, @" ", merchant_obj.address_2];
             NSString *address_2 = [NSString stringWithFormat: @"%@%@%@%@%@", merchant_obj.zip_code_obj.city_obj.city, @", ", merchant_obj.zip_code_obj.city_obj.state_obj.abbreviation, @"  ", merchant_obj.zip_code_obj.zip_code];
             NSString *phone = [NSString stringWithFormat: @"%@%@%@%@%@%@", @"(", [merchant_obj.phone substringWithRange:NSMakeRange(0, 3)], @") ", [merchant_obj.phone substringWithRange:NSMakeRange(3, 3)], @"-", [merchant_obj.phone substringWithRange:NSMakeRange(6, 4)]];
             url_merchant_address = [NSString stringWithFormat:@"%@%@%@", address_1, @" ", address_2];

             MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height * .37)];
             [mapView setZoomEnabled:NO];
             [mapView setScrollEnabled:NO];

             UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnDirections_Click:)];
             [mapView addGestureRecognizer:tapGesture];

             CLGeocoder *geocoder = [[CLGeocoder alloc] init];
             [geocoder geocodeAddressString:[NSString stringWithFormat: @"%@%@%@", address_1, @" ", address_2] completionHandler:^(NSArray* placemarks, NSError* error){
                 for (CLPlacemark* aPlacemark in placemarks)
                 {
                   // Process the placemark.
                   NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
                   NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];

                   CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([latDest1 doubleValue], [lngDest1 doubleValue]);

                   MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
                   MKCoordinateRegion region = {coord, span};

                   MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                   [annotation setCoordinate:coord];
                   [mapView setRegion:region];
                   [annotation setTitle:merchant_obj.company_name]; //You can set the subtitle too
                   [mapView addAnnotation:annotation];
                 }
             }];
             [Coding Add_View:contentView view:mapView x:0 height:self.screen_height * .37 prev_frame:vwLine2.frame gap:(self.gap * 2)];

             GTLabel *lblAddress1 = [Coding Create_Label:address_1 width:self.screen_indent_width font:label_font mult:YES];
             [Coding Add_View:contentView view:lblAddress1 x:self.screen_indent_x height:[Utilities Get_Height:lblAddress1] prev_frame:mapView.frame gap:(self.gap * 2)];

             GTLabel *lblAddress2 = [Coding Create_Label:address_2 width:self.screen_indent_width font:label_font mult:YES];
             [Coding Add_View:contentView view:lblAddress2 x:self.screen_indent_x height:[Utilities Get_Height:lblAddress2] prev_frame:lblAddress1.frame gap:(self.gap * 2)];

             UIButton* btnDirections = [Coding Create_Link_Button:@"Directions" font:link_button_font];
             [btnDirections addTarget:self action:@selector(btnDirections_Click:) forControlEvents:UIControlEventTouchUpInside];
             [Coding Add_View:contentView view:btnDirections x:self.screen_indent_x height:btnDirections.frame.size.height prev_frame:lblAddress2.frame gap:(self.gap * 5)];

             btnPhone = [Coding Create_Link_Button:phone font:link_button_font];
             [btnPhone addTarget:self action:@selector(btnPhone_Click:) forControlEvents:UIControlEventTouchUpInside];
             [Coding Add_View:contentView view:btnPhone x:self.screen_indent_x height:btnPhone.frame.size.height prev_frame:btnDirections.frame gap:(self.gap * 5)];

             website = merchant_obj.website;
             UIButton* btnWebsite = [Coding Create_Link_Button:@"Website" font:link_button_font];
             [btnWebsite addTarget:self action:@selector(btnWebsite_Click:) forControlEvents:UIControlEventTouchUpInside];
             [Coding Add_View:contentView view:btnWebsite x:self.screen_indent_x height:btnWebsite.frame.size.height prev_frame:btnPhone.frame gap:(self.gap * 5)];

             UIView *vwLine3 = [Coding Create_Straight_Line:self.screen_width];
             [Coding Add_View:contentView view:vwLine3 x:vwLine3.frame.origin.x height:1 prev_frame:btnWebsite.frame gap:(self.gap * 7)];
             
             GTLabel *lblFinePrintLabel = [Coding Create_Label:@"FINE PRINT" width:self.screen_indent_width font:label_font mult:YES];
             [Coding Add_View:contentView view:lblFinePrintLabel x:self.screen_indent_x height:[Utilities Get_Height:lblFinePrintLabel] prev_frame:vwLine3.frame gap:(self.gap * 7)];
 
             GTLabel *lblFinePrint = [Coding Create_Label:deal_obj.fine_print_ext width:self.screen_indent_width font:label_font mult:YES];
             [Coding Add_View:contentView view:lblFinePrint x:self.screen_indent_x height:[Utilities Get_Height:lblFinePrint] prev_frame:lblFinePrintLabel.frame gap:(self.gap * 2)];
             
             UIView *vwLine4 = [Coding Create_Straight_Line:self.screen_width];
             [Coding Add_View:contentView view:vwLine4 x:vwLine4.frame.origin.x height:1 prev_frame:lblFinePrint.frame gap:(self.gap * 7)];
             
             GTLabel *lblInstructionsLabel = [Coding Create_Label:@"INSTRUCTIONS" width:self.screen_indent_width font:label_font mult:YES];
             [Coding Add_View:contentView view:lblInstructionsLabel x:self.screen_indent_x height:[Utilities Get_Height:lblInstructionsLabel] prev_frame:vwLine4.frame gap:(self.gap * 7)];
             
             GTLabel *lblInstructions = [Coding Create_Label:deal_obj.instructions width:self.screen_indent_width font:label_font mult:YES];
             [Coding Add_View:contentView view:lblInstructions x:self.screen_indent_x height:[Utilities Get_Height:lblInstructions] prev_frame:lblInstructionsLabel.frame gap:(self.gap * 2)];
             
             [self Add_View:self.screen_width height:[self Get_Scroll_Height:lblInstructions.frame scroll_lag:0] background_color:[UIColor whiteColor]];
         }
     }];
}

-(void)imvLogo_Click
{
    Merchant_Info *vc_merchant_info = [[Merchant_Info alloc]init];
    vc_merchant_info.deal_controller = self.deal_controller;
    vc_merchant_info.customer_controller = self.customer_controller;
    vc_merchant_info.system_controller = self.system_controller;
    vc_merchant_info.hidesBottomBarWhenPushed = YES;
    
    if(![self.navigationController.topViewController isKindOfClass:[Merchant_Info class]])
    {
        [self.navigationController pushViewController:vc_merchant_info animated:YES];
    }
}

-(void)btnPhone_Click:(id)sender
{
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *phone_number = [[btnPhone.currentTitle componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"telprompt:", phone_number]]];
}

- (void)btnDirections_Click:(id)sender
{
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *destination_address = [[url_merchant_address componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@"+"];
    
    NSURL *google_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", @"comgooglemaps://?saddr=&daddr=", destination_address, @"&directionsmode=driving"]];
    
    if ([[UIApplication sharedApplication] canOpenURL:google_url])
    {
        [[UIApplication sharedApplication] openURL:google_url];
    }
    else
    {
        NSURL *apple_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", @"http://maps.apple.com/?saddr=Current+Location&daddr=", destination_address, @"&directionsmode=driving"]];
        [[UIApplication sharedApplication] openURL:apple_url];
    }
}

-(void)btnWebsite_Click:(id)sender
{
    NSRange range = [website rangeOfString:@"http://"];
    
    if (range.location == NSNotFound)
        website = [NSString stringWithFormat:@"%@%@", @"http://", website];
    
    NSURL *url = [NSURL URLWithString:website];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Website will not open" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
