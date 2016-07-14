#import "Merchant.h"
#import "Industry.h"
#import "Merchant_Rating.h"
#import "Merchant_Status.h"
#import "Neighborhood.h"
#import "Zip_Code.h"
#import "Industry.h"

@implementation Merchant

@synthesize merchant_id;
@synthesize industry_id;
@synthesize status_id;
@synthesize zip_code;
@synthesize neighborhood_id;
@synthesize rating_id;
@synthesize company_name;
@synthesize address_1;
@synthesize address_2;
@synthesize latitude;
@synthesize longitude;
@synthesize phone;
@synthesize website;
@synthesize description;
@synthesize image;
@synthesize max_active_deals;
@synthesize yelp_business_id;
@synthesize entry_date_utc_stamp;
@synthesize industry_obj;
@synthesize merchant_rating_obj;
@synthesize merchant_status_obj;
@synthesize neighborhood_obj;
@synthesize zip_code_obj;
@synthesize image_base64;
@synthesize top_industry_obj;

+ (NSDictionary *) specificationProperties
{
	return @{
		@"industry_obj" : [Industry class],
		@"merchant_rating_obj" : [Merchant_Rating class],
		@"merchant_status_obj" : [Merchant_Status class],
		@"neighborhood_obj" : [Neighborhood class],
		@"zip_code_obj" : [Zip_Code class],
		@"top_industry_obj" : [Industry class]
		};
}

@end
