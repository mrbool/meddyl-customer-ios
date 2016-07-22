#import "View_Controller.h"


@interface View_Controller ()

@end


@implementation View_Controller

@synthesize deal_controller;
@synthesize customer_controller;
@synthesize system_controller;

@synthesize cancel;
@synthesize calling_view;
@synthesize debug;
@synthesize edited;
@synthesize keyboard_y_coordinate;
@synthesize left_button;
@synthesize loaded;
@synthesize move_keyboard_up;
@synthesize original_center;
@synthesize right_button;
@synthesize screen_up_y;
@synthesize screen_title;
@synthesize screen_type;
@synthesize screen_bounds;
@synthesize screen_size;
@synthesize screen_width;
@synthesize screen_height;
@synthesize screen_x;
@synthesize screen_y;
@synthesize screen_indent_x;
@synthesize screen_indent_x_right;
@synthesize screen_indent_width;
@synthesize screen_indent_width_half;
@synthesize text_field_height;
@synthesize text_field_font_height;
@synthesize button_height;
@synthesize button_font_height;
@synthesize link_button_font_height;
@synthesize label_font_height;
@synthesize gap;


/* form events */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self Set_Background];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screen_bounds = [[UIScreen mainScreen] bounds];
    screen_size = screen_bounds.size;
    screen_width = screen_size.width;
    screen_height = screen_size.height;
    screen_x = 0;
    screen_y = 0;
    screen_indent_x = screen_width/40;
    screen_indent_x_right = (self.screen_width/2) + (self.screen_indent_x * .5);
    screen_indent_width = screen_width - (screen_indent_x * 2);
    screen_indent_width_half = (self.screen_width/2) - (self.screen_indent_x * 1.5);
    text_field_height = screen_size.height/16;
    text_field_font_height = screen_size.height/32;
    button_height = screen_size.height/12;
    button_font_height = screen_size.height/24;
    link_button_font_height = screen_size.height/32;
    label_font_height = screen_size.height/32;
    gap = screen_height/142;
    
    text_field_font = [UIFont fontWithName:@"Avenir Next" size:self.text_field_font_height];
    label_font_xsmall = [UIFont fontWithName:@"Avenir Next" size:self.label_font_height * .75];
    label_font = [UIFont fontWithName:@"Avenir Next" size:self.label_font_height];
    label_font_medium = [UIFont fontWithName:@"Avenir Next" size:self.label_font_height * 1.25];
    label_font_large = [UIFont fontWithName:@"Avenir Next" size:self.label_font_height * 1.5];
    label_font_medium_medium = [UIFont fontWithName:@"Avenir-Medium" size:self.label_font_height * 1.5];
    button_font = [UIFont fontWithName:@"Avenir Next" size:self.button_font_height];
    button_font_small = [UIFont fontWithName:@"Avenir Next" size:self.button_font_height * .8];
    link_button_font = [UIFont fontWithName:@"Avenir Next" size:self.link_button_font_height];
    link_button_font_large = [UIFont fontWithName:@"Avenir Next" size:self.link_button_font_height * 1.25];

    if(scrollView ==  nil)
    {
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height)];
        contentView.backgroundColor = [UIColor clearColor];
    }
    
    if(deal_controller == nil)
    {
        deal_controller = [[Deal_Controller alloc]init];
    }
    
    if(customer_controller == nil)
    {
        customer_controller = [[Customer_Controller alloc]init];
    }
    
    if(system_controller == nil)
    {
        system_controller = [[System_Controller alloc]init];
    }
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    /* this is to check if the in-call status bar changes */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusFrameChanged:)
                                                 name:UIApplicationWillChangeStatusBarFrameNotification
                                               object:nil];
    cancel = NO;
    debug = NO;
    loaded = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)statusFrameChanged:(NSNotification*)note
{

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    move_keyboard_up = false;
    original_center = contentView.center;
    screen_up_y = original_center.y;
}



//- (void)keyboardWillShow:(NSNotification *)aNotification
//{
//    [self keyboardWillHide:aNotification];
//    
//    // the keyboard is showing so resize the table's height
//    NSTimeInterval animationDuration =
//    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    CGRect frame = self.view.frame;
//    frame.origin.y -= keyboard_y_coordinate;
//    
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    self.view.frame = frame;
//    [UIView commitAnimations];
//}

