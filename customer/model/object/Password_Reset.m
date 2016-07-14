#import "Password_Reset.h"
#import "Contact.h"
#import "Password_Reset_Status.h"

@implementation Password_Reset

@synthesize reset_id;
@synthesize status_id;
@synthesize contact_id;
@synthesize email;
@synthesize entry_date_utc_stamp;
@synthesize expiration_date;
@synthesize contact_obj;
@synthesize password_reset_status_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"contact_obj" : [Contact class],
		@"password_reset_status_obj" : [Password_Reset_Status class]
		};
}

@end
