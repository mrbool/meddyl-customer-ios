#import "Deal_Validation.h"
#import "Deal.h"

@implementation Deal_Validation

@synthesize validation_id;
@synthesize deal_id;
@synthesize validation_code;
@synthesize is_validated;
@synthesize entry_date_utc_stamp;
@synthesize deal_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"deal_obj" : [Deal class]
		};
}

@end
