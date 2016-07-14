#import "Deal_Payment.h"
#import "Credit_Card.h"
#import "Deal.h"
#import "Promotion_Activity.h"
#import "Application_Type.h"

@implementation Deal_Payment

@synthesize payment_id;
@synthesize deal_id;
@synthesize credit_card_id;
@synthesize promotion_activity_id;
@synthesize card_holder_name;
@synthesize card_number;
@synthesize card_expiration_date;
@synthesize payment_amount;
@synthesize payment_date_utc_stamp;
@synthesize credit_card_obj;
@synthesize deal_obj;
@synthesize promotion_activity_obj;
@synthesize application_type_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"credit_card_obj" : [Credit_Card class],
		@"deal_obj" : [Deal class],
		@"promotion_activity_obj" : [Promotion_Activity class],
		@"application_type_obj" : [Application_Type class]
		};
}

@end
