#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Certificate_Status;
@class Customer;
@class Deal;
@class Application_Type;
@class Login_Log;

@interface Certificate : BaseClass
{

}

@property (nonatomic, strong) NSNumber *certificate_id;
@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSString *certificate_code;
@property (nonatomic, strong) NSDate *assigned_date;
@property (nonatomic, strong) NSDate *start_date;
@property (nonatomic, strong) NSDate *expiration_date;
@property (nonatomic, strong) NSDate *redeemed_date;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Certificate_Status *certificate_status_obj;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, strong) Deal *deal_obj;
@property (nonatomic, strong) NSString *status_text_1;
@property (nonatomic, strong) NSString *status_text_2;
@property (nonatomic, strong) NSString *search;
@property (nonatomic, strong) Application_Type *application_type_obj;
@property (nonatomic, strong) Login_Log *login_log_obj;

@end
