#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Credit_Card_Type;
@class Customer;
@class Merchant_Contact;
@class Application_Type;
@class Login_Log;

@interface Credit_Card : BaseClass
{

}

@property (nonatomic, strong) NSNumber *credit_card_id;
@property (nonatomic, strong) NSNumber *type_id;
@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSString *card_holder_name;
@property (nonatomic, strong) NSString *card_number;
@property (nonatomic, strong) NSData *card_number_encrypted;
@property (nonatomic, strong) NSString *expiration_date;
@property (nonatomic, strong) NSString *billing_zip_code;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, retain) NSNumber *default_flag;
@property (nonatomic, retain) NSNumber *deleted;
@property (nonatomic, strong) Credit_Card_Type *credit_card_type_obj;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;
@property (nonatomic, strong) Application_Type *application_type_obj;
@property (nonatomic, strong) Login_Log *login_log_obj;

@end
