#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Application_Type;
@class Contact;
@class Customer;
@class Merchant_Contact;

@interface Login_Log : BaseClass
{

}

@property (nonatomic, strong) NSNumber *log_id;
@property (nonatomic, strong) NSNumber *contact_id;
@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSNumber *application_type_id;
@property (nonatomic, retain) NSNumber *registered;
@property (nonatomic, retain) NSNumber *auto_login;
@property (nonatomic, strong) NSString *ip_address;
@property (nonatomic, strong) NSDate *login_date_utc_stamp;
@property (nonatomic, strong) NSString *auth_token;
@property (nonatomic, strong) Application_Type *application_type_obj;
@property (nonatomic, strong) Contact *contact_obj;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;

@end
