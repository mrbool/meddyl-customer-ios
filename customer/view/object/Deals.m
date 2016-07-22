#import "Deals.h"
#import "Coding.h"
#import "UIImageView+WebCache.h"


@interface Deals ()
{
    UITableView *tblDeals;
    UITableViewController *tableViewController;
    NSMutableArray *deal_obj_array;
    Contact_GPS_Log* contact_gps_log_obj;
    BOOL loading_dialog;
}

@property (assign, nonatomic) INTULocationRequestID locationRequestID;
@property (weak, nonatomic) NSString *status_text;

@end


@implementation Deals

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.screen_title = @"DEALS";
    self.left_button = @"";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
    
    [self Create_Layout];
    
    loading_dialog = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    contact_gps_log_obj = [[Contact_GPS_Log alloc]init];
    self.customer_controller.contact_gps_log_obj = contact_gps_log_obj;
    contact_gps_log_obj.latitude = @0;
    contact_gps_log_obj.longitude = @0;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self Get_Location];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [deal_obj_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Deal *deal_obj = deal_obj_array[indexPath.row];
    Merchant* merchant_obj = deal_obj.merchant_contact_obj.merchant_obj;
    
    CGFloat view_height = self.screen_height * .63;
    UIView* viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_width, view_height)];
    viewCell.backgroundColor = [UIColor whiteColor];
    viewCell.translatesAutoresizingMaskIntoConstraints = NO;
    
    /* deal image */
    UIImageView *imgDeal = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width, (view_height * .66))];
    [imgDeal sd_setImageWithURL:[NSURL URLWithString:deal_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [viewCell addSubview:imgDeal];
    
    /* company image */
    CGFloat logo_width = self.screen_width * .225;
    CGFloat logo_x = self.screen_width * .703;
    CGFloat logo_y;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
        logo_y = view_height * .45;
    else
        logo_y = view_height * .5;
    UIImageView *imvLogo = [[UIImageView alloc] initWithFrame:CGRectMake(logo_x, 0, logo_width, logo_width)];
    imvLogo.layer.cornerRadius = 6;
    imvLogo.clipsToBounds = YES;
    imvLogo.layer.borderWidth = 1.0f;
    imvLogo.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [imvLogo sd_setImageWithURL:[NSURL URLWithString:merchant_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [Coding Add_View:viewCell view:imvLogo x:logo_x height:imvLogo.frame.size.height prev_frame:CGRectNull gap:logo_y];
    
//    /* price view */
//    NSString* dollars = [Utilities Get_Dollars_From_DecimalNumber:deal_obj.certificate_amount];
//    NSString* cents = [Utilities Get_Cents_From_DecimalNumber:deal_obj.certificate_amount];
//    
//    CGFloat cost_height = view_height * .12;
//    CGFloat cost_y = imgDeal.frame.size.height - (cost_height * 1.5);
//    UIView* viewCost = [[UIView alloc] initWithFrame:CGRectMake(0, cost_y, (self.screen_indent_width * .2), cost_height)];
//    viewCost.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1];
//    [viewCell addSubview:viewCost];
    
//    GTLabel *lblDollarSign = [Coding Create_Label:@"$" width:10 font:label_font_xsmall mult:NO];
//    lblDollarSign.textColor = [UIColor whiteColor];
//    [lblDollarSign sizeToFit];
//    
//    GTLabel *lblDollar = [Coding Create_Label:dollars width:10 font:label_font_large mult:NO];
//    lblDollar.textColor = [UIColor whiteColor];
//    [lblDollar sizeToFit];
//    
//    GTLabel *lblCents = [Coding Create_Label:cents width:10 font:label_font_xsmall mult:NO];
//    lblCents.textColor = [UIColor whiteColor];
//    [lblCents sizeToFit];
//
//    [Coding Add_View:viewCost view:lblDollarSign x:4 height:lblDollarSign.frame.size.height prev_frame:CGRectNull gap:(self.gap * 2)];
//    [Coding Add_View:viewCost view:lblDollar x:lblDollarSign.frame.origin.x + [Utilities Get_Label_Width:lblDollarSign] height:lblDollar.frame.size.height prev_frame:CGRectNull gap:(self.gap * 1)];
//    [Coding Add_View:viewCost view:lblCents x:lblDollar.frame.origin.x + [Utilities Get_Label_Width:lblDollar] height:lblCents.frame.size.height prev_frame:CGRectNull gap:(self.gap * 2)];

    /* add company name */
    GTLabel *lblCompanyName = [Coding Create_Label:merchant_obj.company_name width:self.screen_indent_width font:label_font_medium_medium mult:YES];
    [lblCompanyName setNumberOfLines:1];
    lblCompanyName.adjustsFontSizeToFitWidth=YES;
    [Coding Add_View:viewCell view:lblCompanyName x:self.screen_indent_x height:lblCompanyName.frame.size.height prev_frame:imgDeal.frame gap:(self.gap * 4)];
    
    NSString* neighborhood;
    if(merchant_obj.neighborhood_obj.neighborhood != nil)
        neighborhood = merchant_obj.neighborhood_obj.neighborhood;
    else
        neighborhood = merchant_obj.zip_code_obj.city_obj.city;
    
    GTLabel *lblNeighborhood = [Coding Create_Label:neighborhood width:(self.screen_width * .45) font:label_font mult:NO];
    [lblNeighborhood setNumberOfLines:1];
    lblNeighborhood.adjustsFontSizeToFitWidth=YES;
    [Coding Add_View:viewCell view:lblNeighborhood x:self.screen_indent_x height:lblNeighborhood.frame.size.height prev_frame:lblCompanyName.frame gap:(self.gap * .25)];
    
    NSString* distance = [deal_obj.distance stringValue];
    CGFloat distance_x = lblNeighborhood.frame.origin.x + [Utilities Get_Label_Width:lblNeighborhood];
    GTLabel* lblDistance =[Coding Create_Label:[NSString stringWithFormat: @"%@%@%@", @" - ", distance, @ "mi"] width:100 font:label_font mult:NO];
    [Coding Add_View:viewCell view:lblDistance x:distance_x height:lblDistance.frame.size.height prev_frame:lblCompanyName.frame gap:(self.gap * .25)];
    
    /* stars image */
    CGFloat stars_x = self.screen_width * .68;
    CGFloat stars_width = self.screen_width * .275;
    UIImageView *imgStars = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, stars_width, self.screen_height * .031)];
    imgStars.image = [UIImage imageNamed:merchant_obj.merchant_rating_obj.image];
    [Coding Add_View:viewCell view:imgStars x:stars_x height:imgStars.frame.size.height prev_frame:lblCompanyName.frame gap:(self.gap * .25)];

    GTLabel *lblDeal = [Coding Create_Label:deal_obj.deal width:self.screen_width font:label_font_medium mult:YES];
    [lblDeal setNumberOfLines:1];
    lblDeal.adjustsFontSizeToFitWidth=YES;
    [Coding Add_View:viewCell view:lblDeal x:self.screen_indent_x height:lblDeal.frame.size.height prev_frame:lblNeighborhood.frame gap:(self.gap * 1)];
    
    [cell.contentView addSubview:viewCell];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.screen_height * .66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Deal *deal_obj = [deal_obj_array objectAtIndex: indexPath.row];
    self.deal_controller.deal_obj = deal_obj;
    
    Deal_Detail* vc_deal_detail = [[Deal_Detail alloc]init];
    vc_deal_detail.deal_controller = self.deal_controller;
    vc_deal_detail.customer_controller = self.customer_controller;
    vc_deal_detail.system_controller = self.system_controller;
    vc_deal_detail.hidesBottomBarWhenPushed = YES;
    
    loading_dialog = NO;
    
    if(![self.navigationController.topViewController isKindOfClass:[Deal_Detail class]])
    {
        [self.navigationController pushViewController:vc_deal_detail animated:YES];
    }
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    if(deal_obj_array)
//    {
//        self.tabBarController.tabBar.hidden = YES;
//        
//        tblDeals.frame = self.view.bounds;
//    }
//}

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
//                 willDecelerate:(BOOL)decelerate
//{
//    if(!decelerate)
//            self.tabBarController.tabBar.hidden = NO;
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    self.tabBarController.tabBar.hidden = NO;
//}


/* public methods */
-(void)Create_Layout
{
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    tblDeals = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tblDeals.delegate = self;
    tblDeals.dataSource = self;
    tblDeals.backgroundColor = [UIColor clearColor];
    tblDeals.separatorColor = [UIColor clearColor];
    tblDeals.showsVerticalScrollIndicator = NO;
    
    /* refresh control */
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -30, 0, 0)];
    refreshControl.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:105.0/255.0 blue:180.0/255.0 alpha:1];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(Load_Deals) forControlEvents:UIControlEventValueChanged];
    
    tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = tblDeals;
    tableViewController.refreshControl = refreshControl;
    
    /* not sure why to set this, but tab bar will be over last cell */
    tableViewController.tableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0);
    
    [self.view addSubview:tblDeals];
    
    self.navigationController.navigationBar.translucent= NO; // Set transparency to no and
    
    self.tabBarController.tabBar.translucent= NO; //Set this property so that the tab bar will not be transparent
}

