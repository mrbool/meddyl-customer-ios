#import "Contact_GPS_Log.h"
#import "Contact.h"

@implementation Contact_GPS_Log

@synthesize log_id;
@synthesize contact_id;
@synthesize latitude;
@synthesize longitude;
@synthesize entry_date_utc_stamp;
@synthesize contact_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"contact_obj" : [Contact class]
		};
}

@end
