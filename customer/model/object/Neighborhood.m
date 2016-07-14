#import "Neighborhood.h"
#import "Zip_Code.h"

@implementation Neighborhood

@synthesize neighborhood_id;
@synthesize zip_code;
@synthesize neighborhood;
@synthesize zip_code_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"zip_code_obj" : [Zip_Code class]
		};
}

@end
