#import "Merchant_Contact.h"
#import "Contact.h"
#import "Merchant.h"
#import "Merchant_Contact_Status.h"
#import "Merchant_Contact_Validation.h"
#import "Login_Log.h"

@implementation Merchant_Contact

@synthesize merchant_contact_id;
@synthesize merchant_id;
@synthesize contact_id;
@synthesize status_id;
@synthesize validation_id;
@synthesize title;
@synthesize accept_terms_date_utc_stamp;
@synthesize entry_date_utc_stamp;
@synthesize contact_obj;
@synthesize merchant_obj;
@synthesize merchant_contact_status_obj;
@synthesize merchant_contact_validation_obj;
@synthesize search;
@synthesize login_log_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"contact_obj" : [Contact class],
		@"merchant_obj" : [Merchant class],
		@"merchant_contact_status_obj" : [Merchant_Contact_Status class],
		@"merchant_contact_validation_obj" : [Merchant_Contact_Validation class],
		@"login_log_obj" : [Login_Log class]
		};
}

@end
