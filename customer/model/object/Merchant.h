#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Industry;
@class Merchant_Rating;
@class Merchant_Status;
@class Neighborhood;
@class Zip_Code;
@class Industry;

@interface Merchant : BaseClass
{

}

@property (nonatomic, strong) NSNumber *merchant_id;
@property (nonatomic, strong) NSNumber *industry_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSString *zip_code;
@property (nonatomic, strong) NSNumber *neighborhood_id;
@property (nonatomic, strong) NSNumber *rating_id;
@property (nonatomic, strong) NSString *company_name;
@property (nonatomic, strong) NSString *address_1;
@property (nonatomic, strong) NSString *address_2;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *max_active_deals;
@property (nonatomic, strong) NSString *yelp_business_id;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Industry *industry_obj;
@property (nonatomic, strong) Merchant_Rating *merchant_rating_obj;
@property (nonatomic, strong) Merchant_Status *merchant_status_obj;
@property (nonatomic, strong) Neighborhood *neighborhood_obj;
@property (nonatomic, strong) Zip_Code *zip_code_obj;
@property (nonatomic, strong) NSString *image_base64;
@property (nonatomic, strong) Industry *top_industry_obj;

@end
