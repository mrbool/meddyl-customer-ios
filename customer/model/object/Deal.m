#import "Deal.h"
#import "Deal_Status.h"
#import "Deal_Validation.h"
#import "Merchant_Contact.h"
#import "Promotion_Activity.h"
#import "Time_Zone.h"
#import "Application_Type.h"
#import "Login_Log.h"

@implementation Deal

@synthesize deal_id;
@synthesize merchant_contact_id;
@synthesize status_id;
@synthesize promotion_activity_id;
@synthesize validation_id;
@synthesize time_zone_id;
@synthesize deal;
@synthesize fine_print;
@synthesize fine_print_ext;
@synthesize percent_off;
@synthesize max_dollar_amount;
@synthesize certificate_quantity;
@synthesize expiration_date;
@synthesize image;
@synthesize deal_amount;
@synthesize certificate_amount;
@synthesize certificate_days_valid;
@synthesize certificate_delay_hours;
@synthesize use_deal_immediately;
@synthesize is_valid_new_customer_only;
@synthesize instructions;
@synthesize ranking;
@synthesize entry_date_utc_stamp;
@synthesize deal_status_obj;
@synthesize deal_validation_obj;
@synthesize merchant_contact_obj;
@synthesize promotion_activity_obj;
@synthesize time_zone_obj;
@synthesize derived_text_1;
@synthesize derived_text_2;
@synthesize distance;
@synthesize certificates_remaining;
@synthesize certificates_sold;
@synthesize certificates_redeemed;
@synthesize certificates_unused;
@synthesize certificates_expired;
@synthesize last_redeemed_date;
@synthesize last_assigned_date;
@synthesize image_base64;
@synthesize search;
@synthesize fine_print_option_obj_array;
@synthesize application_type_obj;
@synthesize login_log_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"deal_status_obj" : [Deal_Status class],
		@"deal_validation_obj" : [Deal_Validation class],
		@"merchant_contact_obj" : [Merchant_Contact class],
		@"promotion_activity_obj" : [Promotion_Activity class],
		@"time_zone_obj" : [Time_Zone class],
		@"application_type_obj" : [Application_Type class],
		@"login_log_obj" : [Login_Log class]
		};
}

@end
