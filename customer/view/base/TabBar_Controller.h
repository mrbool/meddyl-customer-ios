#import <UIKit/UIKit.h>

#import "Deals.h"
#import "Certificates.h"
#import "Promotions.h"
#import "Account.h"


@interface TabBar_Controller : UITabBarController <UITabBarControllerDelegate>

@property (strong, nonatomic) Deal_Controller *deal_controller;
@property (strong, nonatomic) Customer_Controller *customer_controller;
@property (strong, nonatomic) System_Controller *system_controller;

-(void) Set_Properties;

@end
