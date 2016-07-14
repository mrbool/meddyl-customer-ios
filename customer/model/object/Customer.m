#import "Customer.h"
#import "Contact.h"
#import "Customer_Search_Location_Type.h"
#import "Customer_Status.h"
#import "Industry.h"
#import "Zip_Code.h"
#import "Application_Type.h"
#import "Login_Log.h"
#import "Promotion.h"

@implementation Customer

@synthesize customer_id;
@synthesize contact_id;
@synthesize status_id;
@synthesize search_location_type_id;
@synthesize search_zip_code;
@synthesize search_industry_id;
@synthesize deal_range;
@synthesize accept_terms_date_utc_stamp;
@synthesize entry_date_utc_stamp;
@synthesize contact_obj;
@synthesize customer_search_location_type_obj;
@synthesize customer_status_obj;
@synthesize industry_obj;
@synthesize zip_code_obj;
@synthesize application_type_obj;
@synthesize login_log_obj;
@synthesize promotion_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"contact_obj" : [Contact class],
		@"customer_search_location_type_obj" : [Customer_Search_Location_Type class],
		@"customer_status_obj" : [Customer_Status class],
		@"industry_obj" : [Industry class],
		@"zip_code_obj" : [Zip_Code class],
		@"application_type_obj" : [Application_Type class],
		@"login_log_obj" : [Login_Log class],
		@"promotion_obj" : [Promotion class]
		};
}

@end
