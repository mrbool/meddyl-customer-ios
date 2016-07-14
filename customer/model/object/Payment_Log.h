#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Certificate;
@class Customer;
@class Deal;
@class Merchant_Contact;

@interface Payment_Log : BaseClass
{

}

@property (nonatomic, strong) NSNumber *log_id;
@property (nonatomic, strong) NSNumber *payment_id;
@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSNumber *certificate_id;
@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSNumber *credit_card_id;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, retain) NSNumber *is_successful;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Certificate *certificate_obj;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, strong) Deal *deal_obj;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;

@end
