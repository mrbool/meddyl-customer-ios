#import "Industry.h"
#import "Industry.h"

@implementation Industry

@synthesize industry_id;
@synthesize parent_industry_id;
@synthesize industry;
@synthesize image;
@synthesize order_id;
@synthesize industry_obj;
@synthesize active;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"industry_obj" : [Industry class]
		};
}

@end
