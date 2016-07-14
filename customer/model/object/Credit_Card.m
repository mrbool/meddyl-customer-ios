#import "Credit_Card.h"
#import "Credit_Card_Type.h"
#import "Customer.h"
#import "Merchant_Contact.h"
#import "Application_Type.h"
#import "Login_Log.h"

@implementation Credit_Card

@synthesize credit_card_id;
@synthesize type_id;
@synthesize merchant_contact_id;
@synthesize customer_id;
@synthesize card_holder_name;
@synthesize card_number;
@synthesize card_number_encrypted;
@synthesize expiration_date;
@synthesize billing_zip_code;
@synthesize entry_date_utc_stamp;
@synthesize default_flag;
@synthesize deleted;
@synthesize credit_card_type_obj;
@synthesize customer_obj;
@synthesize merchant_contact_obj;
@synthesize application_type_obj;
@synthesize login_log_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"credit_card_type_obj" : [Credit_Card_Type class],
		@"customer_obj" : [Customer class],
		@"merchant_contact_obj" : [Merchant_Contact class],
		@"application_type_obj" : [Application_Type class],
		@"login_log_obj" : [Login_Log class]
		};
}

@end
