#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Customer;
@class Merchant_Contact;
@class Promotion;
@class Promotion_Activity;

@interface Promotion_Activity : BaseClass
{

}

@property (nonatomic, strong) NSNumber *promotion_activity_id;
@property (nonatomic, strong) NSNumber *promotion_id;
@property (nonatomic, strong) NSNumber *parent_activity_id;
@property (nonatomic, strong) NSNumber *customer_id;
@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSDate *redeemed_date;
@property (nonatomic, strong) NSDate *expiration_date;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Customer *customer_obj;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;
@property (nonatomic, strong) Promotion *promotion_obj;
@property (nonatomic, strong) Promotion_Activity *promotion_activity_obj;

@end
