#import "Deal_Detail.h"


@interface Deal_Detail ()
{
    UIButton *btnPhone;
    UIButton *btnDirections;
    UIButton *btnWebsite;
    NSString *url_merchant_address;
    ACPButton *btnBuy;

    Merchant_Info *vc_merchant_info;
    Deal_Purchase * vc_deal_purchase;
}

@end


@implementation Deal_Detail

@synthesize picked_image_file_name;

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
    
    if(vc_deal_purchase.purchased == true)
    {
        vc_deal_purchase.purchased = false;
        [self.navigationController popViewControllerAnimated:TRUE];
        [self.tabBarController setSelectedIndex:1];
    }
    else
    {
        [self Create_Layout];
        [self Log_View];
    }
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

- (void)statusFrameChanged:(NSNotification*)note
{
    CGRect status_frame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    CGFloat status_bar_height = status_frame.size.height;
    
    CGFloat button_y;
    if(status_bar_height == 20)
        button_y = 448;
    else
        button_y = 428;
    
    btnBuy.frame = CGRectMake(0, button_y, 320, 55.0);
}


/* public methods */
-(void)Create_Layout
{
    Deal* deal_obj = self.deal_controller.deal_obj;
    Merchant* merchant_obj = self.deal_controller.deal_obj.merchant_contact_obj.merchant_obj;

    /* add deal image */
    UIImageView *imvDeal = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_width * .75)];
    [imvDeal sd_setImageWithURL:[NSURL URLWithString:deal_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [contentView addSubview:imvDeal];

    GTLabel *lblCompanyName = [Coding Create_Label:merchant_obj.company_name width:(self.screen_indent_width * .73) font:label_font_large mult:YES];
    [Coding Add_View:contentView view:lblCompanyName x:self.screen_indent_x height:[Utilities Get_Height:lblCompanyName] prev_frame:imvDeal.frame gap:self.gap];

    /* add company logo to the right */
    CGFloat logo_width = self.screen_width * .25;
    CGFloat logo_x = self.screen_width * .725;
    UIImageView *imvLogo = [[UIImageView alloc] initWithFrame:CGRectMake(logo_x, 0, logo_width, logo_width)];
    imvLogo.layer.cornerRadius = 6;
    imvLogo.clipsToBounds = YES;
    imvLogo.layer.borderWidth = 1.0f;
    imvLogo.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [imvLogo sd_setImageWithURL:[NSURL URLWithString:merchant_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [Coding Add_View:contentView view:imvLogo x:logo_x height:imvLogo.frame.size.height prev_frame:imvDeal.frame gap:(self.gap * 2)];

    UITapGestureRecognizer *tapMerchant = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imvLogo_Click)];
    tapMerchant.numberOfTapsRequired = 1;
    [imvLogo setUserInteractionEnabled:YES];
    [imvLogo addGestureRecognizer:tapMerchant];

    /* get neighborhood */
    NSString* neighborhood;
    if(merchant_obj.neighborhood_obj.neighborhood_id == nil)
      neighborhood = merchant_obj.zip_code_obj.city_obj.city;
    else
      neighborhood = merchant_obj.neighborhood_obj.neighborhood;

    GTLabel *lblNeighborhood = [Coding Create_Label:neighborhood width:(self.screen_indent_width * .60) font:label_font mult:NO];
    [Coding Add_View:contentView view:lblNeighborhood x:self.screen_indent_x height:[Utilities Get_Height:lblNeighborhood] prev_frame:lblCompanyName.frame gap:self.gap];

    NSString* distance = [deal_obj.distance stringValue];
    CGFloat distance_x = lblNeighborhood.frame.origin.x + [Utilities Get_Label_Width:lblNeighborhood];
    GTLabel* lblDistance =[Coding Create_Label:[NSString stringWithFormat: @"%@%@%@", @" - ", distance, @ "mi"] width:100 font:label_font mult:NO];
    [Coding Add_View:contentView view:lblDistance x:distance_x height:lblDistance.frame.size.height prev_frame:lblCompanyName.frame gap:(self.gap)];

    /* stars image */
    UIImageView *imgStars = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width * .3125, self.screen_height * .035)];
    imgStars.image = [UIImage imageNamed:merchant_obj.merchant_rating_obj.image];
    [Coding Add_View:contentView view:imgStars x:self.screen_indent_x height:imgStars.frame.size.height prev_frame:lblNeighborhood.frame gap:(self.gap * 3)];

    UIView *vwLine0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_indent_width, 1)];
    vwLine0.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
    [Coding Add_View:contentView view:vwLine0 x:self.screen_indent_x height:1 prev_frame:imgStars.frame gap:(self.gap * 7)];

    GTLabel *lblDeal = [Coding Create_Label:deal_obj.deal width:self.screen_indent_width font:label_font_large mult:YES];
    [Coding Add_View:contentView view:lblDeal x:self.screen_indent_x height:[Utilities Get_Height:lblDeal] prev_frame:vwLine0.frame gap:(self.gap * 7)];

    /* get date info */
    NSString *time_zone = merchant_obj.zip_code_obj.time_zone_obj.abbreviation;// deal_obj.time_zone_obj.abbreviation;
    NSDate * expiration_date = deal_obj.expiration_date;
    NSDateFormatter *expiration_date_format = [[NSDateFormatter alloc] init];
    [expiration_date_format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:time_zone]];
    [expiration_date_format setDateFormat:@"M/d/yyyy"];

    GTLabel *lblExpirationDate = [Coding Create_Label:[NSString stringWithFormat: @"%@%@", @"Offer ends on ", [expiration_date_format stringFromDate:expiration_date]] width:self.screen_indent_width font:label_font_large mult:YES];
    [Coding Add_View:contentView view:lblExpirationDate x:self.screen_indent_x height:[Utilities Get_Height:lblExpirationDate] prev_frame:lblDeal.frame gap:(self.gap * 3)];

    UIView *vwLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_indent_width, 1)];
    vwLine1.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
    [Coding Add_View:contentView view:vwLine1 x:self.screen_indent_x height:1 prev_frame:lblExpirationDate.frame gap:(self.gap * 7)];

    GTLabel *lblFinePrintLabel = [Coding Create_Label:@"FINE PRINT" width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:contentView view:lblFinePrintLabel x:self.screen_indent_x height:[Utilities Get_Height:lblFinePrintLabel] prev_frame:vwLine1.frame gap:(self.gap * 7)];

    GTLabel *lblFinePrint = [Coding Create_Label:deal_obj.fine_print_ext width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:contentView view:lblFinePrint x:self.screen_indent_x height:[Utilities Get_Height:lblFinePrint] prev_frame:lblFinePrintLabel.frame gap:(self.gap)];

    UIView *vwLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_indent_width, 1)];
    vwLine2.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
    [Coding Add_View:contentView view:vwLine2 x:self.screen_indent_x height:1 prev_frame:lblFinePrint.frame gap:(self.gap * 7)];

    GTLabel *lblCertificatesRemaining = [Coding Create_Label:[NSString stringWithFormat: @"%@%@", [deal_obj.certificate_quantity stringValue], @" certificates left!"] width:self.screen_indent_width font:label_font_large mult:YES];
    [Coding Add_View:contentView view:lblCertificatesRemaining x:self.screen_indent_x height:[Utilities Get_Height:lblCertificatesRemaining] prev_frame:vwLine2.frame gap:(self.gap * 7)];

    UIView *vwLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_indent_width, 1)];
    vwLine3.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
    [Coding Add_View:contentView view:vwLine3 x:self.screen_indent_x height:1 prev_frame:lblCertificatesRemaining.frame gap:(self.gap * 7)];

    GTLabel *lblCompanyInfoLabel = [Coding Create_Label:@"COMPANY INFORMATION" width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:contentView view:lblCompanyInfoLabel x:self.screen_indent_x height:[Utilities Get_Height:lblCompanyInfoLabel] prev_frame:vwLine3.frame gap:(self.gap * 7)];

    /* get address info */
    NSString *address_1 =[NSString stringWithFormat: @"%@%@%@", merchant_obj.address_1, @" ", merchant_obj.address_2];
    NSString *address_2 =[NSString stringWithFormat: @"%@%@%@%@%@", merchant_obj.zip_code_obj.city_obj.city, @", ", merchant_obj.zip_code_obj.city_obj.state_obj.abbreviation, @"  ", merchant_obj.zip_code_obj.zip_code];
    NSString *phone =[NSString stringWithFormat: @"%@%@%@%@%@%@", @"(", [merchant_obj.phone substringWithRange:NSMakeRange(0, 3)], @") ", [merchant_obj.phone substringWithRange:NSMakeRange(3, 3)], @"-", [merchant_obj.phone substringWithRange:NSMakeRange(6, 4)]];
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
    [Coding Add_View:contentView view:mapView x:0 height:self.screen_height * .37 prev_frame:lblCompanyInfoLabel.frame gap:(self.gap)];

    GTLabel *lblAddress1 = [Coding Create_Label:address_1 width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:contentView view:lblAddress1 x:self.screen_indent_x height:[Utilities Get_Height:lblAddress1] prev_frame:mapView.frame gap:(self.gap * 2)];

    GTLabel *lblAddress2 = [Coding Create_Label:address_2 width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:contentView view:lblAddress2 x:self.screen_indent_x height:[Utilities Get_Height:lblAddress2] prev_frame:lblAddress1.frame gap:(self.gap * 2)];

    btnDirections = [Coding Create_Link_Button:@"Directions" font:link_button_font];
    [btnDirections addTarget:self action:@selector(btnDirections_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnDirections x:self.screen_indent_x height:btnDirections.frame.size.height prev_frame:lblAddress2.frame gap:(self.gap * 5)];

    btnPhone = [Coding Create_Link_Button:phone font:link_button_font];
    [btnPhone addTarget:self action:@selector(btnPhone_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnPhone x:self.screen_indent_x height:btnPhone.frame.size.height prev_frame:btnDirections.frame gap:(self.gap * 5)];

    btnWebsite = [Coding Create_Link_Button:@"Website" font:link_button_font];
    [btnWebsite addTarget:self action:@selector(btnWebsite_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnWebsite x:self.screen_indent_x height:btnWebsite.frame.size.height prev_frame:btnPhone.frame gap:(self.gap * 5)];

    [self Add_View:self.screen_width height:[self Get_Scroll_Height:btnWebsite.frame scroll_lag:self.button_height] background_color:[UIColor whiteColor]];

    /* add layer on top of view */
    CGFloat nav_bar_height = self.navigationController.navigationBar.frame.size.height;
    CGRect status_frame = [(AppDelegate*)[[UIApplication sharedApplication] delegate] currentStatusBarFrame];
    CGFloat status_bar_height = status_frame.size.height;
    CGFloat button_y = self.screen_height - self.button_height - nav_bar_height - status_bar_height;

    btnBuy = [Coding Create_Button:[NSString stringWithFormat:@"%@%@", @"Buy this Deal for $", deal_obj.certificate_amount] font:button_font style:ACPButtonDarkGrey text_color:[UIColor whiteColor] width:self.screen_width height:self.button_height];
    [btnBuy addTarget:self action:@selector(btnBuy_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:self.view view:btnBuy x:0 height:btnBuy.frame.size.height prev_frame:CGRectNull gap:button_y];
}

-(void)Log_View
{
    Zip_Code* zip_code_obj = [[Zip_Code alloc]init];
    zip_code_obj.zip_code = self.customer_controller.customer_obj.zip_code_obj.zip_code;
    zip_code_obj.latitude = self.customer_controller.contact_gps_log_obj.latitude;
    zip_code_obj.longitude = self.customer_controller.contact_gps_log_obj.longitude;
 
    self.deal_controller.zip_code_obj = zip_code_obj;
    self.deal_controller.customer_obj = self.customer_controller.customer_obj;
    [self.deal_controller Get_Deal_Detail:^(void)
    {
        successful = self.deal_controller.successful;
        system_successful_obj = self.deal_controller.system_successful_obj;
        system_error_obj = self.deal_controller.system_error_obj;
    
        if(!successful)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}


-(void)imvLogo_Click
{
    if(vc_merchant_info == nil)
    {
        vc_merchant_info = [[Merchant_Info alloc]init];
    }
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
    NSString *website = self.deal_controller.deal_obj.merchant_contact_obj.merchant_obj.website;
    
    NSRange range = [website rangeOfString:@"http://"];
    
    if (range.location == NSNotFound)
        website = [NSString stringWithFormat:@"%@%@", @"http://", website];
    
    NSURL *url = [NSURL URLWithString:website];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)btnBuy_Click:(id)sender
{
    if(vc_deal_purchase == nil)
    {
        vc_deal_purchase = [[Deal_Purchase alloc]init];
    }
    vc_deal_purchase.calling_view = NSStringFromClass([self class]);
    vc_deal_purchase.deal_controller = self.deal_controller;
    vc_deal_purchase.customer_controller= self.customer_controller;
    vc_deal_purchase.system_controller = self.system_controller;
    vc_deal_purchase.hidesBottomBarWhenPushed = YES;

//    UINavigationController *navigationController =
//    [[UINavigationController alloc] initWithRootViewController:vc_deal_purchase];
    
    Navigation_Controller* navigationController = [[Navigation_Controller alloc] initWithRootViewController:vc_deal_purchase];
    
    [self presentViewController:navigationController animated:YES completion:^{}];
    
//    if(![self.navigationController.topViewController isKindOfClass:[Deal_Purchase class]])
//    {
//        [self.navigationController pushViewController:vc_deal_purchase animated:YES];
//    }
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
