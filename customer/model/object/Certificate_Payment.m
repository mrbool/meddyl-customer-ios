#import "Certificate_Payment.h"
#import "Certificate.h"
#import "Credit_Card.h"
#import "Promotion_Activity.h"
#import "Application_Type.h"
#import "Login_Log.h"

@implementation Certificate_Payment

@synthesize payment_id;
@synthesize certificate_id;
@synthesize credit_card_id;
@synthesize promotion_activity_id;
@synthesize card_holder_name;
@synthesize card_number;
@synthesize card_number_encrypted;
@synthesize card_expiration_date;
@synthesize payment_amount;
@synthesize payment_date_utc_stamp;
@synthesize certificate_obj;
@synthesize credit_card_obj;
@synthesize promotion_activity_obj;
@synthesize application_type_obj;
@synthesize login_log_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"certificate_obj" : [Certificate class],
		@"credit_card_obj" : [Credit_Card class],
		@"promotion_activity_obj" : [Promotion_Activity class],
		@"application_type_obj" : [Application_Type class],
		@"login_log_obj" : [Login_Log class]
		};
}

@end
