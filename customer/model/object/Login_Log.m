#import "Login_Log.h"
#import "Application_Type.h"
#import "Contact.h"
#import "Customer.h"
#import "Merchant_Contact.h"

@implementation Login_Log

@synthesize log_id;
@synthesize contact_id;
@synthesize customer_id;
@synthesize merchant_contact_id;
@synthesize application_type_id;
@synthesize registered;
@synthesize auto_login;
@synthesize ip_address;
@synthesize login_date_utc_stamp;
@synthesize auth_token;
@synthesize application_type_obj;
@synthesize contact_obj;
@synthesize customer_obj;
@synthesize merchant_contact_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"application_type_obj" : [Application_Type class],
		@"contact_obj" : [Contact class],
		@"customer_obj" : [Customer class],
		@"merchant_contact_obj" : [Merchant_Contact class]
		};
}

@end
