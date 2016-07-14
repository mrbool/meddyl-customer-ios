#import "Terms_Of_Service.h"


@interface Terms_Of_Service ()

@end


@implementation Terms_Of_Service

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.screen_title = @"TERMS OF SERVICE";
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


/* private methods */
-(void)Create_Layout
{
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.screen_width, self.screen_height)];
    NSString *url=self.system_controller.system_settings_obj.customer_app_terms;
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webview loadRequest:nsrequest];
    [self.view addSubview:webview];
}

-(void)Back_Click
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