//- (void)keyboardWillHide:(NSNotification *)aNotification
//{
//    NSInteger y;
//
//    if(self.navigationController.navigationBarHidden)
//    {
//        y = 0;
//    }
//    else
//    {
//        y=64;
//    }
//
//    // the keyboard is hiding reset the table's height
//    NSTimeInterval animationDuration =
//    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//    CGRect frame = self.view.frame;
//    //frame.origin.y += keyboard_y_coordinate;
//    frame.origin.y = y;
//
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//
//    self.view.frame = frame;
//    [UIView commitAnimations];
//}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (self.keyboardIsShown)
    {
        return;
    }
    
    if(move_keyboard_up)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        contentView.center = CGPointMake(original_center.x, screen_up_y);
        [UIView commitAnimations];
    }
    
    
//    NSDictionary* userInfo = [n userInfo];
//    
//    // get the size of the keyboard
//    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    // resize the noteView
//    CGRect viewFrame = contentView.frame;
//    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
//    //viewFrame.size.height -= (keyboardSize.height - 20);
//    viewFrame.size.height = (keyboardSize.height - 40);
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [contentView setFrame:viewFrame];
//    [scrollView setFrame:contentView.frame];
//    [UIView commitAnimations];
//    
//    self.keyboardIsShown = YES;
}

- (void)keyboardWillHide:(NSNotification *)n
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    contentView.center = CGPointMake(original_center.x, original_center.y);
    [UIView commitAnimations];
    
    
//    //NSDictionary* userInfo = [n userInfo];
//    
//    // get the size of the keyboard
//    //CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    // resize the scrollview
//    CGRect viewFrame = contentView.frame;
//    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
//    //    viewFrame.size.height += (keyboardSize.height - 50);
//    viewFrame.size.height = self.screen_height;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [contentView setFrame:viewFrame];
//    [UIView commitAnimations];
//    
//    self.keyboardIsShown = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


/* public methods */
-(CGFloat)Get_Scroll_Height: (CGRect)last_frame scroll_lag:(CGFloat)scroll_lag
{
    CGFloat scroll_height;
    
    if(screen_height > last_frame.origin.y + last_frame.size.height + scroll_lag)
        scroll_height = self.screen_height + 5;
    else
        scroll_height = last_frame.origin.y + last_frame.size.height + scroll_lag + 90;
    
    return scroll_height;
}

