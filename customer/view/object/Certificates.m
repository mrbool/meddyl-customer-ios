#import "Certificates.h"


@interface Certificates ()
{
    UISegmentedControl *segCertificates;
    UITableView *tblCertificates;
    UITableViewController *tableViewController;
    
    NSMutableArray *certificate_obj_array_active;
    NSMutableArray *certificate_obj_array_all;
}
@end


@implementation Certificates

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.screen_title = @"CERTIFICATES";
    self.left_button = @"";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
    
    [self Create_Layout];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(![self.calling_view  isEqual: @"Certificate_Detail"])
    {
        [tblCertificates setHidden:YES];
        segCertificates.selectedSegmentIndex = 0;
        [self Load_Active_Certificates];
    }
    
    self.calling_view = @"";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(segCertificates.selectedSegmentIndex==0)
    {
        return [certificate_obj_array_active count];
    }
    else if (segCertificates.selectedSegmentIndex==1)
    {
        return [certificate_obj_array_all count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Certificate* certificate_obj;
    if(segCertificates.selectedSegmentIndex==0)
    {
        certificate_obj = [certificate_obj_array_active objectAtIndex: indexPath.row];
    }
    else
    {
        certificate_obj = [certificate_obj_array_all objectAtIndex: indexPath.row];
    }
    
    Deal* deal_obj = certificate_obj.deal_obj;
    
    CGFloat view_height = self.screen_height * .165;
    UIView* viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_width, view_height)];
    viewCell.backgroundColor = [UIColor whiteColor];
    viewCell.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat image_y;
    CGFloat image_width;
    CGFloat image_height;
    image_height = view_height * .8;
    image_width = image_height * 1.3;
    image_y = (view_height - image_height)/2;
    
    UIImageView *imvDeal = [[UIImageView alloc]initWithFrame:CGRectMake(self.screen_indent_x, image_y, image_width, image_height)];
    [imvDeal sd_setImageWithURL:[NSURL URLWithString:deal_obj.image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [viewCell addSubview:imvDeal];
    
    CGFloat label_x = imvDeal.frame.origin.x + imvDeal.frame.size.width + (self.gap * 2);
    CGFloat label_width = self.screen_width - label_x - self.gap;
    
    GTLabel *lblCompanyName = [Coding Create_Label:certificate_obj.deal_obj.merchant_contact_obj.merchant_obj.company_name width:label_width font:label_font mult:NO];
    [Coding Add_View:viewCell view:lblCompanyName x:label_x height:lblCompanyName.frame.size.height prev_frame:CGRectNull gap:(self.gap * 1.25)];
    
    GTLabel *lblDeal = [Coding Create_Label:deal_obj.deal width:label_width font:label_font mult:NO];
    [Coding Add_View:viewCell view:lblDeal x:label_x height:lblDeal.frame.size.height prev_frame:lblCompanyName.frame gap:(self.gap * 1.25)];
    
    /* set expiration date */
    NSString *time_zone = deal_obj.time_zone_obj.abbreviation;
    NSDate * expiration_date = certificate_obj.expiration_date;
    NSDate * redeemed_date = certificate_obj.redeemed_date;
    NSDateFormatter *date_format = [[NSDateFormatter alloc] init];
    [date_format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:time_zone]];
    [date_format setDateFormat:@"M/d/yyyy"];
    
    GTLabel *lblExpirationDate = [Coding Create_Label:[NSString stringWithFormat: @"%@%@", @"Expires on ", [date_format stringFromDate:expiration_date]] width:label_width font:label_font_xsmall mult:YES];
    [Coding Add_View:viewCell view:lblExpirationDate x:label_x height:lblExpirationDate.frame.size.height prev_frame:lblDeal.frame gap:(self.gap * 1.25)];
    
    if([certificate_obj.certificate_status_obj.status isEqualToString:@"Redeemed"])
    {
        viewCell.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
        lblExpirationDate.text = [NSString stringWithFormat: @"%@%@", @"Redeemed on ", [date_format stringFromDate:redeemed_date]];
    }
    else
    {
        
    }
    
    [cell.contentView addSubview:viewCell];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.screen_height * .175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Certificate *certificate_obj;
    if(segCertificates.selectedSegmentIndex==0)
    {
        certificate_obj = [certificate_obj_array_active objectAtIndex: indexPath.row];
    }
    else
    {
        certificate_obj = [certificate_obj_array_all objectAtIndex: indexPath.row];
    }
    
    self.deal_controller.certificate_obj = certificate_obj;
    
    self.calling_view = @"Certificate_Detail";
    
    Certificate_Detail* vc_certificate_detail = [[Certificate_Detail alloc]init];
    vc_certificate_detail.deal_controller = self.deal_controller;
    vc_certificate_detail.customer_controller = self.customer_controller;
    vc_certificate_detail.system_controller = self.system_controller;
    vc_certificate_detail.hidesBottomBarWhenPushed = YES;
    
    if(![self.navigationController.topViewController isKindOfClass:[Certificate_Detail class]])
    {
        [self.navigationController pushViewController:vc_certificate_detail animated:YES];
    }
}

