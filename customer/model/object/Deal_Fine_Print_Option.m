#import "Deal_Fine_Print_Option.h"
#import "Deal.h"
#import "Fine_Print_Option.h"

@implementation Deal_Fine_Print_Option

@synthesize id;
@synthesize deal_id;
@synthesize option_id;
@synthesize deal_obj;
@synthesize fine_print_option_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"deal_obj" : [Deal class],
		@"fine_print_option_obj" : [Fine_Print_Option class]
		};
}

@end
