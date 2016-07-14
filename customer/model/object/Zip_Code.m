#import "Zip_Code.h"
#import "City.h"
#import "Time_Zone.h"

@implementation Zip_Code

@synthesize zip_code;
@synthesize city_id;
@synthesize time_zone_id;
@synthesize latitude;
@synthesize longitude;
@synthesize city_obj;
@synthesize time_zone_obj;
@synthesize neighborhood_obj_array;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"city_obj" : [City class],
		@"time_zone_obj" : [Time_Zone class],
		};
}

@end
