#import <Foundation/Foundation.h>
#import "BaseClass.h"

@class Deal;
@class Deal_Status;
@class Merchant_Contact;

@interface Deal_Log : BaseClass
{

}

@property (nonatomic, strong) NSNumber *log_id;
@property (nonatomic, strong) NSNumber *deal_id;
@property (nonatomic, strong) NSNumber *merchant_contact_id;
@property (nonatomic, strong) NSNumber *status_id;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSDate *entry_date_utc_stamp;
@property (nonatomic, strong) Deal *deal_obj;
@property (nonatomic, strong) Deal_Status *deal_status_obj;
@property (nonatomic, strong) Merchant_Contact *merchant_contact_obj;

@end
