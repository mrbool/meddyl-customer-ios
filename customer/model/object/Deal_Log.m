#import "Deal_Log.h"
#import "Deal.h"
#import "Deal_Status.h"
#import "Merchant_Contact.h"

@implementation Deal_Log

@synthesize log_id;
@synthesize deal_id;
@synthesize merchant_contact_id;
@synthesize status_id;
@synthesize notes;
@synthesize entry_date_utc_stamp;
@synthesize deal_obj;
@synthesize deal_status_obj;
@synthesize merchant_contact_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"deal_obj" : [Deal class],
		@"deal_status_obj" : [Deal_Status class],
		@"merchant_contact_obj" : [Merchant_Contact class]
		};
}

@end
