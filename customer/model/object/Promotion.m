#import "Promotion.h"
#import "Customer.h"
#import "Promotion_Type.h"
#import "Application_Type.h"

@implementation Promotion

@synthesize promotion_id;
@synthesize promotion_type_id;
@synthesize customer_id;
@synthesize promotion_code;
@synthesize description;
@synthesize expiration_date;
@synthesize entry_date_utc_stamp;
@synthesize customer_obj;
@synthesize promotion_type_obj;
@synthesize link;
@synthesize application_type_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"customer_obj" : [Customer class],
		@"promotion_type_obj" : [Promotion_Type class],
		@"application_type_obj" : [Application_Type class]
		};
}

@end
