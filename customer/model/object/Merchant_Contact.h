#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Contact;
@class Merchant;
@class Merchant_Contact_Status;
@class Merchant_Contact_Validation;
@class Login_Log;

@interface Merchant_Contact : BaseClass
{

}

@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSNumber *merchant_id;
@property (nonatomic, strong) NSNumber *contact_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSNumber *validation_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *accept_terms_date_utc_stamp;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Contact *contact_obj;
@property (nonatomic, strong) Merchant *merchant_obj;
@property (nonatomic, strong) Merchant_Contact_Status *merchant_contact_status_obj;
@property (nonatomic, strong) Merchant_Contact_Validation *merchant_contact_validation_obj;
@property (nonatomic, strong) NSString *search;
@property (nonatomic, strong) Login_Log *login_log_obj;

@end
