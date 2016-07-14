#import <UIKit/UIKit.h>
#import "Main_View.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (assign, nonatomic) CGRect currentStatusBarFrame;

@end

