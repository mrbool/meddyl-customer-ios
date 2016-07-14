#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Deal_Status;
@class Deal_Validation;
@class Merchant_Contact;
@class Promotion_Activity;
@class Time_Zone;
@class Application_Type;
@class Login_Log;

@interface Deal : BaseClass
{

}

@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSNumber *promotion_activity_id;
@property (nonatomic, strong) NSNumber *validation_id;
@property (nonatomic, strong) NSNumber *time_zone_id;
@property (nonatomic, strong) NSString *deal;
@property (nonatomic, strong) NSString *fine_print;
@property (nonatomic, strong) NSString *fine_print_ext;
@property (nonatomic, strong) NSNumber *percent_off;
@property (nonatomic, strong) NSDecimalNumber *max_dollar_amount;
@property (nonatomic, strong) NSNumber *certificate_quantity;
@property (nonatomic, strong) NSDate *expiration_date;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSDecimalNumber *deal_amount;
@property (nonatomic, strong) NSDecimalNumber *certificate_amount;
@property (nonatomic, strong) NSNumber *certificate_days_valid;
@property (nonatomic, strong) NSNumber *certificate_delay_hours;
@property (nonatomic, retain) NSNumber *use_deal_immediately;
@property (nonatomic, retain) NSNumber *is_valid_new_customer_only;
@property (nonatomic, strong) NSString *instructions;
@property (nonatomic, strong) NSNumber *ranking;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Deal_Status *deal_status_obj;
@property (nonatomic, strong) Deal_Validation *deal_validation_obj;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;
@property (nonatomic, strong) Promotion_Activity *promotion_activity_obj;
@property (nonatomic, strong) Time_Zone *time_zone_obj;
@property (nonatomic, strong) NSString *derived_text_1;
@property (nonatomic, strong) NSString *derived_text_2;
@property (nonatomic, strong) NSDecimalNumber *distance;
@property (nonatomic, strong) NSNumber *certificates_remaining;
@property (nonatomic, strong) NSNumber *certificates_sold;
@property (nonatomic, strong) NSNumber *certificates_redeemed;
@property (nonatomic, strong) NSNumber *certificates_unused;
@property (nonatomic, strong) NSNumber *certificates_expired;
@property (nonatomic, strong) NSDate *last_redeemed_date;
@property (nonatomic, strong) NSDate *last_assigned_date;
@property (nonatomic, strong) NSString *image_base64;
@property (nonatomic, strong) NSString *search;
@property (nonatomic, copy) NSMutableArray *fine_print_option_obj_array;
@property (nonatomic, strong) Application_Type *application_type_obj;
@property (nonatomic, strong) Login_Log *login_log_obj;

@end
