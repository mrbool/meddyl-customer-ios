#import "City.h"
#import "State.h"

@implementation City

@synthesize city_id;
@synthesize state_id;
@synthesize city;
@synthesize state_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"state_obj" : [State class]
		};
}

@end
