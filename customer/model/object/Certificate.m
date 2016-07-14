#import "Certificate.h"
#import "Certificate_Status.h"
#import "Customer.h"
#import "Deal.h"
#import "Application_Type.h"
#import "Login_Log.h"

@implementation Certificate

@synthesize certificate_id;
@synthesize deal_id;
@synthesize customer_id;
@synthesize status_id;
@synthesize certificate_code;
@synthesize assigned_date;
@synthesize start_date;
@synthesize expiration_date;
@synthesize redeemed_date;
@synthesize amount;
@synthesize entry_date_utc_stamp;
@synthesize certificate_status_obj;
@synthesize customer_obj;
@synthesize deal_obj;
@synthesize status_text_1;
@synthesize status_text_2;
@synthesize search;
@synthesize application_type_obj;
@synthesize login_log_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"certificate_status_obj" : [Certificate_Status class],
		@"customer_obj" : [Customer class],
		@"deal_obj" : [Deal class],
		@"application_type_obj" : [Application_Type class],
		@"login_log_obj" : [Login_Log class]
		};
}

@end
