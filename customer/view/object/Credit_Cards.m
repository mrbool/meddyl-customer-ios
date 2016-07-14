#import "Credit_Cards.h"


@interface Credit_Cards ()
{
    UITableView *tblCards;
    GTLabel *lblNoCards;
    NSMutableArray *credit_card_obj_array;
    Credit_Card_Add *vc_credit_card_add;
}
@end


@implementation Credit_Cards

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screen_title = @"CREDIT CARDS";
    self.left_button = @"back";
    self.right_button = @"add";
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [self Set_Controller_Properties];
    
    [self Create_Layout];
    
    [self Load_Cards:@"Loading"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* not sure why need this code, but will lock up nav bar if not here */
    self.navigationController.navigationBar.topItem.leftBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.backBarButtonItem.enabled = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [credit_card_obj_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Credit_Card *credit_card_obj = credit_card_obj_array[indexPath.row];
    
    CGFloat cell_height = self.screen_height/9;
    
    UIView* viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.screen_width, cell_height)];
    viewCell.backgroundColor = [UIColor whiteColor];
    viewCell.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *imgCardType = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell_height, cell_height)];
    [imgCardType setImage:[UIImage imageNamed:credit_card_obj.credit_card_type_obj.image]];
    [Coding Add_View:viewCell view:imgCardType x:self.screen_indent_x height:imgCardType.frame.size.height prev_frame:CGRectNull gap:0];
  
    GTLabel* lblCardNumber = [Coding Create_Label:[Utilities Format_Credit_Card:credit_card_obj.card_number] width:(self.screen_width * .625) font:label_font mult:NO];
    [Coding Add_View:viewCell view:lblCardNumber x:(self.screen_width * .25) height:[Utilities Get_Height:lblCardNumber] prev_frame:CGRectNull gap:(self.gap * 2)];
    
    GTLabel* lblExpiration = [Coding Create_Label:[Utilities Format_Credit_Card_Expiration:credit_card_obj.expiration_date] width:(self.screen_width * .625) font:label_font mult:NO];
    [Coding Add_View:viewCell view:lblExpiration x:(self.screen_width * .25) height:[Utilities Get_Height:lblExpiration] prev_frame:lblCardNumber.frame gap:0];

    CGFloat check_y = cell_height/4;
    if([credit_card_obj.default_flag  isEqual: @1])
    {
        UIImageView *imgDefault = [[UIImageView alloc]initWithFrame:CGRectMake((self.screen_width * .75), check_y, (self.screen_width * .065), (self.screen_width * .065))];
        [imgDefault setImage:[UIImage imageNamed:@"green_check.png"]];
        [viewCell addSubview:imgDefault];
    }
    [viewCell addSubview:imgCardType];

    [cell.contentView addSubview:viewCell];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.screen_height * .11;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Credit_Card *credit_card_obj = [credit_card_obj_array objectAtIndex: indexPath.row];
    self.customer_controller.credit_card_obj = credit_card_obj;
    
    [self Progress_Show:@"Setting Default"];
    
    [self.customer_controller Set_Default_Credit_Card:^(void)
     {
         successful = self.customer_controller.successful;
         system_successful_obj = self.customer_controller.system_successful_obj;
         system_error_obj = self.customer_controller.system_error_obj;
         
         [self Load_Cards:@"Setting Default"];
         
         [self Progress_Close];
         
         if([self.screen_type isEqualToString:@"present"])
         {
             [self.view endEditing:YES];
             [self.navigationController popToRootViewControllerAnimated:TRUE];
         }
     }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Credit_Card *credit_card_obj = [credit_card_obj_array objectAtIndex: indexPath.row];
        self.customer_controller.credit_card_obj = credit_card_obj;
        
        [self Progress_Show:@"Deleting"];
        
        [self.customer_controller Delete_Credit_Card:^(void)
         {
             successful = self.customer_controller.successful;
             system_successful_obj = self.customer_controller.system_successful_obj;
             system_error_obj = self.customer_controller.system_error_obj;
             
             [self Load_Cards:@"Deleting"];
             
             [self Progress_Close];
         }];
    }
}

/* public methods */
-(void)Create_Layout
{
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIFont* font_no_cards = [UIFont fontWithName:@"Palatino-Italic" size:(self.label_font_height * 1.25)];

    lblNoCards = [Coding Create_Label:@"You have no cards on file" width:self.screen_width font:font_no_cards mult:NO];
    lblNoCards.frame = CGRectMake(0, self.screen_height/3, lblNoCards.frame.size.width, lblNoCards.frame.size.height);
    lblNoCards.hidden = YES;
    [lblNoCards setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblNoCards];
    
    tblCards = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tblCards.delegate = self;
    tblCards.dataSource = self;
    tblCards.backgroundColor = [UIColor clearColor];
    //tblCards.separatorColor = [UIColor clearColor];
    tblCards.showsVerticalScrollIndicator = NO;
    tblCards.allowsMultipleSelectionDuringEditing = NO;
    tblCards.tableFooterView = [UIView new];
    
    [self.view addSubview:tblCards];
    
    self.navigationController.navigationBar.translucent= NO; // Set transparency to no and
    
    self.tabBarController.tabBar.translucent= NO; //Set this property so that the tab bar will not be transparent
}

-(void)Load_Cards:(NSString*)progress_text
{
    [self Progress_Show:progress_text];
    
    [self.customer_controller Get_Credit_Cards:^(void)
     {
         successful = self.customer_controller.successful;
         system_successful_obj = self.customer_controller.system_successful_obj;
         system_error_obj = self.customer_controller.system_error_obj;
         
         credit_card_obj_array = self.customer_controller.credit_card_obj_array;
         
         if (credit_card_obj_array)
         {
             lblNoCards.hidden = YES;
             tblCards.hidden = NO;
             
             [tblCards reloadData];
         }
         else
         {
             lblNoCards.hidden = NO;
             tblCards.hidden = YES;
         }

         [self Progress_Close];
     }];
}

-(void)Add_Click
{
    if(vc_credit_card_add == nil)
    {
        vc_credit_card_add = [[Credit_Card_Add alloc]init];
    }
    vc_credit_card_add.deal_controller = self.deal_controller;
    vc_credit_card_add.customer_controller = self.customer_controller;
    vc_credit_card_add.system_controller = self.system_controller;
    vc_credit_card_add.hidesBottomBarWhenPushed = YES;
    vc_credit_card_add.screen_type = @"push";
    vc_credit_card_add.left_button = @"back";
    
    if([self.calling_view isEqualToString:@"Deal_Purchase"])
        vc_credit_card_add.pop_to_root = YES;
    else
        vc_credit_card_add.pop_to_root = NO;
        
    [self.navigationController pushViewController:vc_credit_card_add animated:YES];
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)Close_Click
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