-(void)btnLocationServices_Click
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

-(void)btnSearchSettings_Click:(id)sender
{
    if ([sender isKindOfClass:[UIView class]])
    {
        [(UIView*)sender dismissPresentingPopup];
    }
    
    Search_Settings* vc_search_settings = [[Search_Settings alloc]init];
    vc_search_settings.deal_controller = self.deal_controller;
    vc_search_settings.customer_controller = self.customer_controller;
    vc_search_settings.system_controller = self.system_controller;
    vc_search_settings.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc_search_settings animated:YES];
}

-(void)btnClose_Click:(id)sender
{
    if ([sender isKindOfClass:[UIView class]])
    {
        [(UIView*)sender dismissPresentingPopup];
    }
    
    [self Get_Location];
}

-(void)Popup
{
    CGFloat popup_width = self.screen_width * .85;
    CGFloat popup_height = self.screen_height * .65;
    UIView* pop_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popup_width, popup_height)];
    pop_view.backgroundColor = [UIColor whiteColor];
    pop_view.layer.cornerRadius = 4.0;
    
    CGFloat message_width = popup_width - (self.screen_indent_x * 2);
    GTLabel *lblMessage = [Coding Create_Label:system_error_obj.message width:message_width font:label_font mult:YES];
    lblMessage.textAlignment = NSTextAlignmentCenter;
    [Coding Add_View:pop_view view:lblMessage x:self.screen_indent_x height:[Utilities Get_Height:lblMessage] prev_frame:CGRectNull gap:(self.gap * 7)];

    UIButton* btnLocationServices = [Coding Create_Link_Button:@"Turn on Location Services" font:link_button_font];
    [btnLocationServices addTarget:self action:@selector(btnLocationServices_Click) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:pop_view view:btnLocationServices x:self.screen_indent_x height:btnLocationServices.frame.size.height prev_frame:lblMessage.frame gap:(self.gap * 10)];
    
    UIButton* btnSearchSettings = [Coding Create_Link_Button:@"Update Search Settings" font:link_button_font];
    [btnSearchSettings addTarget:self action:@selector(btnSearchSettings_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:pop_view view:btnSearchSettings x:self.screen_indent_x height:btnSearchSettings.frame.size.height prev_frame:btnLocationServices.frame gap:(self.gap * 5)];
    
    CGFloat button_width = message_width;
    CGFloat button_x = self.screen_indent_x;
    ACPButton* btnClose = [Coding Create_Button:@"Got It!" font:button_font style:ACPButtonPink text_color:[UIColor darkGrayColor] width:button_width height:self.button_height];
    [btnClose addTarget:self action:@selector(btnClose_Click:) forControlEvents:UIControlEventTouchUpInside];
    [Coding Add_View:pop_view view:btnClose x:button_x height:btnClose.frame.size.height prev_frame:btnSearchSettings.frame gap:(self.gap * 10)];
    
    pop_view.frame =CGRectMake(0, 0, popup_width, popup_height);
    
    [pop_view addSubview:lblMessage];
    [pop_view addSubview:btnLocationServices];
    [pop_view addSubview:btnSearchSettings];
    
    KLCPopupLayout layout = KLCPopupLayoutMake((KLCPopupHorizontalLayout) 3,
                                               (KLCPopupVerticalLayout) 3);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:pop_view
                                            showType:(KLCPopupShowType)@"Fade in"
                                         dismissType:(KLCPopupDismissType)@"Slide to Bottom"
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
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
                                  
                                  [self Load_Deals];
                              }];
}