/* public methods */
-(void)Create_Layout
{
    CGFloat segmented_width = self.screen_width * .66;
    CGFloat segmented_height = self.screen_height * .05;
    CGFloat segmented_x = (self.screen_width - segmented_width)/2;
    CGFloat segmented_y = self.gap * 2;
    NSArray *segmented_items = [NSArray arrayWithObjects: @"Active", @"All", nil];
    segCertificates = [[UISegmentedControl alloc] initWithItems:segmented_items];
    [segCertificates setFrame:CGRectMake(segmented_x, segmented_y, segmented_width, segmented_height)];
    [segCertificates addTarget:self action:@selector(segCertificates_Click:) forControlEvents: UIControlEventValueChanged];
    segCertificates.selectedSegmentIndex = 0;
    segCertificates.tintColor = [UIColor colorWithRed:(213/255.0) green:(15/255.0) blue:(37/255.0) alpha:1];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                label_font, NSFontAttributeName,
                                [UIColor redColor], NSForegroundColorAttributeName, nil];
    [segCertificates setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.view addSubview:segCertificates];
    
    CGFloat table_y = segCertificates.frame.origin.y + segCertificates.frame.size.height + (self.gap * 2);
    tblCertificates = [[UITableView alloc] initWithFrame:CGRectMake(0, table_y, self.screen_width, self.screen_height-table_y) style:UITableViewStylePlain];
    tblCertificates.delegate = self;
    tblCertificates.dataSource = self;
    tblCertificates.backgroundColor = [UIColor clearColor];
    tblCertificates.separatorColor = [UIColor clearColor];
    tblCertificates.showsVerticalScrollIndicator = NO;
    
    /* refresh control */
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -30, 0, 0)];
    refreshControl.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:105.0/255.0 blue:180.0/255.0 alpha:1];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(Refresh) forControlEvents:UIControlEventValueChanged];
    
    tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = tblCertificates;
    tableViewController.refreshControl = refreshControl;
    
    /* not sure why to set this, but tab bar will be over last cell */
    tableViewController.tableView.contentInset = UIEdgeInsetsMake(0, 0, 130, 0);
    
    [self.view addSubview:tblCertificates];
    
    self.navigationController.navigationBar.translucent= NO; // Set transparency to no and
    
    self.tabBarController.tabBar.translucent= NO; //Set this property so that the tab bar will not be transparent
}

-(void)Refresh
{
    if(segCertificates.selectedSegmentIndex==0)
    {
        [self Load_Active_Certificates];
    }
    else
    {
        [self Load_All_Certificates];
    }
}

-(void)Load_Active_Certificates
{
    tblCertificates.backgroundView = nil;
    
    [self Progress_Show:@"Loading Certificates"];
    
    self.deal_controller.customer_obj = self.customer_controller.customer_obj;
    [self.deal_controller Get_Customer_Active_Certificates:^(void)
     {
         successful = self.deal_controller.successful;
         system_successful_obj = self.deal_controller.system_successful_obj;
         system_error_obj = self.deal_controller.system_error_obj;
         
         if(successful)
         {
             certificate_obj_array_active = self.deal_controller.certificate_obj_array;
             
             [tblCertificates reloadData];
             [tblCertificates setHidden:NO];
             if (certificate_obj_array_active)
             {
                 tblCertificates.backgroundView = nil;
             }
             else
             {
                 UIView* vwNoRecords = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height)];
                 GTLabel *lblNoCertificates = [Coding Create_Label:@"You have no Active Certificates" width:self.screen_indent_width font:label_font mult:YES];
                 lblNoCertificates.frame = CGRectMake(self.screen_indent_x, self.screen_height * .2, self.screen_indent_width, [Utilities Get_Height:lblNoCertificates]);
                 lblNoCertificates.textAlignment = NSTextAlignmentCenter;
                 [vwNoRecords addSubview:lblNoCertificates];
                 
                 tblCertificates.backgroundView = vwNoRecords;
             }
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
         
         if (tableViewController.refreshControl.refreshing)
         {
             [tableViewController.refreshControl endRefreshing];
         }
         
         [self Progress_Close];
     }];
}


-(void)Load_All_Certificates
{
    tblCertificates.backgroundView = nil;
    
    [self Progress_Show:@"Loading Certificates"];
    
    self.deal_controller.customer_obj = self.customer_controller.customer_obj;
    [self.deal_controller Get_Customer_Certificates:^(void)
     {
         successful = self.deal_controller.successful;
         system_successful_obj = self.deal_controller.system_successful_obj;
         system_error_obj = self.deal_controller.system_error_obj;
         
         if(successful)
         {
             certificate_obj_array_all = self.deal_controller.certificate_obj_array;
             
             [tblCertificates reloadData];
             [tblCertificates setHidden:NO];
             if (certificate_obj_array_all)
             {
                 tblCertificates.backgroundView = nil;
             }
             else
             {
                 UIView* vwNoRecords = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height)];
                 GTLabel *lblNoCertificates = [Coding Create_Label:@"You have no Certificates" width:self.screen_indent_width font:label_font mult:NO];
                 lblNoCertificates.frame = CGRectMake(self.screen_indent_x, self.screen_height * .2, self.screen_indent_width, [Utilities Get_Height:lblNoCertificates]);
                 lblNoCertificates.textAlignment = NSTextAlignmentCenter;
                 [vwNoRecords addSubview:lblNoCertificates];
                 
                 tblCertificates.backgroundView = vwNoRecords;
             }
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
         
         if (tableViewController.refreshControl.refreshing)
         {
             [tableViewController.refreshControl endRefreshing];
         }
         
         [self Progress_Close];
     }];
}

-(void)segCertificates_Click:(id)sender
{
    switch (segCertificates.selectedSegmentIndex)
    {
        case 0:
            [self Load_Active_Certificates];
            break;
        case 1:
            [self Load_All_Certificates];
        default:
            break;
    }
}

@end
