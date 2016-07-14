#import "Promotion_Activity.h"
#import "Customer.h"
#import "Merchant_Contact.h"
#import "Promotion.h"
#import "Promotion_Activity.h"

@implementation Promotion_Activity

@synthesize promotion_activity_id;
@synthesize promotion_id;
@synthesize parent_activity_id;
@synthesize customer_id;
@synthesize merchant_contact_id;
@synthesize redeemed_date;
@synthesize expiration_date;
@synthesize entry_date_utc_stamp;
@synthesize customer_obj;
@synthesize merchant_contact_obj;
@synthesize promotion_obj;
@synthesize promotion_activity_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"customer_obj" : [Customer class],
		@"merchant_contact_obj" : [Merchant_Contact class],
		@"promotion_obj" : [Promotion class],
		@"promotion_activity_obj" : [Promotion_Activity class]
		};
}

@end
