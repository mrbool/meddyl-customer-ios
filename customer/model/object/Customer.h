#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Contact;
@class Customer_Search_Location_Type;
@class Customer_Status;
@class Industry;
@class Zip_Code;
@class Application_Type;
@class Login_Log;
@class Promotion;

@interface Customer : BaseClass
{

}

@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSNumber *contact_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSNumber *search_location_type_id;
@property (nonatomic, strong) NSString *search_zip_code;
@property (nonatomic, strong) NSNumber *search_industry_id;
@property (nonatomic, strong) NSNumber *deal_range;
@property (nonatomic, strong) NSDate *accept_terms_date_utc_stamp;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Contact *contact_obj;
@property (nonatomic, strong) Customer_Search_Location_Type *customer_search_location_type_obj;
@property (nonatomic, strong) Customer_Status *customer_status_obj;
@property (nonatomic, strong) Industry *industry_obj;
@property (nonatomic, strong) Zip_Code *zip_code_obj;
@property (nonatomic, strong) Application_Type *application_type_obj;
@property (nonatomic, strong) Login_Log *login_log_obj;
@property (nonatomic, strong) Promotion *promotion_obj;

@end