-(void)Load_Deals
{

    if(loading_dialog)
        [self Progress_Show:@"Loading Deals"];
    
    self.deal_controller.customer_id = self.customer_controller.customer_obj.customer_id;
    self.deal_controller.latitude = self.customer_controller.contact_gps_log_obj.latitude;
    self.deal_controller.longitude = self.customer_controller.contact_gps_log_obj.longitude;
    self.deal_controller.customer_obj = self.customer_controller.customer_obj;
    [self.deal_controller Get_Deals:^(void)
     {
         successful = self.deal_controller.successful;
         system_successful_obj = self.deal_controller.system_successful_obj;
         system_error_obj = self.deal_controller.system_error_obj;
         
         loading_dialog = YES;
         
         if(successful)
         {
             //[self Create_Layout];
             
             deal_obj_array = self.deal_controller.deal_obj_array;
             
             [tblDeals reloadData];
             if (deal_obj_array)
             {
                 tblDeals.backgroundView = nil;
             }
             else
             {
                 GTLabel *lblNoDeals = [Coding Create_Label:@"Sorry, there are no deals in your area\n\nPull down to refresh\n\n\n\n\n\n" width:20 font:label_font mult:YES];
                 lblNoDeals.frame = CGRectMake(self.screen_indent_x, self.screen_height/4, 20, lblNoDeals.frame.size.height);
                 [lblNoDeals setTextAlignment:NSTextAlignmentCenter];
                 tblDeals.backgroundView = lblNoDeals;
             }
         }
         else
         {
             if([system_error_obj.code  isEqual: @2026])
             {
                 [self Popup];
             }
             else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
         }
         
         if (tableViewController.refreshControl.refreshing)
         {
             [tableViewController.refreshControl endRefreshing];
         }
         
         [self Progress_Close];
         
         //self.tabBarController.tabBar.hidden = NO;
     }];
}



@end
