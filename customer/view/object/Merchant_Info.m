#import "Merchant_Info.h"

@interface Merchant_Info ()
{
    UIButton *btnPhone;
    UIButton *btnDirections;
    UIButton *btnWebsite;
    NSString *url_merchant_address;
}
@end


@implementation Merchant_Info


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.screen_title = @"COMPANY INFO";
    self.left_button = @"back";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self Progress_Show:@"Loading"];
    
    [self Create_Layout];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* not sure why i need this, but screen will lock up without it */
    self.navigationController.navigationBar.topItem.leftBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.backBarButtonItem.enabled = YES;
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* public methods */
-(void)Create_Layout
{
    Merchant* merchant_obj = self.deal_controller.deal_obj.merchant_contact_obj.merchant_obj;
    
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString *address_1 =[NSString stringWithFormat: @"%@%@%@", merchant_obj.address_1, @" ", merchant_obj.address_2];
    NSString *address_2 =[NSString stringWithFormat: @"%@%@%@%@%@", merchant_obj.zip_code_obj.city_obj.city, @", ", merchant_obj.zip_code_obj.city_obj.state_obj.abbreviation, @"  ", merchant_obj.zip_code_obj.zip_code];
    NSString *phone =[NSString stringWithFormat: @"%@%@%@%@%@%@", @"(", [merchant_obj.phone substringWithRange:NSMakeRange(0, 3)], @") ", [merchant_obj.phone substringWithRange:NSMakeRange(3, 3)], @"-", [merchant_obj.phone substringWithRange:NSMakeRange(6, 4)]];
    url_merchant_address = [NSString stringWithFormat:@"%@%@%@", address_1, @" ", address_2];
    
    NSString* neighborhood;
    if(merchant_obj.neighborhood_obj.neighborhood_id == nil)
        neighborhood = merchant_obj.zip_code_obj.city_obj.city;
    else
        neighborhood = merchant_obj.neighborhood_obj.neighborhood;
    
    GTLabel *lblCompanyName = [Coding Create_Label:merchant_obj.company_name width:self.screen_width font:label_font_large mult:NO];
    [lblCompanyName setTextAlignment:NSTextAlignmentCenter];
    [Coding Add_View:contentView view:lblCompanyName x:0 height:lblCompanyName.frame.size.height prev_frame:CGRectNull gap:(self.gap * 2)];
    
    GTLabel *lblNeighborhood = [Coding Create_Label:neighborhood width:self.screen_width font:label_font mult:NO];
    [lblNeighborhood setTextAlignment:NSTextAlignmentCenter];
    [Coding Add_View:contentView view:lblNeighborhood x:0 height:lblNeighborhood.frame.size.height prev_frame:lblCompanyName.frame gap:self.gap];
    
    CGFloat image_width = self.screen_width/2;
    UIImageView *imvLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image_width, image_width)];
    imvLogo.layer.cornerRadius = 6;
    imvLogo.clipsToBounds = YES;
    imvLogo.layer.borderWidth = 1.0f;
    imvLogo.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [imvLogo sd_setImageWithURL:[NSURL URLWithString:merchant_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [Coding Add_View:contentView view:imvLogo x:self.screen_width * .25 height:image_width prev_frame:lblNeighborhood.frame gap:(self.gap * 5)];

    /* stars image */
    CGFloat star_width = self.screen_width * .5;
    CGFloat star_x = self.screen_width * .25;
    
    UIImageView *imgStars = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, star_width, self.screen_height * .052)];
    imgStars.image = [UIImage imageNamed:merchant_obj.merchant_rating_obj.image];
    [Coding Add_View:contentView view:imgStars x:star_x height:imgStars.frame.size.height prev_frame:imvLogo.frame gap:(self.gap * 5)];

    GTLabel *lblDescription = [Coding Create_Label:merchant_obj.description width:self.screen_indent_width font:label_font mult:YES];
    [Coding Add_View:contentView view:lblDescription x:self.screen_indent_x height:[Utilities Get_Height:lblDescription] prev_frame:imgStars.frame gap:(self.gap * 5)];
    
    UIView *vwLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.screen_width, scrollView.bounds.size.width, 1)];
    vwLine1.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
    [Coding Add_View:contentView view:vwLine1 x:0 height:1 prev_frame:lblDescription.frame gap:(self.gap * 7)];
    
    GTLabel *lblLocationLabel = [Coding Create_Label:@"LOCATION" width:self.screen_indent_width font:label_font mult:NO];
    [Coding Add_View:contentView view:lblLocationLabel x:self.screen_indent_x height:[Utilities Get_Height:lblLocationLabel] prev_frame:vwLine1.frame gap:(self.gap * 7)];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height * .37)];
    //mapView.mapType = MKMapType.Standard;
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
    [Coding Add_View:contentView view:mapView x:0 height:mapView.frame.size.height prev_frame:lblLocationLabel.frame gap:(self.gap * 2)];
    
    GTLabel *lblAddress1 = [Coding Create_Label:address_1 width:self.screen_indent_width font:label_font mult:NO];
    [Coding Add_View:contentView view:lblAddress1 x:self.screen_indent_x height:[Utilities Get_Height:lblAddress1] prev_frame:mapView.frame gap:(self.gap * 5)];
    
    GTLabel *lblAddress2 = [Coding Create_Label:address_2 width:self.screen_indent_width font:label_font mult:NO];
    [Coding Add_View:contentView view:lblAddress2 x:self.screen_indent_x height:[Utilities Get_Height:lblAddress2] prev_frame:lblAddress1.frame gap:(self.gap * 2)];
    
    btnDirections = [Coding Create_Link_Button:@"Directions" font:link_button_font];
    [btnDirections addTarget:self action:@selector(btnDirections_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnDirections x:self.screen_indent_x height:btnDirections.frame.size.height prev_frame:lblAddress2.frame gap:(self.gap * 5)];
    
    UIView *vwLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.screen_width, scrollView.bounds.size.width, 1)];
    vwLine2.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255 blue:190.0/255.0 alpha:1];
    [Coding Add_View:contentView view:vwLine2 x:0 height:1 prev_frame:btnDirections.frame gap:(self.gap * 7)];
    
    GTLabel *lblContactLabel = [Coding Create_Label:@"CONTACT" width:self.screen_indent_width font:label_font mult:NO];
    [Coding Add_View:contentView view:lblContactLabel x:self.screen_indent_x height:[Utilities Get_Height:lblContactLabel] prev_frame:vwLine2.frame gap:(self.gap * 7)];
    
    btnPhone = [Coding Create_Link_Button:phone font:link_button_font];
    [btnPhone addTarget:self action:@selector(btnPhone_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnPhone x:self.screen_indent_x height:btnPhone.frame.size.height prev_frame:lblContactLabel.frame gap:(self.gap * 5)];
    
    btnWebsite = [Coding Create_Link_Button:@"Website" font:link_button_font];
    [btnWebsite addTarget:self action:@selector(btnWebsite_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:contentView view:btnWebsite x:self.screen_indent_x height:btnWebsite.frame.size.height prev_frame:btnPhone.frame gap:(self.gap * 5)];
    
    [self Add_View:self.screen_width height:[self Get_Scroll_Height:btnWebsite.frame scroll_lag:0] background_color:[UIColor whiteColor]];

    [self Progress_Close];
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

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}


@end
