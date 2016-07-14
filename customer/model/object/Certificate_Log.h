#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Certificate;
@class Certificate_Status;
@class Customer;
@class Merchant_Contact;

@interface Certificate_Log : BaseClass
{

}

@property (nonatomic, strong) NSNumber *log_id;
@property (nonatomic, strong) NSNumber *certificate_id;
@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Certificate *certificate_obj;
@property (nonatomic, strong) Certificate_Status *certificate_status_obj;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;

@end
