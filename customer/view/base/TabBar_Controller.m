#import "TabBar_Controller.h"
#import "Navigation_Controller.h"


@interface TabBar_Controller ()
{
    Deals* deals;
    Certificates* certificates;
    Promotions* promotions;
    Account* account;
}
@end


@implementation TabBar_Controller

@synthesize deal_controller;
@synthesize customer_controller;
@synthesize system_controller;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBar.translucent = NO;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(213/255.0) green:(15/255.0) blue:(37/255.0) alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //deal_create.loaded = NO;
    //deal_create.deal_controller.deal_obj=nil;
    
    return YES;
}

/* public methods */
-(void) Set_Properties
{
    deals = [[Deals alloc] init];
    deals.deal_controller = deal_controller;
    deals.customer_controller = customer_controller;
    deals.system_controller = system_controller;
    
    certificates = [[Certificates alloc] init];
    certificates.customer_controller = customer_controller;
    certificates.deal_controller = deal_controller;
    certificates.system_controller = system_controller;
    
    promotions = [[Promotions alloc] init];
    promotions.customer_controller = customer_controller;
    promotions.deal_controller = deal_controller;
    promotions.system_controller = system_controller;
    
    account = [[Account alloc] init];
    account.customer_controller = customer_controller;
    account.deal_controller = deal_controller;
    account.system_controller = system_controller;
    
    Navigation_Controller* navController0 = [[Navigation_Controller alloc] initWithRootViewController:deals];
    Navigation_Controller* navController1 = [[Navigation_Controller alloc] initWithRootViewController:certificates];
    Navigation_Controller* navController2 = [[Navigation_Controller alloc] initWithRootViewController:promotions];
    Navigation_Controller* navController3 = [[Navigation_Controller alloc] initWithRootViewController:account];
    
    NSArray* controllers = [NSArray arrayWithObjects:navController0, navController1, navController2, navController3, nil];
    self.viewControllers = controllers;
    self.tabBar.opaque = YES;
    self.tabBar.translucent = NO;
    
    UITabBar *tabBar = self.tabBar;
    UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:3];
    
    tabBarItem0.title = @"Deals";
    tabBarItem1.title = @"Certificates";
    tabBarItem2.title = @"Promotions";
    tabBarItem3.title = @"Account";
    
    [tabBarItem0 setImage:[[UIImage imageNamed:@"dollar_sign.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [tabBarItem1 setImage:[[UIImage imageNamed:@"certificate.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [tabBarItem2 setImage:[[UIImage imageNamed:@"promotion.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [tabBarItem3 setImage:[[UIImage imageNamed:@"profile.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
}

@end
