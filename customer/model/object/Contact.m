#import "Contact.h"
#import "Zip_Code.h"

@implementation Contact

@synthesize contact_id;
@synthesize facebook_id;
@synthesize zip_code;
@synthesize first_name;
@synthesize last_name;
@synthesize email;
@synthesize phone;
@synthesize user_name;
@synthesize password;
@synthesize entry_date_utc_stamp;
@synthesize zip_code_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"zip_code_obj" : [Zip_Code class]
		};
}

@end
