#import "Account.h"
#import "Navigation_Controller.h"


@interface Account ()
{
    UITableView *tblAccount;
    NSMutableArray *dataArray;
}

@end


@implementation Account


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screen_title = @"ACCOUNT";
    self.left_button = @"";
    self.right_button = @"";
    
    [self Set_Controller_Properties];
    
    [self Create_Layout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //[self Load_Data];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    CGFloat cell_height = (self.screen_height/10);
    CGFloat arrow_width = self.screen_width/10;
    CGFloat arrow_x = self.screen_width * .9;
    CGFloat arrow_y = (cell_height/2) - (arrow_width/2);
    
    UILabel * myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.screen_indent_width, cell_height)];
    myLabel.tag = 111;
    if([cellValue isEqualToString:@"Log Out"])
    {
        myLabel.textAlignment= NSTextAlignmentCenter;
        myLabel.textColor = [UIColor redColor];
    }
    else
    {
        myLabel.frame = CGRectMake(self.screen_indent_x, 0, self.screen_indent_width, cell_height);
        
        UIImageView *imgArrow = [[UIImageView alloc]initWithFrame:CGRectMake(arrow_x, arrow_y, arrow_width, arrow_width)];
        imgArrow.image = [UIImage imageNamed:@"right_arrow.png"];
        [cell.contentView addSubview:imgArrow];
    }
    
    [myLabel setFont:label_font_medium];
    [cell.contentView addSubview:myLabel];
    
    myLabel = (UILabel*)[cell.contentView viewWithTag:111];
    myLabel.text = cellValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedCell = nil;
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    selectedCell = [array objectAtIndex:indexPath.row];
    
    NSLog(@"%@", selectedCell);
    
    if([selectedCell isEqualToString:@"Edit Profile"])
    {
        Customer_Edit* vc_customer_edit = [[Customer_Edit alloc]init];
        vc_customer_edit.deal_controller = self.deal_controller;
        vc_customer_edit.customer_controller = self.customer_controller;
        vc_customer_edit.system_controller = self.system_controller;
        vc_customer_edit.loaded = NO;
        vc_customer_edit.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc_customer_edit animated:YES];
    }
    else if([selectedCell isEqualToString:@"Credit Cards"])
    {
        Credit_Cards* vc_credit_cards = [[Credit_Cards alloc]init];
        vc_credit_cards.deal_controller = self.deal_controller;
        vc_credit_cards.customer_controller = self.customer_controller;
        vc_credit_cards.system_controller = self.system_controller;
        vc_credit_cards.hidesBottomBarWhenPushed = YES;
        vc_credit_cards.calling_view = [[self class] description];
        
        [self.navigationController pushViewController:vc_credit_cards animated:YES];
    }
    else if([selectedCell isEqualToString:@"Search Settings"])
    {
        Search_Settings* vc_search_settings = [[Search_Settings alloc]init];
        vc_search_settings.deal_controller = self.deal_controller;
        vc_search_settings.customer_controller = self.customer_controller;
        vc_search_settings.system_controller = self.system_controller;
        vc_search_settings.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc_search_settings animated:YES];
    }
    else if([selectedCell isEqualToString:@"Sign Up as a Merchant"])
    {
        Merchant_App* vc_merchant_app = [[Merchant_App alloc]init];
        vc_merchant_app.deal_controller = self.deal_controller;
        vc_merchant_app.customer_controller = self.customer_controller;
        vc_merchant_app.system_controller = self.system_controller;
        vc_merchant_app.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc_merchant_app animated:YES];
    }
    else if([selectedCell isEqualToString:@"Log Out"])
    {
        [self Log_Out];
    }

    [tblAccount deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.screen_height * .1;
}


/* private methods */
-(void)Create_Layout
{
    //Initialize the dataArray
    dataArray = [[NSMutableArray alloc] init];
    
    //First section data
    NSArray *firstItemsArray = [[NSArray alloc] initWithObjects:@"Edit Profile", @"Credit Cards", @"Search Settings", @"Sign Up as a Merchant", nil];
    NSDictionary *firstItemsArrayDict = [NSDictionary dictionaryWithObject:firstItemsArray forKey:@"data"];
    [dataArray addObject:firstItemsArrayDict];/*test*/
    
    //Second section data
    NSArray *secondItemsArray = [[NSArray alloc] initWithObjects:@"Log Out", nil];
    NSDictionary *secondItemsArrayDict = [NSDictionary dictionaryWithObject:secondItemsArray forKey:@"data"];
    [dataArray addObject:secondItemsArrayDict];
    
    tblAccount = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tblAccount.delegate = self;
    tblAccount.dataSource = self;
    tblAccount.backgroundColor = [UIColor clearColor];
    tblAccount.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tblAccount];
    
    self.navigationController.navigationBar.translucent= NO; // Set transparency to no and
    self.tabBarController.tabBar.translucent= NO; //Set this property so that the tab bar will not be transparent
}

-(void)Load_Data
{
    [self Progress_Show:@"Loading"];
    
    [self.customer_controller Get_Customer_Profile:^(void)
     {
         successful = self.customer_controller.successful;
         system_successful_obj = self.customer_controller.system_successful_obj;
         system_error_obj = self.customer_controller.system_error_obj;
         
         [self Progress_Close];
         
         if(!successful)
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:system_error_obj.message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
     }];
}

-(void)Log_Out
{
    [Utilities Clear_NSDefaults];
    
//    [SSKeychain deletePasswordForService:@"user_name" account:@"app"];
//    [SSKeychain deletePasswordForService:@"password" account:@"app"];
    
    Main_View *vc = [[Main_View alloc] init];
    
    Navigation_Controller *nc = [[Navigation_Controller alloc] initWithRootViewController:vc];
    nc.navigationBarHidden = YES;
    
    [self presentViewController:nc animated:YES completion:nil];
}

@end
