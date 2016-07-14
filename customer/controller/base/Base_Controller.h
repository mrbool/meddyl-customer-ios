#import <Foundation/Foundation.h>
#import "Application_Type.h"
#import "Login_Log.h"
#import "Utilities.h"


@interface Base_Controller : NSObject
{
    NSString *customer_service;
}

@property BOOL successful;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) Application_Type *application_type_obj;
@property (nonatomic, strong) Login_Log *login_log_obj;

@end
