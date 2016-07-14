#import "Payment_Log.h"
#import "Certificate.h"
#import "Customer.h"
#import "Deal.h"
#import "Merchant_Contact.h"

@implementation Payment_Log

@synthesize log_id;
@synthesize payment_id;
@synthesize deal_id;
@synthesize certificate_id;
@synthesize merchant_contact_id;
@synthesize customer_id;
@synthesize credit_card_id;
@synthesize amount;
@synthesize is_successful;
@synthesize type;
@synthesize notes;
@synthesize entry_date_utc_stamp;
@synthesize certificate_obj;
@synthesize customer_obj;
@synthesize deal_obj;
@synthesize merchant_contact_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"certificate_obj" : [Certificate class],
		@"customer_obj" : [Customer class],
		@"deal_obj" : [Deal class],
		@"merchant_contact_obj" : [Merchant_Contact class]
		};
}

@end
