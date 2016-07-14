#import "Certificate_Log.h"
#import "Certificate.h"
#import "Certificate_Status.h"
#import "Customer.h"
#import "Merchant_Contact.h"

@implementation Certificate_Log

@synthesize log_id;
@synthesize certificate_id;
@synthesize merchant_contact_id;
@synthesize customer_id;
@synthesize status_id;
@synthesize notes;
@synthesize entry_date_utc_stamp;
@synthesize certificate_obj;
@synthesize certificate_status_obj;
@synthesize customer_obj;
@synthesize merchant_contact_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"certificate_obj" : [Certificate class],
		@"certificate_status_obj" : [Certificate_Status class],
		@"customer_obj" : [Customer class],
		@"merchant_contact_obj" : [Merchant_Contact class]
		};
}

@end