-(void) Set_Controller_Properties
{
    UIFont *font_label = [UIFont fontWithName:@"Avenir Next" size:20];
    UIFont *font_navigation = [UIFont fontWithName:@"Avenir Next" size:15];
    
    if([screen_title isEqualToString:@"Main"])
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    else
    {
        [self setTitle:screen_title];
        
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor blackColor], NSForegroundColorAttributeName,
          font_label, NSFontAttributeName,nil]];
        
        self.navigationController.navigationBar.translucent = NO;

        if([left_button isEqual: @"back"])
        {
            UIImage *imgBack = [UIImage imageNamed:@"arrow_back.png"];
            CGRect frmBack = CGRectMake(0, 0, 26, 26);
            UIButton* btnBack = [[UIButton alloc] initWithFrame:frmBack];
            [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
            [btnBack setShowsTouchWhenHighlighted:YES];
            [btnBack addTarget:self action:@selector(Back_Click) forControlEvents:UIControlEventTouchDown];
            UIBarButtonItem* bbnBack = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
            
            [self.navigationItem setLeftBarButtonItem:bbnBack];
        }
        else if ([left_button isEqual: @"cancel"])
        {
            UIBarButtonItem *bbnCancel = [[UIBarButtonItem alloc]
                                        initWithTitle:@"CANCEL"
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(Cancel_Click)];
            [bbnCancel setTitleTextAttributes:@{NSFontAttributeName:font_navigation} forState:UIControlStateNormal];
            bbnCancel.tintColor = [UIColor blackColor];
            
            [self.navigationItem setLeftBarButtonItem:bbnCancel];
        }
        else if ([left_button isEqual: @"later"])
        {
            UIBarButtonItem *bbnCancel = [[UIBarButtonItem alloc]
                                          initWithTitle:@"LATER"
                                          style:UIBarButtonItemStylePlain
                                          target:self
                                          action:@selector(Cancel_Click)];
            [bbnCancel setTitleTextAttributes:@{NSFontAttributeName:font_navigation} forState:UIControlStateNormal];
            bbnCancel.tintColor = [UIColor blackColor];
            
            [self.navigationItem setLeftBarButtonItem:bbnCancel];
        }
        else if ([left_button isEqual: @"close"])
        {
            UIBarButtonItem *bbnCancel = [[UIBarButtonItem alloc]
                                          initWithTitle:@"CLOSE"
                                          style:UIBarButtonItemStylePlain
                                          target:self
                                          action:@selector(Close_Click)];
            [bbnCancel setTitleTextAttributes:@{NSFontAttributeName:font_navigation} forState:UIControlStateNormal];
            bbnCancel.tintColor = [UIColor blackColor];
            
            [self.navigationItem setLeftBarButtonItem:bbnCancel];
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        if([right_button isEqual: @"add"])
        {
            UIBarButtonItem *bbnAdd = [[UIBarButtonItem alloc]
                                       initWithTitle:@"ADD"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(Add_Click)];
            [bbnAdd setTitleTextAttributes:@{NSFontAttributeName:font_navigation} forState:UIControlStateNormal];
            bbnAdd.tintColor = [UIColor blackColor];
            
            [self.navigationItem setRightBarButtonItem:bbnAdd];
        }
        else if([right_button isEqual: @"save"])
        {
            UIBarButtonItem *bbnAdd = [[UIBarButtonItem alloc]
                                       initWithTitle:@"SAVE"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(Save_Click)];
            [bbnAdd setTitleTextAttributes:@{NSFontAttributeName:font_navigation} forState:UIControlStateNormal];
            bbnAdd.tintColor = [UIColor blackColor];
            
            [self.navigationItem setRightBarButtonItem:bbnAdd];
        }
        else if([right_button isEqual: @"next"])
        {
            UIBarButtonItem *bbnNext = [[UIBarButtonItem alloc]
                                           initWithTitle:@"NEXT"
                                           style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(Next_Click)];
            [bbnNext setTitleTextAttributes:@{NSFontAttributeName:font_navigation} forState:UIControlStateNormal];
            bbnNext.tintColor = [UIColor blackColor];
            
            self.navigationItem.rightBarButtonItem = bbnNext;
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
}

-(void) Set_Background
{
    UIColor *topColor = [UIColor colorWithRed:255.0/255.0 green:243.0/255.0 blue:249.0/255.0 alpha:1];
  //  UIColor *bottomColor = [UIColor colorWithRed:231.0/255.0 green:84.0/255.0 blue:128.0/255.0 alpha:1];
    UIColor *bottomColor = [UIColor colorWithRed:255.0/255.0 green:105.0/255.0 blue:180.0/255.0 alpha:1];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    gradientLayer.frame = self.view.bounds;

    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}

-(void)Add_View: (CGFloat)width height:(CGFloat)height background_color:(UIColor*)background_color
{
    contentView.backgroundColor = background_color;
    
    /* add views to content and scroll view */
    scrollView.contentSize = CGSizeMake(width, height);
    [self.view addSubview:scrollView];
    
    contentView.frame = CGRectMake(0, 0, width, height);
    [scrollView addSubview:contentView];
}

-(void)Progress_Show:(NSString *)status
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    self.navigationController.navigationBar.topItem.leftBarButtonItem.enabled = NO;
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = NO;
    self.navigationController.navigationBar.topItem.backBarButtonItem.enabled = NO;
    
//    contentView.userInteractionEnabled = NO;
//    scrollView.scrollEnabled = NO;
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:status];
}

-(void)Progress_Close
{
    [SVProgressHUD dismiss];
    
    //    contentView.userInteractionEnabled = YES;
    //    scrollView.scrollEnabled = YES;
    
    self.navigationController.navigationBar.topItem.leftBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.backBarButtonItem.enabled = YES;
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void)Progress_Close_No_Keyboard
{
    [SVProgressHUD dismiss];
    
    //    contentView.userInteractionEnabled = YES;
    //    scrollView.scrollEnabled = YES;
    
    self.navigationController.navigationBar.topItem.leftBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.rightBarButtonItem.enabled = YES;
    self.navigationController.navigationBar.topItem.backBarButtonItem.enabled = YES;
}

-(void)Back_Click
{
    
}

-(void) Next_Click
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.view endEditing:YES];
}

-(void) Cancel_Click
{
    
}

-(void) Add_Click
{
    
}

-(void) Save_Click
{
    
}

-(void) Close_Click
{
    
}

@end
